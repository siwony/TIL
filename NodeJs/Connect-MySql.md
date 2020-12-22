# Node.js 에 MySQL 연결하기
## MySQL 모듈을 설치합니다.
```bash
$ npm install mysql
```
## DB연결하기
mysql 설치후 mysql 모듈을 설치합니다.
```javascript
const mysql      = require('mysql');
const connection = mysql.createConnection({
  host     : 'localhost',  //호스트 주소
  user     : 'GF_test1',   //mysql user
  password : '1234',       //mysql password
  database : 'testGF8'     //mysql DB
});

connection.connect();

connection.query('SELECT * from test', (error, rows, fields) => {
  if (error) throw error;
  console.log('User info is: ', rows);
});

connection.end();
```
- connection 변수는 연결할 때 사용 되는 정보를 저장함
- connect(); 메소드가 mysql에 연결
- query(‘mysql query’, callback); 에서 실제 데이터 베이스의 값을 다룸  
  mysql query 에너는 mysql query문이 들어감
- end() 매서드를 통해 mysql 을 종료합니다.  
query매세드에 select * from test 라는 쿼리문을 작성해서  
test테이블에 있는 값을 꺼내 와 콘솔에 출력하는 코드를 작성해봤다.
콘솔에 출력하면 값은 값의 타입은 배열이고 컬럼은 JSON 방식인것을 알 수 있습니다.  
![node-mysql-query](./img/node.js-mysql-select-query.png)
## IF 오류가 뜬다면?
> Error: ER_NOT_SUPPORTED_AUTH_MODE: Client does not support authentication protocol requested by server; consider upgrading MySQL client  
만약 이런 애러가 11번째 줄에서 throw 되어서 나타났다면, 먼저 확인해야 될것은  
user랑 password가 잘못되어 있을수도 있다.   
그래도 에러가 뜬다면 유저에게 권환을 주지 않았거나, 유저 자체를 만들지 않았을 것이다.  
지금부터 오류를 고쳐보다.
### 유저 조회
일단은 유저를 관리하는 mysql 이라는 database에 접속을해야한다. <code>use mysql</code>를 입력한다.  
그뒤 유저를 조회해보자
```sql
> select user, host from user;
```
그러면 유저랑, host가 보여질것이다.
여기서 host는 <code>localhost</code> local내에서 접속이 가능한것이고 <code>%</code> 는 어디서나 접속할 수 있다는것을 말한다.
이제 유저를 만들어 볼것이다. 유저를 이미 만들어져 있으면 유저 권한 설정으로 이동하면 된다.
### 유저 생성 및 권환주기
```sql
> create user '유저이름'@'호스트(host)'identified with mysql_native_password by '비밀번호'
```
host에는 대표적으로 localhost, %가 있다.%은 외부에서도 접속이 가능하다는것이다.   
host는 localhost로 하는게 안전하다. 꼭 필요하지 않는이상 localhost로 하는게 좋다. 
```sql
> grant all privileges on . to '(유저이름)'@'%';
```
이렇게 하면 모든 데이터베이스에 접속이 가능하다.  
하지만 모든 데이터베이스에 접속하는것은 위험하다. 그러므로  
```sql
> grant all privileges on DB명.* to 유저(user)@localhost
--ex) grant all privileges on cat.* test@localhost
-- cat이라는 DB접속 권환을 test유저에게 localhost에서 사용가능하게 줬다.
```
이런식으로 특정 DB만 접속할 수 있도록 하는게 비교적 안전해진다.
## Sequelize
sequelize 는 node.js 의 ORM(Object Releaition Mapping) 모듈이다.  
관계형 DB를 사용할떄 객체를 이용해 간편하게 쿼리문을 작성하지 않고 사용할 수 있게 해준다.  
자세한 sequelize 사용법은 [여기](./sequelize.md) 에서 확인할 수 있다.
### how to use?
```bash
> npm install sequelize sequelize-cli --save
```
를 통해 모듈을 다운받고
```bash
> sequelize init
```
을 통해 sequelize 를 사용할 수 있게 파일구조나 필요한 설정파일들을 생성해준다.