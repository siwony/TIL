# python DATA-Type, Variables
## 변수선언
앞에 문자형을 붙이지 않고 그냥 선언한다
```python
integer_n = 1
float_f = 1.2
string_str = "고양이"
boolean_bool = true; boolean_bool = false;  boolean_bool = not true;
list_li = [1, 1.2, "고양이", true]
```
## python 의 data type
data type과 메서드들을 정리,  
python의 자료형은 모두다 class 이다 즉 참조형  
하지만 파이썬은 포인터를 지원하지 않는다
y = 100, x = 100 이 선언됬을떄 두 x, y는 가르키는 객체가 같다 `print(a is b) #출력:ture`
- ### int
    ```python
    print((int)(1.2)) #출력 1 
    print((int)(8*1.2))  #출력 9
    print(abs(-5)) #절대값 5
    print(pow(4, 2)) # 4 ^ 2 = 16
    print(max(5, 12)) # 12
    print(min(5, 12)) # 5
    # 반올림
    print(round(3.14)) #3
    print(round(4.99)) #5
    ```
- ### float
    ```python
    print((float)(1)) # 출력 1.0
    ```
- ### str
    ```python
    print("문자형")  #출력 : 문자열
    print("고양이"*5)  #출력 : 고양이고양이고양이고양이고양이
    print(str(1.3)) #문자열 출력 : 1.3
    sentence = """
    나는고양이가
    되고싶다.
    하지만 그렇게 할 수 없는걸"""
    print(sentence)
    """
    출력 :

    나는고양이가
    되고싶다.
    하지만 그렇게 할 수 없는걸
    """
    ##################### String method #######################"
    python = "Python is Amazing"
    print(python.lower())#소문자로
    print(python.upper())#대문자로
    print(python[0].isupper())#0번쨰 글자 대문자인지 판별
    print(len(python)) # 길이 반환 15
    print(python.replace("Python", "java"))#특정문자바꾸기
    
    ##인덱스 반환##
    index = python.index("n")#문자열 이 있는 index 가져오기#5
    print(index)
    index = python.index("n", index + 1)#문자열이 있는 index 가져오기 15
    print(index)

    ##문자찾기##
    print(python.find("Python")) #문자 찾기 찾으면 시작 인덱스 반환, 못찾으면 -1 반환
    #print(python.index("Java")) #문자 찾기 찾으면 시작 인덱스 반환, 못찾으면 에러띄움
    print(python.count("n"))# 특정문자, 문자열이 몇번 나왔는지 확인 n은 2번나옴
    ##################### String formet #########################
    #c, java처럼 formet %를 붙여 formet 이 가능함 ex) c: printf("%s", 10) 와 같이
    print("나는 {} 과 {}색을 좋아함".format("고양이", "회색"))
    print("나는 {} 과 {}색을 좋아함".format("회색", "고양이"))
    print("나는 {1} 과 {0}색을 좋아함".format("고양이", "회색"))
    print("나는 {animal} 과 {color}색을 좋아함".format(color = "blue", animal = "고양이"))
    animal = "강아지";  color = "white"
    print(f"나는 {animal}를 좋아하고, {color}색을 좋아함")
    ```
- ### list
    ```python
    subway = ["유재석", "조세호", "박명수"]
    print(subway) #출력 ['유재석', '조세호', '박명수']
    print(subway.index("조세호")) #인텍스 찾기 1반환
    
    subway.append("하하") 
    print(subway) 출력: ['유재석', '조세호', '박명수']
    
    subway.insert(1 ,"정형돈") #끼워넣기4
    print(subway)
    print("\n##뒤에서 부터 순서대로 제거 pop##")
    print(subway.pop())  #뒤에서 부터 순서대로 제거
    print(subway)
    print("\n##사람 몇명있는지 확인##")
    #같은 이름의 사람이 몇 명 있는지 확인
    subway.append("유재석")
    print(subway)
    print(subway.count("유재석"))
    #정렬가능
    print("##정렬##")
    num_list = [5,2,4,1,3]
    num_list.sort()
    print(num_list) #출력 [1,2,3,4,5]
    #순서 뒤집기 가능 
    print("##숫자뒤집기##")
    num_list.reverse()
    print(num_list) #출력 [5,4,3,2,1]
    #다양한 자료형 함꼐 사용
    mix_list = ["조세호", 20, True]
    #리스트 확장
    print("##리스트확장##")
    num_list.extend(mix_list)
    print(num_list) # 출력 : [5, 4, 3, 2, 1, '조세호', 20, True]
    ```
- ### dictionary
    ```python
    cabinet = {3:"유재석", "e-100":"김태호"}
    print(cabinet[3])#키값에 접근 출력: 유재석
    #print(cabinet[5]) #값이 없으면 에러
    print(cabinet.get(5))#5번키에 있는 값 가져오기
    print(cabinet.get(5, "사용가능"))#5번키에 있는 값 가져오기
    print(3 in cabinet) # 3번키에 값이 있는지 없는지 판별
    print("e-10" in cabinet) #e-10이라는 키가 cabinet 안에 있는지 판별
    print(cabinet) #출력 : {3: '유재석', 'e-100': '김태호'}
    #새로 추가
    print("##새로추가##")
    cabinet["a-30"] = ""
    cabinet["e-100"] = "김태호" #기존값 수정
    
    #키들만 출력
    print(cabinet.keys())  #출력: dict_keys([3, 'e-100', 'a-30'])
    #value 들만 출력
    print(cabinet.values()) #출력 : dict_values(['유재석', '김태호', ''])
    #모두 다 출력
    print(cabinet.items()) #출력 dict_items([(3, '유재석'), ('e-100', '김태호'), ('a-30', '')])
    #다 삭제
    cabinet.clear()
    print(cabinet) #출력: []
    ```
- ### complex : 복소수