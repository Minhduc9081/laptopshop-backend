package com.shopvn.laptopshop.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "carts")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Quan hệ 1-1 với User
    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private Users users;

    // Quan hệ 1-N với CartDetail
    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CartDetail> cartDetails = new ArrayList<>();

    // Tổng số lượng sản phẩm trong giỏ hàng
    @Min(value = 0)
    private Integer sum = 0;

    // Helper method để thêm cart detail
    public void addCartDetail(CartDetail cartDetail) {
        cartDetails.add(cartDetail);
        cartDetail.setCart(this);
        updateSum();
    }

    // Helper method để xóa cart detail
    public void removeCartDetail(CartDetail cartDetail) {
        cartDetails.remove(cartDetail);
        cartDetail.setCart(null);
        updateSum();
    }

    // Method cập nhật tổng số lượng
    private void updateSum() {
        this.sum = cartDetails.stream()
                .mapToInt(CartDetail::getQuantity)
                .sum();
    }
}
