# Java의 날짜/시간을 나타내는 API
## Java8 이전
> `Date`, `Calendar`, `SimpleDateFormet`등...
### 문제점
#### 1. 객체명이 직관적이지 않다.
> Data객체가 날짜와 시간을 제공한다. &rarr; 객체명이 일관적이지 않다.
```java
Date date = new Date();
long time = date.getTime();
System.out.println(date); //날짜 출력 (ex. Sun Jun 21  15:32:35 PDT 2020)
System.out.println(time); // 1970년도를 지군으로 지금까지의 초를 나타낸다 (ex. 1938472839485)
```

#### 2. mutable하다.
> 서로 다른 여러 Threed에서 해당 Date객체를 모두 수정하게 된다면 예상치 못한 부수 효과가 일어날 것이다.
```java
Date date = new Date();
long time = date.getTime();
System.out.println(date); //출력 예시 - Sun Jun 21  15:32:32 PDT 2020

Thread.sleep(1000 * 3) //3초동안 해당 threed는 대기한다.
Date after3Sec = new Date();
System.out.println(after3Sec) // 출력 예시 Sun Jun 21  15:35:35 PDT 2020 // 3초증가

after3Sec.setTime(time) // 3초 전 시간을 set함
System.out.println(after3Sec) // 출력 예시 Sun Jun 21  15:35:35 PDT 2020 // date변수와 시간이 똑같아 졌다.
```

#### 3. Type safety하지 않다.
```java
Calendar calendar = new GregorianCalendar(1802, -9, -15); // 무려 날짜에 음수가 들어갈 수 있다.(모든 수를 정수형 - int로 받음)
Date dateCalender = calendar.getTime(); // Date타입을 반환한다.
System.out.println(dateCalender); // 출력: Mon Mar 16 00:00:00 KST 1801

Calendar calendar = new GregorianCalendar(1802, 9, 15); 
System.out.println(calendar.getTime()); // 출력: Fri Oct 15 00:00:00 KST 1802 // 9월을 입력했지만 8월로 출력되었다.
```

## Java8 이후
> Instence, LocalData, LocalDateTime
#### 지금 시간을 기계 시간으로 표현하는 방법
- `Instant.now()`
  >현재 UTC (GMT)를 리턴한다. Universal Time Coordinated == Greenwich Mean Time

예시
```java
Instant now = Instant.now();
System.out.println(now); // 예시. 2021-08-31T14:26:51.212729Z
System.out.println(now.atZone(ZoneId.of("UTC"))); //예시. 2021-08-31T14:26:51.212729Z[UTC] 

ZonedDateTime zonedDateTime = now.atZone(ZoneId.systemDefault());
System.out.println(zonedDateTime); // 예시. 2021-08-31T23:26:51.212729+09:00[Asia/Seoul]
```

#### 인류용 시간을 표현하는 방법
- `LocalDateTime.now()`
  > 현재 시스템 Zone에 해당하는(로컬) 일시를 리턴한다.
- `LocalDateTime.of(int, Month, int, int, int, int)`
  > 로컬의 특정 일시를 리턴한다.
- `ZonedDateTime.of(int, Month, int, int, int, int, ZoneId)`
  > 특정 Zone의 특정 일시를 리턴한다.

#### 기간을 표현하는 방법
> `Period` / `Duration.between()`
```java
LocalDate today = LocalDate.now();
LocalDate nextYearBirthDay = LocalDate.of(2022, Month.APRIL, 22);
Period between = Period.between(today, nextYearBirthDay);
System.out.println("month: " + between.getMonths() + " day: "+between.getDays()); // 예시. month: 7 day: 22 (2021, 8, 31기준)
```

#### 날짜 포멧팅
- `DataTimeFormatter`
- [미리 정의한 포멧팅 참고](https://docs.oracle.com/javase/8/docs/api/java/time/format/DateTimeFormatter.html#predefined)
```java
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/d/yyyy");
LocalDate date = LocalDate.parse("07/15/1982", formatter);
//  LocalDate date = LocalDate.ISO_DATE_TIME; // 포메싱 예시
System.out.println(date); // 예시. 1982-07-15
System.out.println(today.format(formatter)); // 예시. 09/2/2021
```

#### 레거시 API 지원
- `GregorianCalendar`와 `Date` 타입의 인스턴스를 `Instant`나 `ZonedDateTime`으로 변환 가능. 
- `java.util.TimeZone`에서 `java.time.ZoneId`로 상호 변환 가능.
```java
ZoneId newZoneAPI = TimeZone.getTimeZone("PST").toZoneId();
TimeZone legacyZoneAPI = TimeZone.getTimeZone(newZoneAPI);
Instant newInstant = new Date().toInstant();
Date legacyInstant = Date.from(newInstant);
```