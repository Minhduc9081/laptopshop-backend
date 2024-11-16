package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

//ORM

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
    private String email;
    private String password;
    private String fullName;
    private String address;
    private String phone;
    private String avatar;

    //roleId
    //owner side roles
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Roles role;

    //reverse side orders
    @OneToMany(mappedBy = "users")
    List<Orders> orders;
}
