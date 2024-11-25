package com.shopvn.laptopshop.repository;

import com.shopvn.laptopshop.domain.Cart;
import com.shopvn.laptopshop.domain.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUsers(Users users);
}
