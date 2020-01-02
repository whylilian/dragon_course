def Learn_statistics(request):
    studentid = request.POST.get('student_id')
    # studentid = 1
    wordnumber = len(StudentWords.objects.filter(student_id = studentid))

    test = Test.objects.filter(student_id = studentid)

    tests = {}
    for item in test:
        tests[item.test_type] = item.test_grade

    return JsonResponse({'wordnumber':wordnumber,'test':tests})