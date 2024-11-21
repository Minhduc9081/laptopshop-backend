package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Data;

@Entity
@Data
@Table(name = "order_detail")
public class OrderDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull(message = "Quantity cannot be null")
    @Min(value = 1, message = "Quantity must be at least 1")
    private Long quantity;

    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    private double price;

    // Association with Orders (owner side)
    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    @NotNull(message = "Order cannot be null")
    private Orders order;

    // Association with Products (owner side)
    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    @NotNull(message = "Product cannot be null")
    private Products product;
}
