# CAP Theorem
CAP 이론에서 CAP는 다음과 같이 분산 데이터베이스 시스템의 세 가지 속성인 일관성(Consistency), 가용성(Availability), 파티션 허용성(Partition tolerance)를 나타낸다,

|       속성       |                              설명                            |
|------------------|--------------------------------------------------------------|
|일관성            |모든 요청은 최신 데이터 또는 에러를 응답받는다.               |
|가용성            |모든 요청은 정상 응답을 받는다.                               |
|파티션 허용성     |노드간 통신이 실패하는 경우라도 시스템은 정상 동작 한다.      |

**(주의) 여기서 말하는 일관성은 ACID의 일관성과 다르다.**

### CAP 의 핵심
**CAP 이론에 따르면 분산 데이터베이스 시스템은 네트워크 파티션이 발생하였을 때 세 가지 속성 중 두 가지만 만족할 수 있다.**

#### 세 가지 속성 중 두가지를 만족하는 시스템
- CA(Consistency-Availablility)
- CP(Consistency-Partition tolerance)
- AP(Availability-Partition tolerance)

CAP 이론은 위와 같이 세 종류의 시스템으로 나뉘지만 CAP이론은 네트워크 파티션 상황을 가정하므로 CA 시스템은 있을 수 없다. CA 시스템이 가능하려면 네트워크 파티션이 없어야 한다. 하지만, 네트워크 파티션이 없으면 CAP이론 자체가 쓸모가 없고, 네트워크 파티션은 어떤 이유에서든지 발생할 수 있다.

분산 시스템에서 노드끼리 데이터를 주고 받을 때 타임아웃이 발생하는 모든 경우를 네트워크 파티션으로 볼 수 있다.  
여기서 타임아웃은 하드웨어 문제 뿐만 아니라 Java의 GC등 다양한 이유로 발생할 수 있따.


 
## CAP 이론 논란
- [DB를 CP나 AP라고 불리는 것 멈춰! 둘다 아니니깐](https://martin.kleppmann.com/2015/05/11/please-stop-calling-databases-cp-or-ap.html)
- [CAP 이론의 예외로 가장 잘 알려진 것은?](https://www.quora.com/Distributed-Databases-What-are-the-best-known-exceptions-for-CAP-theorem)

## Reference
- http://happinessoncode.com/2017/07/29/cap-theorem-and-pacelc-theorem/
- https://okky.kr/article/324449