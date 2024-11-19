package com.shopvn.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductClientController {
    @GetMapping("/deltail")
    public String getDetailPage(){
        return "client/product/shop-detail";
    }
}
