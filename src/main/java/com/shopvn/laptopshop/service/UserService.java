package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    private UserRepository userRepository;
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    public void saveUser(Users user) {
        Users users = this.userRepository.save(user);
        System.out.println(users);
    }
    public List<Users> getAllUsers() {
        return userRepository.findAll();
    }
    public Users getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
    public void updateUser(Users users){
        userRepository.save(users);
    }
    public void deleteUser(Long id){
        userRepository.deleteById(id);
    }
}
