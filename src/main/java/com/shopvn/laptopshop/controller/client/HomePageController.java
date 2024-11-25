package com.shopvn.laptopshop.controller.client;

import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
public class HomePageController {

    private final ProductService productService;
    public HomePageController(ProductService productService){
        this.productService = productService;
    }
    @GetMapping
    public String getHomePage(Model model){
        model.addAttribute("products", productService.getAllProducts());
        return "client/homepage/show";
    }
    @GetMapping("/access-deny")
    public String getDeny(Model model){
        return "/auth/deny";
    }
}
