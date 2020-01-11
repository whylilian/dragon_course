# -*- coding:UTF-8 -*-

from django.shortcuts import render
from app.models import *
from django.http import JsonResponse
import random,datetime
# Create your views here.

# 学生:处理学生登录请求，匹配账户和密码
def Student_login(request):
    try:
        username = request.POST.get('student_username')
        password = request.POST.get('student_password')
        # username = 'cmily'
        # password = '374563'
        data = {}
        student = Student.objects.get(student_username = username)
        data['student_id'] = student.student_id
        data['student_name'] = student.student_name
        data['coins'] = student.coins
    except Student.DoesNotExist:
        data['login_status'] = 'not_exist'
        return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})

    # 更改能否打卡
    now_time = datetime.datetime.now().strftime('%Y-%m-%d')
    try:
        calendar = Calendar.objects.get(student_id = student.student_id)
        log = calendar.calendar_time.split('|')
        lastdaka_time = log[-1]
        print(lastdaka_time)
        if lastdaka_time != now_time:
            student.enable_daka = 0
        else:
            student.enable_daka = 1

        data['daka_num'] = len(log)
        data['enable_daka'] = student.enable_daka
    except Calendar.DoesNotExist:
        student.enable_daka = 0
        data['daka_num'] = 0
        data['enable_daka'] = 0

    if student.student_password == password:
        data['login_status'] = 'succeed'
        student.lastlogin_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        student.save()
        return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
    else:
        student.save()
        data['login_status'] = 'failed'
        return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})

# 学生打卡
def daka(request):
    student_id = int(request.POST.get('student_id'))
    student = Student.objects.get(student_id = student_id)
    try:
        calendar = Calendar.objects.get(student_id = student_id)
    except Calendar.DoesNotExist:
        calendar = Calendar(student_id = student_id, calendar_time = "")
        calendar.save()

    log = calendar.calendar_time.split('|')
    data = {}
    now_date = datetime.datetime.now().strftime('%Y-%m-%d')
    if log[-1] == now_date:
        data['status'] = 'already sign in'
        data['daka_num'] = len(log)
        return JsonResponse(data)

    if calendar.calendar_time != "" and student.enable_daka == 0:
        calendar.calendar_time += '|' + now_date
        data['daka_num'] = len(log) + 1
    elif calendar.calendar_time == "" and student.enable_daka == 0:
        calendar.calendar_time = now_date
        data['daka_num'] = 1
    calendar.save()
    # 加金币
    student.coins += 10
    student.enable_daka = 1
    data['coins'] = student.coins
    data['enable_daka'] = student.enable_daka
    student.save()
    data['status'] = 'daka successfully'
    return JsonResponse(data)


#获取学生的学习状态
def Study_status(request):
    try:
        student_id = int(request.POST.get('student_id'))
        student = Student.objects.get(student_id = student_id)
        course = Course.objects.get(course_id = student.course_id)
        data = {}
        data['study_status'] = student.study_status
        data['course_name'] = course.course_name
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

# 学生单词本
def Word_book(request):
    order = request.POST.get('order')
    student_id = int(request.POST.get('student_id'))

    # 先获得学生的所有单词
    student_words = StudentWords.objects.filter(student_id = student_id)
    words = {}
    for item in student_words:
        word = Words.objects.get(word_id = item.words_id)
        words[word.word] = item.counts/item.value
    # 根据排序方式进行排序
    word_rank = {}
    if order == 'familiarity':
        word_rank = dict(sorted(words.items(), key= lambda kv:(kv[1],kv[0])))
    elif order == 'letter':
        word_rank = dict(sorted(words.items()))

    data = {}
    i = 1
    # 读入数据
    for key,value in word_rank.items():
        word = Words.objects.get(word = key)
        if value == 0:
            value = 1
        elif value == 1:
            value = 3
        else:
            value = 2
        
        data[i] = {
            'spell':key,
            'mean':word.means,
            'degree':value
        }
        i = i + 1
    return JsonResponse(data,json_dumps_params={'ensure_ascii':False})

