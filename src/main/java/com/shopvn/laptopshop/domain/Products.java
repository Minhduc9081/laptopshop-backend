package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
@Table(name = "products")
public class Products {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Long price;
    private String image;
    private String detailDescription;
    private String shortDescription;
    private Long quantity;
    private Long sold;
    private String manufacture;
    private String target;

    //reverse side detail
    @OneToMany(mappedBy = "product")
    List<OrderDetail> orderDetails;
}
