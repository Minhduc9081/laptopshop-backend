package com.shopvn.laptopshop.controller.client;

import com.shopvn.laptopshop.domain.Orders;
import com.shopvn.laptopshop.domain.Products;
import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.service.OrderService;
import com.shopvn.laptopshop.service.ProductService;
import com.shopvn.laptopshop.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/")
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final OrderService orderService;

    public HomePageController(
            ProductService productService,
            UserService userService,
            PasswordEncoder passwordEncoder,
            OrderService orderService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.orderService = orderService;
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
    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        Users currentUser = new Users();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        List<Orders> orders = this.orderService.fetchOrderByUser(currentUser);
        model.addAttribute("orders", orders);

        return "client/cart/order-history";
    }
}
