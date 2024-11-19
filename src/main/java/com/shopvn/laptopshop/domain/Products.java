package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "products")
public class Products {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private Long price;
    private String imagePath;
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
