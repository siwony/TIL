# Facade Pattern
: 어떤 서브시스템의 일련의 인터페이스에 대한 통합된 인터페이스를 제공한다.
<img width=550px src=./img/facade-diagram.png>

- Facade는 건물의 앞쪽 정면 이라는 뜻을 가진다.
- Facade는 자신이 가지고 있는 각 클래스의 기능을 정확히 알아야 한다.
- Facade 패턴은 어떤 서브시스템에 대한 간단한 인터페이스로 제공하는 것이다. &rarr; FTP를 사용할때 그 안에 있는 로직을 직접 사용한다고 생각해보자 끔찍하다.
- 전자레인지를 생각해보자. 우리는 전자레인지의 기능만 알고 사용하지 그안에 동작원리까지 알고 사용하는가?  
  &rarr; 우리는 전자레인지의 버튼이 어떤 역활인지만 알면된다.

### Facade Pattern의 예시
**간단한 FTP client 형식적으로 만들어보자**
- FTP는 연결할 수 있고 디렉토리를 연결할 수 있고 연결을 끊을 수 있다.
- Reader는 연결할 수 있고, 파일의 내용을 읽을 수 있고, 연결을 끊을 수 있다.
- Reader는 연결할 수 있고, 파일의 내용을 쓸 수 있고, 연결을 끊을 수 있다.
#### 퍼사트 패턴의 적용 전
<img width=350px src=./img/before-facade.png>

`FTP class`
```java
public class Ftp{

    private String host;
    private int port;
    private String path;

    public Ftp(String host, int port, String path){
        this.host = hose;
        this.prot = prot;
        this.path = path;
    }

    public void connect(){
        System.out.println("FTP host: "+ host + "Prot: " + prot  + "로 연결합니다.")
    }

    public void moveDir(){
        System.out.println(path + "로 연결을 종료합니다.");
    }

    public void disconnect(){
        System.out.println("연결을 종료합니다.");
    }
}
```
`file을 읽어오는 Reader class`
```java
public class Reader{

    private String fileName;

    public Reader(String fileName){
        this.fileName = fileName;
    }

    public void fileConnect(){
        System.out.println("Reader: "+ fileName +" 로 연결합니다.");

    }

    public void fileRead(){
        System.out.println("Reader: "+ fileName +" 의 내용을 읽어옵니다..");

    }

    public void fileDisconnect(){
            System.out.println("Reader: "+ fileName +" 로 연결을 종료합니다.");
    
    }

}
```
`file을 삽입하는 Writer class`
```java
public class Writer{

    private String fileName;

    public Writer(String fileName){this.fileName=fileName}

    public void fileConnect(){
        System.out.println("Writer: "+ fileName +" 로 연결합니다.");

    }

    public void write(){
        System.out.println("Writer: "+ fileName +" 로 파일쓰기를 합니다..");

    }

    public void fileDisconnect(){
            System.out.println("Writer: "+ fileName +" 로 연결을 종료합니다.");
    
    }

}
```
`결과 main method`
```java
public class main{
    public static void main(String[] args){
        Ftp ftp = new Ftp("www.foo.com", 22, "/home/etc");
        ftp.connect();
        ftp.moveDir();

        Writer writer = new Writer("text.tmp");
        writer.fileConnect();
        writer.write();

        Reader reader = new Reader("text.tmp");
        reader.connect();
        reader.fileRead()

        reader.disConnect();
        writer.disConnect();
        ftp.disConnect();

    }
}
```
- 클라이언트(개발자)가 Ftp기능을 사용하려면 Ftp, Writer, Reader의 객체가 어떻게 동작하는지 알아야 한다.
- 퍼사드 객체를 통해 이 문제를 해결 할 수있다.

#### 퍼사트 패턴의 적용 후
<img width=300px src=./img/after-fasade.png>

`ftp의 퍼사드인 sftpClient Class`

```java
public class SftpClient{

    private Ftp ftp;
    private Writer writer;
    private Reader reader;

    public SftpClient(Ftp ftp, Reader reader, Writer writer){
        this.ftp = ftp;
        this.reader = reader;
        this.writer = writer;
    }

    public SftpClient(String host, int prot, String path, String fileName){
        this.ftp = new Ftp(host, prot, path);
        this.reader = new Reader(fileName);
        this.writer = new Writer(fileName);
    }

    public void connect(){
        ftp.connect();
        ftp.moveDir();
        reader.connect();
        writer.connect();
    }
    
    public void disconnect(){
        reader.FileDisconnect();
        writer.FIleDisconnect();
        ftp.disconnect();
    }

    public void read(){
        reader.fileRead();
    }

    public void writer(){
        writer.write();
    }
}

```
결과
```java
public class Main{
    public static void main(String[] args){
        SftpClient sftpClient = new SftpClient("www.foo.com", 22, "/home/etc", "text.tmp");
        sftpClient.connect();

        sftpClient.write();
        sftpClient.read();
        sftpClient.disconnect()
    }
}
```
- 클라이언트는 굉장히 간단하게 FTP기능을 간단하게 사용할 수 있다.