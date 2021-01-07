# express-generator
Express-generator라는 패키지를 통해서 프레임워크에 필요한 pakage.json과 기본 구조를 잡을 수 있는 패키지 이다.
## install 및 express 프로젝트 만들기
node.js, npm 이 설치되어있다는 가정하에 설명을 할것이다. [(설치방법)](./how-to-install-nodejs.md)  
```bash
> npm install -g express-generator
```
위 명령어는 npm 으로 express-generator가 전역으로 설치를 해준다.  
전역으로 설치한 이유는 나중에도 사용할것이기에 했다.  
그후 express 기본구조를 잡아볼것이다.
```bash
> express "express-project" --view=ejs
```
이렇게 하면 현제 명령어를 실행한 디렉토리 기준으로 <code>/express-project</code> 에 express 프로젝트가 만들어진다.
"express-project" 등 프로젝트 이름을 생략할 수 있는데 그 경우 현제 디렉토리에 프로젝트가 생성된다.  
그후 package.json 에 있는 모듈들을 설치 할것이다.
```bash
> npm i
```
를 하면 package.json에 있는 모듈들을 자동으로 설치해줄것이다.
## nodemon 적용하기
[nodemon](./how-to-install-nodejs.md)이 설치가 되어있다는 가정으로 설명할것이다.  
<code>package.json</code> 파일에 있는 script 부분을 수정할것이다.
```json
  "scripts": {
    "start": "node ./bin/www",
  },
```
를 
```json
  "scripts": {
    "start": "node ./bin/www",
    "dev": "nodemon ./bin/www"
  },
```
와 같이 바꿔줄것이다. 개발을할때 <code>npm run dev</code>를 통해 nodemon으로 실행할 수 있고  
일반적으로 npm start를 하면 npm 으로 실행할것이다.