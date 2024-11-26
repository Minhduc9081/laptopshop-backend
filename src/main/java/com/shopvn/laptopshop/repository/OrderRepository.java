package com.shopvn.laptopshop.repository;

import com.shopvn.laptopshop.domain.Orders;
import com.shopvn.laptopshop.domain.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Orders, Long> {
    List<Orders> findByUser(Users user);
}