#单词拼写检测
def Check_spell(request):
    # 前端传入单词ID，学生拼写，学生ID
    # wordid = request.POST.get('word_id')
    # spell = request.POST.get('spell')
    # studentid = request.POST.get('student_id')
    wordid = 5
    spell = 'statiC'
    studentid = 1
    word = Words.objects.get(word_id = wordid)
    student_word = StudentWords.objects.get(student_id = studentid,words_id = word.word_id)

    data = {}
    if word.word.lower() == spell.lower():
        if student_word.counts < student_word.value:
            student_word.counts += 1
            student_word.save()
        # 返回正确的单词（键）和是否正确中文（键值）
        data[word.word] = "正确"
        return JsonResponse(data,json_dumps_params={'ensure_ascii':False})
    else:
        if student_word.counts > 0:
            student_word.counts -= 1
            student_word.save()
        data[word.word] = "错误"
        return JsonResponse(data,json_dumps_params={'ensure_ascii':False})

# 获得课程单词书列表
def Get_books(request):
    student_id = int(request.POST.get('student_id'))
    student = Student.objects.get(student_id = student_id)
    enable = student.books_enable.split('|')

    books = student.books_id.split('|')
    books_list = {}
    for index,item in enumerate(books):
        bookid = int(item)
        book = Category.objects.get(category_id = bookid)
        book_message = {
            'book_name':book.book_name,
            'book_id': book.category_id,
            'enable':enable[index],
            'create_time':book.create_time.strftime("%Y-%m-%d %H:%M:%S")
        }
        books_list[book.sequence] = book_message 

    books_list = dict(sorted(books_list.items()))

    return JsonResponse(books_list,json_dumps_params={'ensure_ascii':False})


# 参加过的比赛
# 学生:只可以参加自己老师的比赛，未参加的比赛
def Match_show(request):
    student_id = int(request.POST.get('student_id'))
    studentmatchs = StudentMatchs.objects.filter(student_id = student_id)

    # 学生参加过的比赛
    commit = {}
    i = 1
    for item in studentmatchs:
        match = Match.objects.get(match_id = item.match_id)
        starttime = match.start_time.strftime("%m.%d")
        endtime = match.end_time.strftime("%m.%d")

        matchs = StudentMatchs.objects.filter(match_id = item.match_id).order_by('match_grade')
        for i in range(0,len(matchs)):
            if matchs[i].student_id == student_id:
                rank = len(matchs) - i
                break

        commit[i] = {
            'match_id':match.match_id,
            'match':match.match_name,
            'start_time':starttime,
            'end_time':endtime,
            'join_time':item.join_time,
            'match_grade':item.match_grade,
            'match_rank':rank
            
        }
        i = i + 1

    # 学生未参加过的比赛
    student = Student.objects.get(student_id = student_id)
    course = Course.objects.get(course_id = student.course_id)
    # 检索出所有该课程老师的比赛
    matchs = Match.objects.filter(teacher_id = course.teacher_id)
    unmatchs = set()
    for item in matchs:
        unmatchs.add(item.match_id)
    # 移除参加过的项目
    for item in studentmatchs:
        unmatchs.remove(item.match_id)

    uncommit = {}
    i = 1
    for item in matchs:
        if item.match_id in unmatchs:
            match = Match.objects.get(match_id = item.match_id)
            starttime = match.start_time.strftime("%m.%d")
            endtime = match.end_time.strftime("%m.%d")
            uncommit[i] = {
                'match_id':match.match_id,
                'match':match.match_name,
                'teacher_name':match.teacher_name,
                'start_time':starttime,
                'end_time':endtime,
                'match_time':match.match_time
            }
    data = {'commit':commit,'uncommit':uncommit}
    return JsonResponse(data,json_dumps_params={'ensure_ascii':False})


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

#学生端获取学生的学习统计
def Student_statistics(request):
    student_id = request.POST.get('student_id')
    word_numbers = len(StudentWords.objects.filter(student_id = student_id))

    tests = Test.objects.filter(student_id = student_id)

    tests_type = {}
    tests_grade = {}
    
    for i in range(len(tests)):
        tests_type[i] = tests[i].test_type
        tests_grade[i] = tests[i].test_grade
    return JsonResponse({'word_numbers':word_numbers,'tests_type':tests_type,'tests_grade':tests_grade},safe = False) 

