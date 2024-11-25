package com.shopvn.laptopshop.repository;

import com.shopvn.laptopshop.domain.Cart;
import com.shopvn.laptopshop.domain.CartDetail;
import com.shopvn.laptopshop.domain.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Products products);
    CartDetail findByCartAndProduct(Cart cart, Products products);
}
