package com.shopvn.laptopshop.controller.admin;

import com.shopvn.laptopshop.domain.Roles;
import com.shopvn.laptopshop.domain.Users;
import com.shopvn.laptopshop.service.RoleService;
import com.shopvn.laptopshop.service.UploadService;
import com.shopvn.laptopshop.service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin/user")
public class UserController {
    private final UserService userService;
    private final RoleService roleService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(
            UserService userService,
            RoleService roleService,
            UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.roleService = roleService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }
    @GetMapping
    public String getUserPage(Model model){
        List<Users> users = this.userService.getAllUsers();
        List<Roles> roles = this.roleService.getAllRoles();
        model.addAttribute("users",users);

        //theem đối tượng user mới để binding form
        Users user = new Users();
        model.addAttribute("user",user);
        model.addAttribute("roles", roles);

        return "admin/user/show";
    }

    @PostMapping("/create")
    public String createUser(@ModelAttribute Users users,
                             @RequestParam("role") Long roleId,
                             @RequestParam("avatarFile")MultipartFile file){
        Roles role = roleService.getRoleById(roleId);
        users.setRole(role);

        String avatar = this.uploadService.handleSaveUploadFile(file,"avatar");
        String hashPassword = this.passwordEncoder.encode(users.getPassword());

        users.setAvatar(avatar);
        users.setPassword(hashPassword);

        userService.saveUser(users);

        this.uploadService.handleSaveUploadFile(file,"avatar");
        return "redirect:/admin/user";
    }

    @PostMapping("/update/{id}")
    public String updateUser(@PathVariable("id") Long id,
                             @ModelAttribute Users users) {
        users.setId(id);
        userService.updateUser(users);

        return "redirect:/admin/user";
    }
    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable("id") Long id,
                             RedirectAttributes redirectAttributes){
        userService.deleteUser(id);
        return "redirect:/admin/user";
    }
}
