# CASCADE(영속성 전이)
: 특정 엔티티를 영속상태로 만들 때 연관된 엔티티도 함께 영속상태로 만들고 싶을떄 사용한다.  
> 예: 부모 엔티티를 저장할 때 자식 엔티티도 함께 저장.
> 
<img width=450px src=./img/cascade.png>

- 단일 엔티티에 종속적일떄 사용한다. &rarr; 단일 소유자
- 라이프 사이클이 거의 유사할떄 사용한다.
### CASCADE 저장
`@OneToMany(mappedBy="parent", cascade=CascadeType.PERSIST)`  
<img width=450px src=./img/cascade-save.png>

### 예시
부모 클래스
```java
@Entity
public class Parent {
    @Id @GeneratedValue
    private Long id;

    private String name;

    @OneToMany(mappedBy=parent, casecade= CaseCadeType.ALL)
    private List<Childe> childList = new ArrayList<>();

    public void addChilde(Child Child){
        childList.add(child);
    }
}
```
자식 클래스
```java
@Entity
public class Child {
    @Id @GeneratedValue
    private Long id;

    private String name;

    @ManyToOne
    @JoinColumn("parent_id")
    Parent parent;
```
결과
```java
Child child1 = new Child();
Child child2 = new Child();

Parent parent = new Parent();
parent.addChild(child1);
parent.addChild(child2);

em.persist(parent) // 부모가 영속화 되면 자식도 같이 영속화 된다.
// em.persist(child1) caseCade로 인하여 부모와 함께 영속화 되어 안해도됨
// em.persist(child2)

```
### 주의사항
- 영속성 전이는 연관관계를 매핑하는 것과 아무 관련이 없다.
- 엔티티를 영속화할 때 연관된 엔티티도 함께 영속화 하는것만 제공할뿐 
- 자식의 소유자가 하나일때만 사용하자. `ex) 게시판` 

### 종류
- **ALL : 모두 적용**
- **PERSIST : 영속**
- **REMOVE : 삭제**
- MERGE : 병합
- REFRESH : REFRESH
- DETACH : DETACH