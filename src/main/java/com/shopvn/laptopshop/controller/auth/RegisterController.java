package com.shopvn.laptopshop.controller.auth;

import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.domain.dto.RegisterDTO;
import com.shopvn.laptopshop.service.UserService;
import jakarta.validation.Valid;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

@Controller
@RequestMapping("/register")
public class RegisterController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    public RegisterController(UserService userService,PasswordEncoder passwordEncoder){
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }
    @GetMapping
    public String getForm(Model model){
        model.addAttribute("registerUser", new RegisterDTO());
        return("/auth/register");
    }
    @PostMapping
    public String registerUser(@ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
                               BindingResult bindingResult) throws IOException {

        if (bindingResult.hasErrors()){
            return ("/auth/register");
        }

        Users user = this.userService.registerDTOtoUser(registerDTO);
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.saveUser(user, null);
        return("redirect:/login");
    }
}
