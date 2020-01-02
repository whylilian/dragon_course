def Match_commit(request):
    # studentid = request.POST.get('student_id')
    studentid = 1
    studentmatchs = StudentMatchs.objects.filter(student_id = studentid)

    commit = {}
    for item in studentmatchs:
        match = Match.objects.get(match_id = item.match_id)
        starttime = match.start_time.strftime("%Y-%m-%d %H:%M:%S")
        endtime = match.end_time.strftime("%Y-%m-%d %H:%M:%S")
        commit[match.match_id] = {
            'match':match.match_name,
            'start_time':starttime,
            'endtime':endtime,
            'join_time':item.join_time,
            'match_grade':item.match_grade
        }
    return JsonResponse(commit,json_dumps_params={'ensure_ascii':False})

def Match_uncommit(request):
    # studentid = request.POST.get('student_id')
    studentid = 1
    studentmatchs = StudentMatchs.objects.filter(student_id = studentid)

    matchs = Match.objects.all()
    unmatchs = set()
    for item in matchs:
        unmatchs.add(item.match_id)
    for item in studentmatchs:
        unmatchs.remove(item.match_id)
    print(unmatchs)
    uncommit = {}
    for item in matchs:
        if item.match_id in unmatchs:
            match = Match.objects.get(match_id = item.match_id)
            starttime = match.start_time.strftime("%Y-%m-%d %H:%M:%S")
            endtime = match.end_time.strftime("%Y-%m-%d %H:%M:%S")
            uncommit[match.match_id] = {
                'match':match.match_name,
                'teacher_name':match.teacher_name,
                'start_time':starttime,
                'end_time':endtime,
                'match_time':match.match_time
            }
    return JsonResponse(uncommit,json_dumps_params={'ensure_ascii':False})