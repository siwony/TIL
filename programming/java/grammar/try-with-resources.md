# Try-with-resources
해당 문법은 `try(...)`에서 선언된 객체들에 대해 try가 종료될 떄 자동으로 자원을 해제해주는 기능히다.
- try에서 선언된 객체가 AutoCloseable을 구현하면 Java는 try구문이 종료될 때 객체의 `close()` 메소드를 호출한다.
- Java7 버전에 추가되었다.

### 1. Java7 이전의 자원 해제 방법
input.txt를 읽는 코드입니다. 
```java
public class ResourceClose {
    public static void main(String[] args) {
        Scanner scanner = null;
        try {
            // scanner 생성
            scanner = new Scanner(new File("input.txt"));
            System.out.println(scanner.nextLine());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            // scanner 리소스 반납
            if (scanner != null) 
                scanner.close();
        }
    }
}
```
여기에서는 try에서 Scanner객체를 생성한 후 finally에서 close를 해줬다.

이경우에는 finally를 통해 무조건 자원을 해제 해줘야 하고 혹시 모를 NPE를 대비해 null체크를 했다. 이런 코드를 Java7부터 다음과 같이 사용할 수 있다.

### 2. Java7 이후의 자원 해제 방법
```java
public class ResourceClose {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new File("input.txt"))){
            System.out.println(scanner.nextLine());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}
```
이 코드는 어느 곳에도 생성된 리소스를 반납하지 않아도 try옆 괄호 안에 있는 리소스에 대해 자동으로 `close()`가 호출된다.

`try with resources`구분에 사용되는 리소스는 `java.lang.AutoCloseable` 인터페이스를 구현해야 한다.

`Scanner`의 [공식 API 문서](https://docs.oracle.com/javase/7/docs/api/java/util/Scanner.html)를 보면 `java.lang.AutoCloseable`를 구현한 것을 볼 수 있다.

### 3. Java9에서 나온 개선사항
Java7에서는 자원을 해제해야 하는 리소스를 반드시 try옆 괄호 안에 생성을 해야 한다.

하지만 Java9부터 변수를 통해 이를 해제할 수 있다.

```java
public class ResourceClose {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(new File("input.txt"));
        try (scanner){
            System.out.println(scanner.nextLine());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }
}
```
#### 주의사항
- 사용할 변수가 final이거나
- effectively final(사실상 final)인 변수를 사용해야 한다.
  