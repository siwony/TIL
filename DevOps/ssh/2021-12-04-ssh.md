---
layout: post
author: "정시원"
title: "SSH (Secure Shell Protocol)"
categories: DevOps
date: 2021-12-04
tags: [ssh]
---

# SSH (Secure Shell Protocol)
: 네트워크 프로토콜 중 하나로 **컴퓨터와 컴퓨터가 인터넷과 같은 Public Network를 통해 서로 통신을 할 때 보안적으로 안전하게 통신을 하기 위해 사용하는 프로토콜**

### SSH의 통신 방식
: 한 쌍의 Key를 통해 접속하려는 컴퓨터와 인증 과정을 거치며 연결이 되는프로토콜 이다.  

**Private Key**
- 공개되어도 안전한 키
- Public Key를 통해 메시지를 전송하기 전 암호화를 하게 된다.
- 암호화는 가능하지만 복호화는 불가능하다.

**Public key**
- 절대로 공개되면 안되는 키
- 암호화된 메시지를 복호화 할 수 있다.

### 사용처
- **데이터 전송**  
    GitHub 등...
- **원격접속**  
    AWS 등..