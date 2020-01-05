# 默认前端首先获得单词书列表，用户选择单词书在返回到后端
def Test_before(request):
    # bookname = request.POST.get('book_name')
    bookname = "八年级上册英语"
    category = Category.objects.get(book_name = bookname)
    words = Classification.objects.filter(category_id = category.category_id).order_by('word_id')

    # 从当前单词书中获得随机的n个不重复的单词
    n = 10
    index_list = random.sample(range(1,len(words)),n)
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
        word = Words.objects.get(word_id = words[item].word_id)
        
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

# 默认前端首先获得单词书列表，用户选择单词书，第几单元再返回到后端
# 后端返回这个单元的所有单词
def Unit_learn(request):
    # unit = int(request.POST.get('Unit_number'))
    # bookname = request.POST.get('book_name')
    unit = 2
    bookname = '八年级上册英语'
    unit_num = 10  # 单元单词数量

    category = Category.objects.get(book_name = bookname)
    # 按单词ID进行排序，规定好一个单元的数量
    words = Classification.objects.filter(category_id = category.category_id).order_by('word_id')
    word_message = {}
    
    start = (unit-1)*unit_num
    end = unit*unit_num
    i = 1
    for item in words[start:end]:
        word = Words.objects.get(word_id = item.word_id)
        word_message[i] = {
            'word_id':word.word_id,
            'spell':word.word,
            'mean':word.means
        }
        i += 1
    return JsonResponse(word_message,json_dumps_params={'ensure_ascii':False})


# 学生单词学习拼写  只有拼写形式，加熟练度
def Word_spell(request):
    # 前端传入单词ID，学生拼写，学生ID
    # wordid = request.POST.get('word_id')
    # spell = request.POST.get('spell')
    # studentid = request.POST.get('student_id')
    wordid = 5
    spell = 'AmAzing'
    studentid = 1
    word = Words.objects.get(word_id = wordid)
    student_word = StudentWords.objects.get(student_id = studentid,words_id = word.word_id)

    data = {}
    if word.word == spell.lower():
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