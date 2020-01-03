def Study_census(request):
    # coursename = request.POST.get('course_name')
    coursename = "七年级上册"
    course = Course.objects.get(course_name = coursename)
    students = Student.objects.filter(course_id = course.course_id)
    student_words = {}
    for item in students:
        student_words[item.student_name] = item.word_numbers
        
    return JsonResponse(student_words,json_dumps_params={'ensure_ascii':False})