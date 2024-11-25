package com.shopvn.laptopshop.service;

import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Collections;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserService userService;
    public CustomUserDetailsService(UserService userService){
        this.userService = userService;
    }
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        //logic
        //user của mình
        com.shopvn.laptopshop.domain.Users users = this.userService.getUserByEmail(username);
        if (users == null){
            throw new UsernameNotFoundException("Invalid email or password.");
        }
        //import user của spring
        return new User(
                users.getEmail(),
                users.getPassword(),
                Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + users.getRole().name()))
        );
    }
}
