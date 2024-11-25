package com.shopvn.laptopshop.domain.dto;

import com.shopvn.laptopshop.service.validator.RegisterChecked;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@RegisterChecked
public class RegisterDTO {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String rePassword;
}
