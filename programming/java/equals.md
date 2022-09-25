# equals

### equals를 재정의 하지 않아도 되는 상황
> equals는 재정의 하지 않는 것이 최선이다.
- 각 인스턴스가 본질적으로 고유하다.
  > ex. singleton 객체, enum
- 인스턴스의 '논리적 동치성'을 검사할 필요가 없다.
- 상위 클래스에서 재정의한 equals가 하위 클래스에도 적절하다.
  > List, Set등...
- 클래스가 private이거나 package-privete이고 equals 메서드를 호출할 일이 없다.

## equals 규약 
#### 요약
- 반사성: `A.equals(A) == true`
- 대칭성: `A.equals(B) == B.equals(A)`
- 추이성: (`A.equals(B)` && `B.equals(C)`) == `A.equals(C)`
- 일관성: `A.equals(B)` == A.equals(B)
