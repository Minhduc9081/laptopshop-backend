package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.repository.ProductRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
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
    private final Path root = Paths.get("src/main/webapp/resources/images/product");
    @PostConstruct
    public void init() {
        try {
            Files.createDirectories(root);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize folder for upload!");
        }
    }

    public List<Products> getAllProducts(){
        return productRepository.findAll();
    }
    public Products getProductById(Long id){
        return productRepository.findById(id).orElse(null);
    }
    public Products saveProduct(Products products, MultipartFile file) throws IOException{
        if (file != null && !file.isEmpty()){
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Files.copy(file.getInputStream(), root.resolve(fileName));
            products.setImagePath(fileName);
        }
    return productRepository.save(products);
    }
    public void deleteProduct(Long id){
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
