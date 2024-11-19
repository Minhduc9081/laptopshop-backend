package com.shopvn.laptopshop.controller.admin;

import com.shopvn.laptopshop.domain.Orders;
import com.shopvn.laptopshop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@Controller
@RequestMapping("/admin/order")
public class OrderController {
    private OrderService orderService;

    public OrderController(OrderService orderService){
        this.orderService = orderService;
    }

    @GetMapping
    public String getOrder(Model model){
        model.addAttribute("orders", orderService.getAllOrders());
        return "admin/order/list";
    }
    @GetMapping("/create")
    public String showAddPage(Model model){
        model.addAttribute("order", new Orders());
        return "admin/order/create";
    }
    @PostMapping("/create")
    public String createOrder(@ModelAttribute Orders orders){
        orderService.saveOrder(orders);
        return "redirect:/admin/order";
    }
    @GetMapping("/view/{id}")
    public String showViewPage(@PathVariable Long id, Model model){
        Orders orders = orderService.getOrderById(id);
        model.addAttribute("order", orders);
        return "admin/order/view";
    }
    @GetMapping("/edit/{id}")
    public String showEditPage(@PathVariable Long id,Model model){
        Orders orders = orderService.getOrderById(id);
        model.addAttribute("order", orders);
        return "admin/order/edit";
    }
    @PostMapping("/edit/{id}")
    public String editOrder(@PathVariable Long id,
                            @ModelAttribute Orders orders) {
        Orders existingOrder = orderService.getOrderById(id);

        orders.setUsers(existingOrder.getUsers());  // Giữ nguyên user
        orders.setOrderDetails(existingOrder.getOrderDetails()); // Giữ order details
        orders.setId(id);

        orderService.saveOrder(orders);
        return "redirect:/admin/order";
    }
    @PostMapping("/delete/{id}")
    public String deleteOrder(@PathVariable Long id){
        orderService.deleteOrder(id);
        return "redirect:/admin/order";
    }

}