# 学生:返回比赛详细信息
def Match_message(request):
    match_id = int(request.POST.get('match_id'))
    student_id = int(request.POST.get('student_id'))
    match = Match.objects.get(match_id = match_id)
    # 关于比赛的详细信息，名称和时间
    massage = {}
    massage["match_name"] = match.match_name
    massage["match_time"] = match.start_time.strftime("%Y-%m-%d %H:%M") + ' - ' + match.end_time.strftime("%Y-%m-%d %H:%M")

    student_ids = StudentMatchs.objects.filter(match_id = match_id)
    massage["isjoin"] = 0
    for item in student_ids:
        if student_id == item.student_id:
            massage["isjoin"] = 1
    
    # 比赛范围
    teacher = Teacher.objects.get(teacher_id = match.teacher_id)
    massage["match_scope"] = teacher.teacher_name + "的所有学生"

    # 比赛内容
    courses = Course.objects.filter(teacher_id = match.teacher_id)
    match_range = str()
    for item in courses:
        books = item.course_book_id.split('|')
        for item1 in books:
            book = Category.objects.get(category_id = int(item1))    
            match_range += book.book_name + '、'
    match_range = match_range[:-1]
    massage["match_message"] = match_range

    # 比赛规则
    if match.match_name == "一站到底":
        massage["match_rule"] = "7道题, 每道题12s, 题目分数:20*6+40"
    elif match.match_name == "擂台pk":
        massage["match_rule"] = "系统挑选已参赛学员进行两两pk, 轮流答题, 直到有学员错三题定胜负"

    # 该比赛的排名
    studentmatchs = StudentMatchs.objects.filter(match_id = match_id)
    score_ranks = {}
    for item in studentmatchs:
        student = Student.objects.get(student_id = item.student_id)
        score_ranks[student.student_name] = item.match_grade
    score_ranks = dict(sorted(score_ranks.items(),key = lambda kv:(kv[1],kv[0]), reverse = True))
    i = 1
    # 更改字典形式
    score_rank = {}
    for key,value in score_ranks.items():
        score_rank[i] = {
            'student_name':key,
            'match_grade':value
        }
        i = i + 1
    return JsonResponse({"match_detail":massage, "match_rank":score_rank},json_dumps_params={'ensure_ascii':False})



#学生名册
def Student_list(request):
    # coursename = request.POST.get('course_name')
    coursename = "初一进步班"
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
    student_id = request.POST.get('student_id')
    new_password = request.POST.get('new_password')
    student = Student.objects.get(student_id = student_id)
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

# 默认前端首先获得单词书列表，用户选择单词书在返回到后端
def Test_all(request):
    student_id = request.POST.get('student_id')
    student = Student.objects.get(student_id = student_id)
    course = Course.objects.get(course_id = student.course_id)
    books = course.course_book_id.split('|')
    # 用集合保存所有单词
    words = set()
    for item in books:
        book_id = int(item)
        book_words = Classification.objects.filter(category_id = book_id).order_by('word_id')
        for word_item in book_words:
            words.add(word_item.word_id)

    i = 0
    words_list = {}
    # all_words = Words.objects.all()
    for item in words:
        # if item.word_id in words:
        words_list[i] = item
        i = i + 1


    # 从当前单词书中获得随机的n个不重复的单词
    n = 28
    index_list = random.sample(range(0,len(words_list)),n)
    # 测试的所有数据
    test_list = {}
    # 错误的三个单词字典
    errorwords = {}
    
    # 获得所有单词的数量，从所有单词里随机抽取，默认单词id自动递增无缺漏
    allwords = Words.objects.all()
    num = len(allwords)

    correct = str()
    # 录入测试单词数据及其选项
    i = 1
    for item in index_list:
        word = Words.objects.get(word_id = words_list[item])
        
        # 随机生成一个正确选项
        correct_id = random.randint(1,4)
        # 随机生成四个错误选项
        for index in range(4):
            random_id = random.randint(1,num)
            while random_id == word.word_id:
                random_id = random.randint(1,num)
            err_word = Words.objects.get(word_id = random_id)
            errorwords[index] = err_word.means

        Aoption = errorwords[0]
        Boption = errorwords[1]
        Coption = errorwords[2]
        Doption = errorwords[3]
        # 根据随机出来的数字 确定正确选项字母
        if correct_id == 1:
            Aoption = word.means
            correct = 'A'
        elif correct_id == 2:
            Boption = word.means
            correct = 'B'
        elif correct_id == 3:
            Coption = word.means
            correct = 'C'
        else:
            Doption = word.means
            correct = 'D'

        test_list[i] = {
            'spell':word.word,
            'A':Aoption,
            'B':Boption,
            'C':Coption,
            'D':Doption,
            'correct':correct,
        }
        i = i + 1
    
    return JsonResponse(test_list,json_dumps_params={'ensure_ascii':False})

