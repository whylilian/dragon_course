def Match_message(request):
    matchid = request.POST.get('match_id')
    # matchid = 1
    match = Match.objects.get(match_id = matchid)
    massage = {}
    massage["比赛名字"] = match.match_name
    massage["比赛时间"] = match.start_time.strftime("%Y-%m-%d %H:%M:%S") + ' - ' + match.end_time.strftime("%Y-%m-%d %H:%M:%S")
    
    teacherid = match.teacher_id
    teacher = Teacher.objects.get(teacher_id = teacherid)
    join_range = teacher.teacher_name + "的所有学生"
    massage["参赛范围"] = join_range

    courses = Course.objects.filter(teacher_id = teacherid)
    match_range = str()
    for item in courses:
        match_range = match_range + ' 、' + item.course_name
    match_range = match_range[1:]
    massage["比赛内容"] = match_range

    if match.match_name == "一站到底":
        massage["比赛规则"] = "系统挑选已参赛学员进行两两pk, 轮流答题, 直到有学员错三题定胜负"
    elif match.match_name == "擂台pk":
        massage["比赛规则"] = "7道题, 每道题12s, 题目分数:20*6+40"

    studentmatchs = StudentMatchs.objects.filter(match_id = matchid)
    score_rank = {}
    for item in studentmatchs:
        student = Student.objects.get(student_id = item.student_id)
        score_rank[student.student_name] = item.match_grade
    score_rank = dict(sorted(score_rank.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))


    return JsonResponse({"比赛详细信息":massage, "比赛排行榜":score_rank},json_dumps_params={'ensure_ascii':False})