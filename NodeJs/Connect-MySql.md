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
![node-mysql-query](../img/node.js-mysql-select-query.png)

