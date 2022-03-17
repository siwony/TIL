# Entity
: DB에서 영속적으로 저장된 데이터를 자바 객체로 매핑하여 '인스턴스의 형태' 로 존재하는 데이터  
>Entity 클래스는 실제 DataBase의 테이블과 1 : 1로 매핑 되는 클래스로, DB의 테이블내에 존재하는 컬럼을 속성(필드)으로 가져야 한다.

다음은 Spring Data JPA를 적용한 Entity이다.
```java
@Entity
@Table(name = "product")
@Getter  @Setter
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(length = 100, nullable = false)
    private String name;

    @Column(nullable = false) 
    private int price;

    @ManyToOne //n : 1 연관관계
    @JoinColumn(name ="category_id",nullable = false)
    private Category category;

    // 1 : n 연관관계
    @OneToMany(mappedBy = "product")
    private Set<Cart> carts;
}
```

**table 이 아니라 entity인 이유**
> 기본적으로 JPA는 모든 필드를 불러오게 한다.  
> 하지만 모든 케이스에서 모든 필드를 다루지 않는다  
> 그래서 테이블은 한개지만, entity or DTO는 경우에 따라서 여러 개를 만들 수 있다.