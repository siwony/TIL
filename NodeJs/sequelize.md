# sequelize
## sequelize란?
> : sequelize 는 node.js 의 ORM(Object Releaition Mapping) 모듈이다.  
ORM이란 [여기]()를 참고
## how to use?
```bash
> npm install sequelize sequelize-cli --save
```
위 명령어를 통해 sequelize 모듈과 sequelize-cli 모듈을 받아온다.  
sequelize-cli는 cli로 모델을 쉽게 생성할 수 있다.  
**다음 명령어를 통해 초기화를 한다.
```bash
> sequelize init
```
 root 디렉토리에 아래와같은 디렉토리/파일이 생긴다.  
*여기서 root 디렉토리는 현제 작업하고있는 프로젝트의 최상위 디렉토리를 말한다.  
예시로 <code>npm init</code>으로 초기화한 디렉토리를 말한다.
```bash
|-- config
|   `-- config.json
|-- migrations     
|-- models
|   `-- index.js   
|-- seeders        
```
### 디렉토리별 정의
- **config** : DB설정파일, 사용자이름, DB이름, 비밀번호 등이 들어가 있다.
- **migrations** : Git과 비슷하게 DB변화하는 과정을 추측해나아가는 정보로 실제 데이터베이스에 반영할 수 있고 취소할 수 있다.
- **models** : DB 각 테이블의 정보 및 필드타입을 정의하고 하나로 모은다.
- **seeders** : table에 기본 데이터를 넣고싶을떄 사용한다.
## 디렉토리를 정리해보자
root디렉토리에는 너무 많은 디렉토리, 소스코드, 설정파일들이 있다   
우리는 저 많은 디렉토리들을 하나의 디렉토리로 묶을 필요가 있다.  
먼저 위에서 생성했던 파일들을 제거하자. 그리고 **<code>.sequelizerc</code>** 파일을 root에 생성한다.  
그후 **<code>.sequelizerc</code>** 파일을 아래와 같이 작성한다.  
```JavaScript
const path = require('path');

module.exports = {
    'config': path.resolve('src/db/config/config.js'),
    'models-path': path.resolve('src/db/models'),
    'seeders-path': path.resolve('src/db/seeders'),
    'migrations-path': path.resolve('src/db/migrations')
}
``` 
이 코드는 <code>sequelize init</code> 를 통해 초기화했을때 루트 디렉토리에 **<code>src/db</code>** 경로로 저 디렉토리와 파일들을  만들어준다.
## 설정
<code>config/config.json</code> 에 들어가면 json 형식으로 DB 정보가 작성되어있을것이다. 
```JavaScript
{
  "development": {
    "username": "root",
    "password": null,
    "database": "database_development",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "test": {
    "username": "root",
    "password": null,
    "database": "database_test",
    "host": "127.0.0.1",
    "dialect": "mysql"
  },
  "production": {
    "username": "root",
    "password": null,
    "database": "database_production",
    "host": "127.0.0.1",
    "dialect": "mysql"
  }
}
```
처음으로 sequelize를 초기화 했으면 기본적으로 <code>development</code>에 입력되어있는 DB정보로 개발이 이루어 질것이다.  
자신이 설정한 mysql DB에 따라 정보를 수정한다. 개발을 할것이기에 <code>development</code> 에 있는 정보를 수정하자
**참고로 password는 String 형으로 받아야 된다 그러므로 큰따음표(")로 묶어줘야한다.**  
안그러면 <code>ERR_INVALID_ARG_TYPE</code> 에러가 발생할것이다  
~~필자는 비밀번호가 1234였는데 비밀번호를 큰따음표(")로 안묶어서 에러때문에 2시간동안 고생했다~~  

## DB모델링
간단하게 User라는 table 모델을 만들게되면
```bash
sequelize model:generate --name User --attributes id:integer, name:string
```
<code>model/user.js</code>가 아래처럼 만들어진다. (2020, 12, 20 기준)
```javascript
'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class User extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  };
  User.init({
    id: DataTypes.INTEGER,
    name: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'User',
  });
  return User;
};
```
이렇게 <code>user.js</code> 라는 파일이 <code>model</code> 디렉토리 안에 생기고, Users 라는 테이블이 생기는데  
*Users로 모델이 생성된 이유는 기본적으로 sequelize에서 자동으로 첫글자는 대문자, 복수형 로 변환해준다.*   

### if모델을 수정했다면
```bash
> sequelize db:migrations
```
이 명령어를 꼭 입력해줘야한다, 이유는 모델이 수정이 되도 최종적으로 DB에 반영하는것은  
migrations 폴더 안에있는 <code>[타임스탬프]-create-user.js</code> 형식의 파일이다.


## DB모델 반영
>server를 실행할 파일에 <code>models/index.js</code>를 연결해주면 설계한대로 반영이 될것이다.  

**참고**
- id는 자동으로 생긴다.