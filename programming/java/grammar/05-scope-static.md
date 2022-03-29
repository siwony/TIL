# 변수의 scope, static
## scope
**프로그램상에서 사용되는 변수의 사용가능한 범위**
```java
    public class ValableScopeExam{

        int globalScope = 10;   // 인스턴스 변수 

        public void scopeTest(int value){   
            int localScope = 10;
            System.out.println(globalScope);
            System.out.println(localScpe);
            System.out.println(value);
        }
    }
```
- 클래스의 속성으로 선언된 변수 globalScope의 사용범위는 클래스 전체
- 매개변수로 선언된 int value 는 메서드 선언부에 존재하므로 사용범위는 해당 메소드 블럭내이다.
- 메소드 블럭내에서 선언된 localScope 변수의 사용범위는 메소드 블럭내이다.
## static
- main은 static 한 method
- static한 메서드는 static 하지 않은 필드를 사용 할 수 없다.
```java
    public class VariableScopeExam {
        int globalScope = 10; 

        public void scopeTest(int value){
            int localScope = 20;            
            System.out.println(globalScope);
            System.out.println(localScope);
            System.out.println(value);
        }   
        public static void main(String[] args) {
            System.out.println(globalScope);  //오류
            System.out.println(localScope);   //오류
            System.out.println(value);        //오류  
        }   
    }
```
- static하게 선언된 변수는 값을 저장할 수 있는 공간이 하나만 생성된다.  
- 인스턴스가 여러개 생성되도 static한 변수는 하나다.
- 클래스명.변수명 으로 사용하는것이 더 바람직하다고 하다.  
    ``VariableScopeExam.staticVal``
```java
  ValableScopeExam v1 = new ValableScopeExam();
    ValableScopeExam v2 = new ValableScopeExam();
    v1.golbalScope = 20;
    v2.golbalScope = 30; 

    System.out.println(v1.golbalScope);  //20 이 출력된다. 
    System.out.println(v2.golbalScope);  //30이 출력된다. 

    v1.staticVal = 10;
    v2.staticVal = 20; 

    System.out.println(v1.statVal);  //20 이 출력된다. 
    System.out.println(v2.statVal);  //20 이 출력된다. 
```
