

from django.shortcuts import render
from app.models import *
from django.http import JsonResponse
# Create your views here.

#处理学生登录请求，匹配账户和密码
def Student_login(request):
    try:
        username = request.POST.get('student_username')
        password = request.POST.get('student_password')
        print(username)
        print(password)
        student = Student.objects.get(student_username=username)
        print(student.student_name)
        data = {}
        data['student_id'] = student.student_id
        data['student_name'] = student.student_name
        data['coins'] = student.coins
    except Student.DoesNotExist:
        print('发生异常')
    else:
        if student.student_username==username and student.student_password==password:
            data['login_status'] = 'succeed'
            return JsonResponse(data, safe=False)
        else:
            data['login_status'] = 'failed'
            return JsonResponse(data, safe=False)

#获取学生的学习状态
def GetStudentStatus(request):
    try:
        student_id = int(request.POST.get('student_id'))
        student = Student.objects.get(student_id=student_id)
        study_status = student.study_status
        data = {}
        data['study_status'] = study_status
    except Student.DoesNotExist:
        print('发生异常')
    else:
        return JsonResponse(data, safe=False)

#获取排行榜信息
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
    return JsonResponse({'coin_rank':coins_rank, 'word_rank':words_rank, 'point_rank':points_rank}, json_dumps_params={'ensure_ascii':False})

#返回单词本数据
def Word_book(request):
    # order = request.POST.get('review_order')
    # studentid = request.POST.get('student_id')
    # order = 'letter'
    order = 'familiarity'
    studentid = 1

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


#单词拼写检测
def Check_spell(request):
    # wordid = request.POST.get('word_id')
    # spell = request.POST.get('spell')
    # studentid = request.POST.get('student_id')
    wordid = 1
    spell = 'question'
    studentid = 1
    word = Words.objects.get(word_id = wordid)
    student_word = StudentWords.objects.get(student_id = studentid,words_id = wordid)

    if word.word == spell:
        if student_word.counts < student_word.value:
            student_word.counts += 1
            student_word.save()
        # 返回正确的单词（键）和是否正确中文（键值）
        return JsonResponse({word.word:"正确"},json_dumps_params={'ensure_ascii':False})
    else:
        if student_word.counts > 0:
            student_word.counts -= 1
            student_word.save()
        return JsonResponse({word.word:"错误"},json_dumps_params={'ensure_ascii':False})

#获取学生学习状态
def Study_status(request):
    # studentid = request.POST.get('student_id')
    studentid = 1
    student = Student.objects.get(student_id = studentid)
    return JsonResponse({'status':student.study_status})

#返回学生已参加比赛的信息接口
def Match_commit(request):
    studentid = request.POST.get('student_id')
    # studentid = 1
    studentmatchs = StudentMatchs.objects.filter(student_id = studentid)

    commit = {}
    for item in studentmatchs:
        match = Match.objects.get(match_id = item.match_id)
        # 将数据库中的datetime类型去除T/Z
        starttime = match.start_time.strftime("%Y-%m-%d %H:%M:%S")
        endtime = match.end_time.strftime("%Y-%m-%d %H:%M:%S")
        jointime = item.join_time.strftime("%Y-%m-%d %H:%M:%S")
        commit[match.match_id] = {
            'match':match.match_name,
            'start_time':starttime,
            'end_time':endtime,
            'join_time':jointime,
            'match_grade':item.match_grade
        }
    return JsonResponse(commit,json_dumps_params={'ensure_ascii':False})

#学生未参加的比赛信息
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
    # print(unmatchs)
    uncommit = {}
    for item in matchs:
        if item.match_id in unmatchs:
            match = Match.objects.get(match_id = item.match_id)
            # 将数据库中的datetime类型去除T/Z
            starttime = match.start_time.strftime("%Y-%m-%d %H:%M:%S")
            endtime = match.end_time.strftime("%Y-%m-%d %H:%M:%S")
            uncommit[match.match_id] = {
                'match':match.match_name,
                'teacher_name':match.teacher_name,
                'start_time':starttime,
                'end_time':endtime,
                # 比赛答题时间
                'match_time':match.match_time
            }
    return JsonResponse(uncommit,json_dumps_params={'ensure_ascii':False})

#教师创建比赛
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

#获取学生的学习统计
def Learn_statistics(request):
    studentid = request.POST.get('student_id')
    # studentid = 1
    wordnumber = len(StudentWords.objects.filter(student_id = studentid))

    test = Test.objects.filter(student_id = studentid)

    tests = {}
    for item in test:
        tests[item.test_type] = item.test_grade

    return JsonResponse({'wordnumber':wordnumber,'test':tests}) 

#返回比赛详细信息
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

#学生名册
def Student_list(request):
    # coursename = request.POST.get('course_name')
    coursename = "七年级上册"
    course = Course.objects.get(course_name = coursename)
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

#修改密码
def Change_password(request):
    # 存取控制
    studentid = request.POST.get('student_id')
    new_password = request.POST.get('new_password')
    studentid = 2
    student = Student.objects.get(student_id = studentid)
    student.student_password = new_password
    student.save()
    return JsonResponse({'change_status':'密码修改成功'},safe = False,json_dumps_params={'ensure_ascii':False})

#查看学生学习单词量
def Study_census(request):
    # coursename = request.POST.get('course_name')
    coursename = "七年级上册"
    course = Course.objects.get(course_name = coursename)
    students = Student.objects.filter(course_id = course.course_id)
    student_words = {}
    for item in students:
        student_words[item.student_name] = item.word_numbers
        
    return JsonResponse(student_words,json_dumps_params={'ensure_ascii':False})

#教师端查看比赛信息
def TeacherMatchMessage(request):
    # teacherid = request.POST.get('teacher_id')
    teacherid = 1
    teacher = Teacher.objects.get(teacher_id = teacherid)
    matchs = Match.objects.filter(teacher_id = teacher.teacher_id)

    match_message = {}
    for item in matchs:
        match_message[item.match_id] = {
            'match_name':item.match_name,
            'start_time':item.start_time.strftime("%Y-%m-%d %H:%M:%S"),
            'end_time':item.end_time.strftime("%Y-%m-%d %H:%M:%S"),
            'match_time':item.match_time,
            'join_number':'5000'
        }
    return JsonResponse(match_message,json_dumps_params={'ensure_ascii':False})