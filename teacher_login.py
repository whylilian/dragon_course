# 教师:教师登录
def Teacher_login(request):
    try:
        # username = request.POST.get('teacher_username')
        # password = request.POST.get('teacher_password')
        username = 'test2'
        password = '123'
        data = {}
        teacher = Teacher.objects.get(teacher_username=username)
        data['teacher_id'] = teacher.teacher_id
        data['teacher_name'] = teacher.teacher_name
    except Teacher.DoesNotExist:
        data['login_status'] = 'error：用户名或密码错误'
        return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
    else:
        if student.student_password == password:
            data['login_status'] = 'succeed'
            return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
        else:
            data['login_status'] = '登录失败：用户名或密码错误'
            return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})