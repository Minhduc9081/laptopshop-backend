package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.domain.dto.RegisterDTO;
import com.shopvn.laptopshop.repository.UserRepository;
import jakarta.annotation.PostConstruct;
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
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ResourceLoader resourceLoader;
    private Path root;

    // Constructor Injection
    public UserService(UserRepository userRepository,
                       PasswordEncoder passwordEncoder,
                       ResourceLoader resourceLoader) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.resourceLoader = resourceLoader;
    }

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

    public Users.UserRole getRoleByName(String roleName) {
        try {
            return Users.UserRole.valueOf(roleName.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Role name is invalid " + roleName);
        }
    }

    public Users registerDTOtoUser(RegisterDTO registerDTO) {
        Users user = new Users();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        return user;
    }

    public boolean checkEmailExists(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public Users getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }
}