# 学生:默认前端首先获得单词书列表，用户选择单词书在返回到后端
# 单元学习
def Unit_learn(request):
    unit = int(request.POST.get('unit_number'))
    book_id = request.POST.get('book_id')
    student_id = request.POST.get('student_id')
    # unit = 1
    # book_id = 1
    # student_id = 1
    # 单元单词数量
    unit_num = 10

    category = Category.objects.get(category_id = book_id)
    # 按单词ID进行排序，规定好一个单元的数量
    words = Classification.objects.filter(category_id = category.category_id).order_by('word_id')
    word_message = {}
    
    start = (unit-1)*unit_num
    end = unit*unit_num
    i = 1
    print(start,end)
    for item in words[start:end]:
        word = Words.objects.get(word_id = item.word_id)
        # 判断学生单词是否是熟悉词
        student_word = StudentWords.objects.get(student_id = student_id, words_id = item.word_id)
        if student_word.counts < student_word.value:
            word_message[i] = {
                'word_id':word.word_id,
                'spell':word.word,
                'mean':word.means,
                'example':word.example,
                'example_mean':word.example_means
            }
            i += 1
    return JsonResponse(word_message,json_dumps_params={'ensure_ascii':False})


# 默认前端首先获得单词书列表，用户选择单词书和第几单元在返回到后端
# 学生单词单元测试  只有选择题，包含该单元所有单词，不加熟练度
def Unit_test(request):
    # bookname = request.POST.get('book_name')
    # unit = request.POST.get('unit')
    bookname = "八年级上册英语"
    unit = 2
    category = Category.objects.get(book_name = bookname)
    # 按单词ID进行排序，规定好一个单元的数量
    words = Classification.objects.filter(category_id = category.category_id).order_by('word_id')

    # 单元单词数量
    unit_num = 10
    start = (unit-1)*unit_num
    end = unit*unit_num
  
    # 单元测试的所有数据
    test_list = {}
    # 错误的三个单词字典
    errorwords = {}
    # 获得所有单词的数量，从所有单词里随机抽取，默认单词id自动递增无缺漏
    allwords = Words.objects.all()
    num = len(allwords)

    correct = str()
    # 录入测试单词数据及其选项
    i = 1
    for item in words[start:end]:
        word = Words.objects.get(word_id = item.word_id)
        
        # 随机生成一个正确选项
        correct_id = random.randint(1,4)
        # 随机生成四个错误选项
        for index in range(4):
            random_id = random.randint(1,num)
            while random_id == word.word_id:
                random_id = random.randint(1,num)
            err_word = Words.objects.get(word_id = random_id)
            errorwords[index] = err_word.means

        Aoption = errorwords[0]
        Boption = errorwords[1]
        Coption = errorwords[2]
        Doption = errorwords[3]
        # 根据随机出来的数字 确定正确选项字母
        if correct_id == 1:
            Aoption = word.means
            correct = 'A'
        elif correct_id == 2:
            Boption = word.means
            correct = 'B'
        elif correct_id == 3:
            Coption = word.means
            correct = 'C'
        else:
            Doption = word.means
            correct = 'D'

        test_list[i] = {
            'spell':word.word,
            'A':Aoption,
            'B':Boption,
            'C':Coption,
            'D':Doption,
            'correct':correct,
        }
        i = i + 1
    
    return JsonResponse(test_list,json_dumps_params={'ensure_ascii':False})

