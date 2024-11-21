package com.shopvn.laptopshop.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Cấu hình các thư mục static cơ bản
        registry.addResourceHandler("/static/**")
                .addResourceLocations("classpath:/static/");

        // Cấu hình cho từng loại resource
        registry.addResourceHandler("/css/**")
                .addResourceLocations("classpath:/static/css/");

        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/");

        // Cấu hình cho images
        registry.addResourceHandler("/images/**")
                .addResourceLocations("classpath:/static/images/");

        // Cấu hình riêng cho client resources
        registry.addResourceHandler("/client/**")
                .addResourceLocations("classpath:/static/client/");
    }
}