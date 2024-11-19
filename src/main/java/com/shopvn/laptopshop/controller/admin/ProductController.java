package com.shopvn.laptopshop.controller.admin;

import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/admin/products")
public class ProductController {

    @Autowired
    private ProductService productService;
    @GetMapping
    public String listProduct(Model model){
        model.addAttribute("products", productService.getAllProducts());
        return "admin/product/list";
    }
    @GetMapping("/create")
    public String showAddForm(Model model){
        model.addAttribute("product", new Products());
        return "admin/product/create";
    }
    @PostMapping("/create")
    public String addProduct(@ModelAttribute Products products,
                             @RequestParam("image")MultipartFile file) throws IOException {
                            //ÁNH XẠ SANG HTML "image" CÓ THAM SỐ "file"
        productService.saveProduct(products,file);
        return "redirect:/admin/products";
    }
    @GetMapping("/view/{id}")
    public String viewProductDetail(@PathVariable Long id, Model model){
        Products products = productService.getProductById(id);
        model.addAttribute("product",products);
        return "admin/product/view";
    }
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model){
        Products products = productService.getProductById(id);
        model.addAttribute("product",products);
        return "admin/product/edit";
    }
    @PostMapping("/edit/{id}")
    public String editProduct(@PathVariable Long id,
                              @ModelAttribute Products products,
                              @RequestParam(value = "image", required = false) MultipartFile file) throws IOException{
        Products existingProduct = productService.getProductById(id);
        products.setId(id);
        if (file == null || file.isEmpty()){
            products.setImagePath(existingProduct.getImagePath());
        }
        productService.saveProduct(products,file);
        return "redirect:/admin/products";
    }
    @PostMapping("/delete/{id}")
    public String deleteProduct(@PathVariable Long id){
        productService.deleteProduct(id);
        return "redirect:/admin/products";
    }
}