# 录入测试成绩
def Input_test(request):
    studentid = request.POST.get('student_id')
    test_type = request.POST.get('test_type')
    test_grade = request.POST.get('test_grade')
    test = Test(student_id= studentid,test_type = test_type,test_grade = test_grade)
    test.save() 
    #改变学生的学习状态
    student = Student.objects.get(student_id = studentid)
    if test_type == '1':
        student.study_status = 2
        student.save()
    elif test_type == '2':
        student.study_status = 2
        student.save()
    elif test_type == '3':
        student.study_status = 3
        student.save()
    data = {}
    data['status'] = 'succeed'
    return JsonResponse(data)


# 学生:获得单元学习进度
def Unit(request):
    student_id = request.POST.get('student_id')
    book_id = request.POST.get('book_id')
    # student_id = 1
    # book_id = 1
    words = Classification.objects.filter(category_id = book_id).order_by('sequence')
    # 单元单词数
    num = 10
    data = {}
    i = 0
    flag = True
    for item in words:
        student_word = StudentWords.objects.get(student_id = student_id, words_id = item.word_id)
        if student_word.counts != student_word.value:
            flag = False
        i = i + 1
        if i%num == 0:
            data[i//num] = 1 if flag else 0
            flag = True
    if i%num != 0:
        data[i//num + 1] = 1 if flag else 0
    return JsonResponse(data)


def Word_pk(request):
    match_id = request.POST.get('match_id')
    match = Match.objects.get(match_id = match_id)
    # 该比赛所有单词id
    words_id = match.words_id.split('|')
    pk_list = {}
    # 错误的四个单词拼写集合
    errorwords_mean = set()
    # 获得所有单词的数量，从所有单词里随机抽取，默认单词id自动递增无缺漏
    all_words = Words.objects.all()
    num = len(all_words)
    correct = str()
    # 录入题目和单词拼写选项
    i = 1
    for item in words_id:
        errorwords_mean.clear()
        word = Words.objects.get(word_id = int(item))
        example = word.example.split(' ')
        print(example)
        for index,value in enumerate(example):
            if value.lower() == word.word.lower():
                example[index] = '______'
                break

        flag = False
        for item in example:
            if item == '______':
                flag = True
        if not flag:
            continue
        question = ' '.join(example)

        # 随机生成一个正确选项
        correct_id = random.randint(1,4)
        # 随机生成四个错误选项
        while len(errorwords_mean) < 4:
            random_id = random.randint(1,num)
            while random_id == word.word_id:
                random_id = random.randint(1,num)
            err_word = Words.objects.get(word_id = random_id)
            errorwords_mean.add(err_word.word)
        # 先给四个选项都给错误的值
        Aoption = errorwords_mean.pop()
        Boption = errorwords_mean.pop()
        Coption = errorwords_mean.pop()
        Doption = errorwords_mean.pop()
        # 根据随机出来的数字  确定正确选项字母
        if correct_id == 1:
            Aoption = word.word
            correct = 'A'
        elif correct_id == 2:
            Boption = word.word
            correct = 'B'
        elif correct_id == 3:
            Coption = word.word
            correct = 'C'
        else:
            Doption = word.word
            correct = 'D'

        pk_list[i] = {
            'example':question,
            'example_means':word.example_means,
            'A':Aoption,
            'B':Boption,
            'C':Coption,
            'D':Doption,
            'correct':correct,
        }
        i = i + 1
    return JsonResponse(pk_list,json_dumps_params={'ensure_ascii':False})


def Recall_word(request):
    student_id = request.POST.get('student_id')
    word_id = request.POST.get('word_id')
    recall_num = int(request.POST.get('recall_num'))
    # student_id = 1
    # word_id = 4
    # recall_num = 2
    studentword = StudentWords.objects.get(student_id = student_id, words_id = word_id)
    if recall_num == 1:
        if studentword.counts > 0:
            studentword.counts -= 1
            studentword.save()
    elif recall_num == 2:
        if studentword.counts < studentword.value:
            studentword.counts += 1
            studentword.save()
    elif recall_num == 3:
        studentword.counts = studentword.value
        studentword.save()
    return JsonResponse(data = {'status':'succeed'})

# 学生:学前测试成绩
def Beforetest_grade(request):
    student_id = request.POST.get('student_id')
    # student_id = 1
    student = Student.objects.get(student_id = student_id)
    test = Test.objects.get(student_id = student_id, test_type = 1)
    data = {
        'grade':test.test_grade
    }
    return JsonResponse(data)

# 参赛时间是否已经过去
def Enable_join(request):
    match_id = request.POST.get('match_id')
    match = Match.objects.get(match_id = match_id)

    now_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
    data = {}
    if now_time > match.end_time.strftime("%Y-%m-%d %H:%M"):
        data['enable_join'] = 0
    elif now_time < match.start_time.strftime("%Y-%m-%d %H:%M"):
        data['enable_join'] = 1
    else: 
        data['enable_join'] = 2
    return JsonResponse(data)

# 学生:参加比赛
def Join_match(request):
    student_id = int(request.POST.get('student_id'))
    match_id = int(request.POST.get('match_id'))
    grade = 0
    join_time = datetime.datetime.now()
    
    studentmatch = StudentMatchs(
        match_id= match_id,
        student_id = student_id,
        match_grade = grade,
        join_time = join_time
    )
    studentmatch.save()
    data = {}
    data['status'] = 'succeed'
    return JsonResponse(data)

# 录入比赛成绩
def Input_match(request):
    match_id = int(request.POST.get('match_id'))
    student_id = int(request.POST.get('student_id'))
    match_grade = int(request.POST.get('match_grade'))
    
    studentmatch = StudentMatchs.objects.get(match_id = match_id, student_id = student_id) 
    data = {}
    if studentmatch.match_grade < match_grade:
        studentmatch.match_grade = match_grade
        studentmatch.save()
        data['status'] = 'succeed'
    else:
        data['status'] = 'grade lower'
    return JsonResponse(data)

# 学生:巩固测试
def Consolidate_test(request):
    student_id = int(request.POST.get('student_id'))
    book_id = int(request.POST.get('book_id'))

    book_words = Classification.objects.filter(category_id = book_id).order_by('word_id')
    
    test_list = {}
    # 错误的四个单词含义集合
    errorwords_mean = set()
    # 获得所有单词的数量，从所有单词里随机抽取，默认单词id自动递增无缺漏
    allwords = Words.objects.all()
    num = len(allwords)
    correct = str()
    # 录入测试单词数据及其选项
    i = 1
    for item in book_words:
        studentword = StudentWords.objects.get(student_id = student_id, words_id = item.word_id)
        if studentword.counts == 0:
            continue
        errorwords_mean.clear()
        word = Words.objects.get(word_id = item.word_id)
        # 随机生成一个正确选项
        correct_id = random.randint(1,4)
        # 随机生成四个错误选项
        while(len(errorwords_mean) < 4):
            random_id = random.randint(1,num)
            while random_id == word.word_id:
                random_id = random.randint(1,num)
            err_word = Words.objects.get(word_id = random_id)
            errorwords_mean.add(err_word.means)
            
        Aoption = errorwords_mean.pop()
        Boption = errorwords_mean.pop()
        Coption = errorwords_mean.pop()
        Doption = errorwords_mean.pop()
        # 根据随机出来的数字 确定正确选项字母
        if correct_id == 1:
            Aoption = word.means
            correct = 'A'
        elif correct_id == 2:
            Boption = word.means
            correct = 'B'
        elif correct_id == 3:
            Coption = word.means
            correct = 'C'
        else:
            Doption = word.means
            correct = 'D'

        test_list[i] = {
            'spell':word.word,
            'A':Aoption,
            'B':Boption,
            'C':Coption,
            'D':Doption,
            'correct':correct,
        }
        if i == 10:
            break
        i = i + 1

    return JsonResponse(test_list,json_dumps_params={'ensure_ascii':False})


'''
教师端
'''
# 教师:教师登录
def Teacher_login(request):
    try:
        username = request.POST.get('teacher_username')
        password = request.POST.get('teacher_password')
        data = {}
        teacher = Teacher.objects.get(teacher_username=username)
        data['teacher_id'] = teacher.teacher_id
        data['teacher_name'] = teacher.teacher_name
    except Teacher.DoesNotExist:
        data['login_status'] = 'not_exist'
        return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
    else:
        if teacher.teacher_password == password:
            data['login_status'] = 'succeed'
            return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})
        else:
            data['login_status'] = 'failed'
            return JsonResponse(data, safe=False,json_dumps_params={'ensure_ascii':False})

