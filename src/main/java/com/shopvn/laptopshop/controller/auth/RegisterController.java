package com.shopvn.laptopshop.controller.auth;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RegisterController {
    @GetMapping("/register")
    public String getForm(){
        return("/auth/register");
    }
}
