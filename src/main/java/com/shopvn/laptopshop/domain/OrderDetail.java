package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "order_detail")
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long quantity;
    private double price;

    //order_id long
    @ManyToOne
    @JoinColumn(name = "order_id")
    private Orders order;
    //product_id long
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Products product;}
