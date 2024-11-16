package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.Roles;
import com.shopvn.laptopshop.repository.RoleRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleService {
    private final RoleRepository roleRepository;

    public RoleService(RoleRepository roleRepository){
        this.roleRepository = roleRepository;
    }


    public List<Roles> getAllRoles() {
        return roleRepository.findAll();
    }
    public Roles getRoleById(Long id) {
        return roleRepository.findById(id)
                .orElse(null);
    }
}
