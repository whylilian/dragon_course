def Create_match(request):
    name = request.POST.get('match_name')
    # name = "一站到底"
    # 比赛总分
    matchpoint = request.POST.get('match_point')
    # matchpoint = 100

    bookname = request.POST.get('book_name')
    # bookname = "七年级英语"
    category = Category.objects.get(book_name = bookname)
    wordids = Classification.objects.filter(
        category_id = category.category_id).order_by('word_id').values('word_id')
    print(wordids,type(wordids))
    words = str()
    for item in wordids:
        words = words + '|' +str(item['word_id'])
    words = words[1:]
    
    teacherid = request.POST.get('teacher_id')
    # teacherid = 2
    teacher = Teacher.objects.get(teacher_id = teacherid)
    teachername = teacher.teacher_name
    starttime = request.POST.get('start_time').strftime("%Y-%m-%d %H:%M:%S")
    endtime = request.POSt.get('end_time').strftime("%Y-%m-%d %H:%M:%S")
    matchtime = request.POST.get('match_time').strftime("%Y-%m-%d %H:%M:%S")
    # starttime = "2020-01-01 15:09:17"
    # endtime = "2020-01-01 15:09:17"
    # matchtime = "00:10:00"
    m = Match(
        match_name = name, 
        match_point = matchpoint,
        words_id = words,
        teacher_id = teacherid,
        teacher_name = teachername,
        start_time = starttime,
        end_time = endtime,
        match_time = matchtime
    )
    m.save()
    return JsonResponse(None,safe = False)