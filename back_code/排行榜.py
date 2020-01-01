def Student_rank(request):
    students = Student.objects.all()
    coin_rank = {}
    for item in students:
        coin_rank[item.student_name] = item.coins
    coins_rank = dict(sorted(coin_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))

    word_rank = {}
    for item in students:
        word_rank[item.student_name] = item.word_numbers
    words_rank = dict(sorted(word_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))

    point_rank = {}
    for item in students:
        point_rank[item.student_name] = item.points
    points_rank = dict(sorted(point_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))

    # 返回给前端一个字典，字典中包括三个排行，每个排行的键值是字典，按照金币数、单词量、积分进行倒序排序。
    return JsonResponse({'coin_rank':coins_rank, 'word_rank':words_rank, 'point_rank':points_rank})