# 教师:教师修改密码
def Teacher_changepsw(request):
    # 存取控制
    teacherid = request.POST.get('teacher_id')
    oldpassword = request.POST.get('old_password')
    newpassword = request.POST.get('new_password')
    teacher = Teacher.objects.get(teacher_id = teacherid)
    data = {}
    if teacher.teacher_password == oldpassword:
        teacher.teacher_password = newpassword
        teacher.save()
        data['change_status'] = 'succeed'
        return JsonResponse(data,safe = False)
    else:
        data['change_status'] = 'failed'
        return JsonResponse(data,safe = False)

# 教师:教师详细信息
def Teacher_message(request): 
    teacher_id = request.POST.get('teacher_id')
    # teacher_id = 1
    teacher = Teacher.objects.get(teacher_id = teacher_id)
    courses_id = teacher.courses_id.split('|')
    data = {
        "teacher_username":teacher.teacher_username,
        "teacher_name":teacher.teacher_name,
        "teacher_sex":teacher.teacher_sex,
        "teacher_age":teacher.teacher_age,
        "teacher_phone":teacher.teacher_phone,
        "teacher_address":teacher.teacher_address,
        "courses_id":courses_id
    }
    return JsonResponse(data,json_dumps_params={'ensure_ascii':False})

# 教师:班级列表
def Course_list(request):
    teacherid = request.POST.get('teacher_id')
    teacher = Teacher.objects.get(teacher_id = teacherid)
    courses = teacher.courses_id.split('|')
    courses_list = {}
    i = 1
    for item in courses:
        courseid = int(item)
        course = Course.objects.get(course_id = courseid)
        courses_list[i] = {
            'course_id':course.course_id,
            'course_name':course.course_name,
            'course_student_number':course.number
        }
    return JsonResponse(courses_list,json_dumps_params={'ensure_ascii':False})

