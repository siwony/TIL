# Node,Js 설치(mac)
## 설치 
터미널에 <code>brew install node</code> 를 입력하면 Node.js 가 설치됩니다.
## 유용한 npm 모듈
### nodemon
설치방법
```bash
$ npm install -g nodemon --save 
#--save는 package.json에 dependency 항목에 추가됨
```
사용법 <code>nodemon <실행파일></code>  
Node.js 는 싱글스레드 기반이여서 에러 한번만 일어나면 서버가 다운이 되버린다.  
그러면 개발할떄마다 다시 <code>node <실행파일></code> 를 계속 입력해줘야하지만 nodemon은 계속 실행해준다.