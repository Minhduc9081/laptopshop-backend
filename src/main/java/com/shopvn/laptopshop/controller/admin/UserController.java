package com.shopvn.laptopshop.controller.admin;

import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.service.UserService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    private final UserService userService;
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public String listUsers(Model model){
        model.addAttribute("users", userService.getAllUsers());
        return "admin/user/list";
    }
    @GetMapping("/create")
    public String showAddForm(Model model){
        model.addAttribute("user", new Users());
        return "admin/user/create";
    }
    @PostMapping("/create")
    public String addUser(@Valid @ModelAttribute("user") Users user,
                          BindingResult userBindingResult,
                          @RequestParam("image") MultipartFile file
                          ) throws IOException {
        if (userBindingResult.hasErrors()){
            return "admin/user/create";
        }

        userService.saveUser(user,file);
        return "redirect:/admin/users";
    }
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model){
        Users user = userService.getUserById(id);
        model.addAttribute("user",user);
        return "admin/user/edit";
    }
    @GetMapping("/view/{id}")
    public String viewUserDetail(@PathVariable Long id, Model model) {
        Users user = userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/view";
    }
    @PostMapping("/edit/{id}")
    public String updateUser(@PathVariable Long id, @ModelAttribute Users user,
                             @RequestParam(value = "image", required = false) MultipartFile file) throws IOException {
        Users existingUser = userService.getUserById(id);
        user.setId(id);
        if (file == null || file.isEmpty()) {
            user.setImagePath(existingUser.getImagePath());
        }
        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            user.setPassword(existingUser.getPassword());
        }
        userService.saveUser(user, file);
        return "redirect:/admin/users";
    }

    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
        return "redirect:/admin/users";
    }
}
