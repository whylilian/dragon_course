def Word_book(request):
    # order = request.POST.get('review_order')
    # studentid = request.POST.get('student_id')
    order = 'letter'
    # order = 'familiarity'
    studentid = 2

    words = Words.objects.all()
    word_rank = {}
    for item in words:
        studentword = StudentWords.objects.get(student_id = studentid, words_id = item.word_id)
        word_rank[item.word] = studentword.counts/studentword.value

    wordrank = {}
    if order == 'familiarity':
        wordrank = dict(sorted(word_rank.items(), key= lambda kv:(kv[1],kv[0])))
    elif order == 'letter':
        for i in sorted(word_rank):
            wordrank[i] = word_rank[i]

    for key,value in wordrank.items():
        if value == 0:
            wordrank[key] = 1
        elif value == 1:
            wordrank[key] = 3
        else:
            wordrank[key] = 2

    return JsonResponse(wordrank)