# 教师:学生名册
def Student_list(request):
    course_id = request.POST.get('course_id')
    # course_id = 1
    course = Course.objects.get(course_id = course_id)
    students = Student.objects.filter(course_id = course_id)
    student_message = {}
    i = 1
    for item in students:
        student_message[i] = {
            'student_name':item.student_name,
            'email':item.email,
            'coins':item.coins,
            'last_login':item.lastlogin_time,
            'student_id':item.student_id,
            'course_name':course.course_name,
            "group":'xfinit',
            'register_time':'2020-1-3 16:46:30',
            'status':"付费"
        }
        i = i + 1
    return JsonResponse(student_message,json_dumps_params={'ensure_ascii':False})

# 教师:开通课程
def Open_book(request):
    book_id = request.POST.get('book_id')
    student_id = request.POST.get('student_id')
    # book_id = 3
    # student_id = 2
    data = {}
    student = Student.objects.get(student_id = student_id)
    # 获得该课程的单词书和开通状况
    books_id = student.books_id.split('|')
    enable = student.books_enable.split('|')
    for index,item in enumerate(books_id):
        if item == str(book_id):
            enable[index] = '1'
            student.books_enable = '|'.join(enable)
            student.save()
            data['status'] = 'succeed'
            return JsonResponse(data)
    data['status'] = 'fail'
    return JsonResponse(data)