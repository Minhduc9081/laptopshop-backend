package com.shopvn.laptopshop.repository;

import com.shopvn.laptopshop.domain.Users;
import jakarta.persistence.Id;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
//LOGIC XỬ LÝ
public interface UserRepository extends JpaRepository<Users,Long> {

}
