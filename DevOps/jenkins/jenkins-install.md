# jenkins install
## ubuntu
### apt update
```sh
sudo apt-get update && sudo apt-get upgrade
```
### 1. Java 설치 및 확인
```sh
sudo apt-get install openjdk-{JAVA_VERSION}-jdk
```
- java를 설치한다.  
  ex. `sudo apt-get install openjdk-11-jdk`
  > 8 버전을 추천한다

#### Java 버전 확인
```sh
java --version
```

### 2. Jenkins 설치 
#### 1. jenkins 설치를 위한 repository 추가
```sh
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
```

#### 2. 서버의 resource.list 에 Jenkins 저장소 추가 
```sh
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
```

#### 3. 패키지 인덱스 정보 업데이트
```sh
sudo apt-get update
```

#### 4. jenkins 패키지 설치
```sh
sudo apt-get install jenkins
```

#### 5. jenkins 실행 및 종료
```sh
sudo systemctl start jenkins # 실행
sudo systemctl stop jenkins  # 종료
```