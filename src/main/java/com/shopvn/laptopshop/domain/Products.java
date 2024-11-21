package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
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

    @NotBlank(message = "Product name cannot be blank")
    private String name;

    @NotNull(message = "Price cannot be null")
    @Min(value = 0, message = "Price must be greater than or equal to 0")
    private Long price;

    private String imagePath;

    @NotBlank(message = "Detail description cannot be blank")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDescription;

    @NotBlank(message = "Short description cannot be blank")
    private String shortDescription;

    @NotNull(message = "Quantity cannot be null")
    @Min(value = 0, message = "Quantity must be greater than or equal to 0")
    private Long quantity;

    @NotNull(message = "Sold quantity cannot be null")
    @Min(value = 0, message = "Sold quantity must be greater than or equal to 0")
    private Long sold;

    @NotBlank(message = "Manufacture cannot be blank")
    private String manufacture;

    @NotBlank(message = "Target cannot be blank")
    private String target;

    // Reverse side detail
    @OneToMany(mappedBy = "product")
    List<OrderDetail> orderDetails;
}
