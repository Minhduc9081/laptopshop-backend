package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.repository.ProductRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private ResourceLoader resourceLoader;

    private Path root;

    @PostConstruct
    public void init() {
        try {
            Resource resource = resourceLoader.getResource("classpath:static/images/product");
            root = Paths.get(resource.getFile().getAbsolutePath());
            Files.createDirectories(root);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize folder for upload!", e);
        }
    }

    // Các phương thức còn lại giữ nguyên
    public List<Products> getAllProducts() {
        return productRepository.findAll();
    }

    public Products getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public Products saveProduct(Products products, MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Files.copy(file.getInputStream(), root.resolve(fileName));
            products.setImagePath(fileName);
        }
        return productRepository.save(products);
    }

    public void deleteProduct(Long id) {
        Products products = getProductById(id);
        if (products != null && products.getImagePath() != null) {
            try {
                Files.deleteIfExists(root.resolve(products.getImagePath()));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        productRepository.deleteById(id);
    }
}