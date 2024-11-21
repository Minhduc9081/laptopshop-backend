package com.shopvn.laptopshop.controller.client;

import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductClientController {
    private final ProductService productService;
    public ProductClientController(ProductService productService){
        this.productService = productService;
    }
    @GetMapping("/detail/{id}")
    public String getDetailPage(Model model, @PathVariable Long id){
        Products products = productService.getProductById(id);
        model.addAttribute("product",products);
        return "client/product/shop-detail";
    }
}
