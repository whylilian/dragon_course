def Change_password(request):
    # 存取控制
    # studentid = request.POST.get('student_id')
    # oldpassword = request.POST.get('old_password')
    # newpassword = request.POST.get('new_password')
    studentid = 2
    oldpassword = '456'
    newpassword = '374563' 
    student = Student.objects.get(student_id = studentid)
    if student.student_password == oldpassword:
        student.student_password = newpassword
        student.save()
        return JsonResponse({'change_status':'succeed'},safe = False)
    else:
        return JsonResponse({'change_status':'failed'},safe = False)