package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import lombok.*;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
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
    @NotNull
    @Email
    @Email(message = "Email is not valid", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a zA-Z0-9.-]+$")
    private String email;
    @NotNull
    private String password;
    @NotNull
    private String fullName;
    private String address;
    @NotNull
    private String phone;
    @NotNull
    private String imagePath;

    // Instead of @ManyToOne, just use an enum with @Enumerated
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


