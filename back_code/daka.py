# 学生打卡
def daka(request):
    # student_id = request.POST.get('student_id')
    student_id = 2
    try:
        calendar = Calendar.objects.get(student_id = student_id)
    except Calendar.DoesNotExist:
        print("sada")
        calendar = Calendar(student_id = student_id, calendar_time = "")
        calendar.save()
    log = calendar.calendar_time.split('|')
    data = {}
    now_date = datetime.datetime.now().strftime('%Y-%m-%d')
    if log[-1] == now_date:
        data['status'] = 'already sign in'
        data['daka_num'] = len(log)
        return JsonResponse(data)

    # 更改能否打卡
    student = Student.objects.get(student_id = student_id)
    lastlogin_time = student.lastlogin_time
    now_time = datetime.datetime.now().strftime('%Y-%m-%d')
    if lastlogin_time != now_time:
        student.enable_daka = 0
    else:
        student.enable_daka = 1

    if calendar.calendar_time != "" and student.enable_daka == 0:
        calendar.calendar_time += '|' + now_date
        data['daka_num'] = len(log) + 1
    else:
        calendar.calendar_time = now_date
        data['daka_num'] = 1
    calendar.save()
    # 加金币
    student.coins += 1
    student.enable_daka = 1
    student.save()
    data['status'] = 'daka successfully'
    return JsonResponse(data)