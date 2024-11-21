package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.repository.UserRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ResourceLoader resourceLoader;

    private Path root;

    @PostConstruct
    public void init() {
        try {
            Resource resource = resourceLoader.getResource("classpath:static/images/avatar");
            root = Paths.get(resource.getFile().getAbsolutePath());
            Files.createDirectories(root);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize folder for upload!", e);
        }
    }

    // Các phương thức còn lại giữ nguyên
    public List<Users> getAllUsers() {
        return userRepository.findAll();
    }

    public Users getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public Users saveUser(Users user, MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Files.copy(file.getInputStream(), root.resolve(filename));
            user.setImagePath(filename);
        } else {
            user.setImagePath("default-avatar.jpg");
        }

        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }

        return userRepository.save(user);
    }

    public void deleteUser(Long id) {
        Users user = getUserById(id);
        if (user != null && user.getImagePath() != null) {
            try {
                Files.deleteIfExists(root.resolve(user.getImagePath()));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        userRepository.deleteById(id);
    }
}