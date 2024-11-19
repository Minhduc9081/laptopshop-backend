package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Orders;
import com.shopvn.laptopshop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    public List<Orders> getAllOrders(){
        return orderRepository.findAll();
    }
    public Orders getOrderById(Long id){
        return orderRepository.findById(id).orElse(null);
    }
    public Orders saveOrder(Orders orders){
        return orderRepository.save(orders);
    }
    public void deleteOrder(Long id){
        Orders orders = getOrderById(id);
        orderRepository.deleteById(id);
    }

}
