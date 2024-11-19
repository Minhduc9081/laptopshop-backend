package com.shopvn.laptopshop.repository;

import com.shopvn.laptopshop.domain.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
//LOGIC XỬ LÝ
public interface UserRepository extends JpaRepository<Users,Long> {
    Users findByEmail(String email);
}
