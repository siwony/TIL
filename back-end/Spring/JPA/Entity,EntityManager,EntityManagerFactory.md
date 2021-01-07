# Entity, Entitymanager, EntityManagerFactory
## **Entity**
: DB에서 영속적으로 저장된 데이터를 자바 객체로 매핑하여 '인스턴스의 형태' 로 존재하는 데이터  
>Entity 클래스는 실제 DataBase의 테이블과 1 : 1로 매핑 되는 클래스로, DB의 테이블내에 존재하는 컬럼을 속성(필드)으로 가져야 한다.

```java
@Entity
@Table(name = "product")
@Getter
@Setter
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(length = 100, nullable = false)
    private String name;
    @Column(nullable = false)
    private int price;

    @ManyToOne
    @JoinColumn(name ="category_id",nullable = false)
    private Category category;

    @OneToMany(mappedBy = "product")
    private Set<Cart> carts;
}
```

**table 이 아니라 entity인 이유**
> 기본적으로 JPA는 모든 필드를 불러오게 구현돼있다.  
> 하진만 모든 케이스에서 모든 필드를 다 다루지 않는다  
> 그래서 테이블은 한개지만, entity는 경우에 따라서 여러 개를 만들 수 있다.
## **EntityManager**
: **Entity를 관리하는 역활을 수행하는 클래스**
> EntityManager 내부에 **영속성 컨텍스트(Persistence Context)** 라는 걸 두어서 Entity 관리
### **Persistence Context(영속성 컨텍스트)**
: **엔티티를 영구히 저장하는 환경**  
이라고 하지만 어떠한분은   
[**"영속성 컨텍스트를 관리하는 모든 엔티티 매니저가 초기화 및 종료되지 않는 한 엔티티를 영구히 저장하는 환경"**](https://perfectacle.github.io/2018/01/14/jpa-entity-manager-factory/) 라고 표현을 하신다.
### Entity Manager 와 PersistenceContext