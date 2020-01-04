def TeacherMatchMessage(request):
    # teacherid = request.POST.get('teacher_id')
    teacherid = 1
    teacher = Teacher.objects.get(teacher_id = teacherid)
    matchs = Match.objects.filter(teacher_id = teacher.teacher_id)

    match_message = {}
    for item in matchs:
        match_message[item.match_id] = {
            'match_name':item.match_name,
            'start_time':item.start_time.strftime("%Y-%m-%d %H:%M:%S"),
            'end_time':item.end_time.strftime("%Y-%m-%d %H:%M:%S"),
            'match_time':item.match_time,
            'join_number':'5000'
        }
    return JsonResponse(match_message,json_dumps_params={'ensure_ascii':False})
