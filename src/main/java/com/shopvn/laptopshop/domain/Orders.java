package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
@Table(name = "orders")
public class Orders {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Double price;

    //userID
    //owner side users
    @ManyToOne
    @JoinColumn(name = "user_id")
    private Users users;

    //reverse side detail
    @OneToMany(mappedBy = "order")
    List<OrderDetail> orderDetails;
}
