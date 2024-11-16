package com.shopvn.laptopshop.service.Impl;

import com.shopvn.laptopshop.domain.Users;

import java.util.List;
import java.util.Optional;

public interface UserServiceImpl {
    List<Users> getAllUsers();
    Users updatedUser(Long id, Users updatedUser);
}
