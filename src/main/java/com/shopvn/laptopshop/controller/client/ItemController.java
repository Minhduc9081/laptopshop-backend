package com.shopvn.laptopshop.controller.client;

import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.service.ProductService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cart")
public class ItemController {

    private final ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
    }
    @GetMapping
    public String getCartPage(){
        return "client/cart/cart";
    }
    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        Products products = this.productService.getProductById(id);
        model.addAttribute("product", products);
        model.addAttribute("id", id);
        return "client/product/detail";
    }
    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable Long id, HttpServletRequest request){
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String) session.getAttribute("email");

        this.productService.addProductToCart(email, productId,session);
        return "redirect:/";
    }

}
