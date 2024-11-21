package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "users")
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Email cannot be blank")
    @Email
    @Email(message = "Email is not valid", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @NotBlank(message = "Password cannot be blank")
    @Size(min = 6)
    private String password;

    @NotBlank(message = "Name cannot be blank")
    private String fullName;

    @NotBlank(message = "Address cannot be blank")
    private String address;

    @NotBlank(message = "Phone cannot be blank")
    private String phone;

    private String imagePath;

    // Instead of @ManyToOne, just use an enum with @Enumerated
    @NotNull(message = "Role cannot be null")
    @Enumerated(EnumType.STRING)
    @Column(name = "role")
    private UserRole role;

    // Reverse side orders
    @OneToMany(mappedBy = "users")
    List<Orders> orders;

    // Enum definition for UserRole
    public enum UserRole {
        ADMIN, USER
    }
}


