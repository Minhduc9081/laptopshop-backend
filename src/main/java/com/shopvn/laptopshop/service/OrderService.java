package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Orders;
import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.repository.OrderRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    public List<Orders> getAllOrders() {
        return orderRepository.findAll();
    }

    public Orders getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    public Orders saveOrder(Orders orders) {
        return orderRepository.save(orders);
    }

    public void deleteOrder(Long id) {
        Orders orders = getOrderById(id);
        orderRepository.deleteById(id);
    }
    public List<Orders> fetchOrderByUser(Users user) {
        return this.orderRepository.findByUser(user);
    }
}