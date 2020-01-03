def Student_list(request):
    # coursename = request.POST.get('course_name')
    coursename = "七年级上册"
    course = Course.objects.get(course_name = "七年级上册")
    students = Student.objects.filter(course_id = course.course_id)
    student_message = {}
    for item in students:
        student_message[item.student_name] = {
            # 'email':item.email,
            'coins':item.coins,
            # 'last_login':item.last_logintime,
            'student_id':item.student_id,
            'course_name':course.course_name,
            "所在组":'xfinit',
            'register_time':'2020-1-3 16:46:30',
            'status':"付费"
        }
    return JsonResponse(student_message,json_dumps_params={'ensure_ascii':False})