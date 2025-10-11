---
layout: post
author: "정시원"
title: "Payload(페이로드)"
categories: back-end
date: 2021-03-11
tags: []
---

# Payload(페이로드)
데이터를 전송할때, 헤더와 메타데이터, 에러 체크 비트 등과 같은 다양한 요소들을 함께 보내어 데이터 전송의 효율과 안정성을 높이게 된다.  
**이 때, 보내고자 하는 ``데이터 자체``를 의미하는 것을 바로 payload이다.**
- 

### 예시
json으로 보는 실제 데이터에서 payload는 아래의 json 에서 `data`이다.  
그 이외의 데이터들은 전부 통신을 하는데 있어 용이하게 해주는 부가적인 정보들이다.
```json
{
	"status" : 200,
	"from": "localhost",
	"to": "http://melonicedlatte.com/chatroom/1",
	"method": "GET",
	"data":{ "message" : "There is a cutty dog!" }
}
```
- data는 client가 관심을 가지는 페이로드 이다.
- 나머지 부분은, 중요하긴 하지만, 프로토콜 오버헤드이다.

### 번외)  Payload 기원
``페이로드(payload)``라는 단어는 운송업에서 비롯하였는데, **지급(pay)해야 하는 적화물(load)을 의미**한다.  

유조선 트럭이 20톤의 기름을 운반한다면 트럭의 총 무게는 차체, 운전자 등의 무게 때문에 그것보다 더 될 것이다.  
이 모든 무게를 운송하는데 비용이 들지만, 고객은 오직 기름의 무게만을 지급(pay)하게 된다.  
그래서 ‘pay-load’란 말이 나온 것이다