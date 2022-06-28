# WeakHashMap
> 더 이상 사용하지 않는 객체를 GC할 때 자동으로 삭제해주는 Map
- Key가 더 이상 강하게 레퍼런스(strong reference)되는 곳이 없다면 해당 엔트리를 제거한다.
- Map의 엔트리를 Key에 의존하는 경우 사용할 수 있다.
- 캐시를 구현하는데 사용할 수 있지만, 직접 구현을 권장하지 않는다.

[공식문서](https://docs.oracle.com/javase/7/docs/api/java/util/WeakHashMap.html)