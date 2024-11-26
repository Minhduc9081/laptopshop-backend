package com.shopvn.laptopshop.service;

import com.shopvn.laptopshop.domain.*;
import com.shopvn.laptopshop.repository.CartDetailRepository;
import com.shopvn.laptopshop.repository.CartRepository;
import com.shopvn.laptopshop.repository.ProductRepository;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final ResourceLoader resourceLoader;
    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;
    private final UserService userService;
    private Path root;

    public ProductService(
            ProductRepository productRepository,
            ResourceLoader resourceLoader,
            CartDetailRepository cartDetailRepository,
            CartRepository cartRepository,
            UserService userService
    ) {
        this.productRepository = productRepository;
        this.resourceLoader = resourceLoader;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.userService = userService;
    }

    @PostConstruct
    public void init() {
        try {
            Resource resource = resourceLoader.getResource("classpath:static/images/product");
            root = Paths.get(resource.getFile().getAbsolutePath());
            Files.createDirectories(root);
        } catch (IOException e) {
            throw new RuntimeException("Could not initialize folder for upload!", e);
        }
    }

    public List<Products> getAllProducts() {
        return productRepository.findAll();
    }

    public Products getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    public Products saveProduct(Products products, MultipartFile file) throws IOException {
        if (file != null && !file.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Files.copy(file.getInputStream(), root.resolve(fileName));
            products.setImagePath(fileName);
        }
        return productRepository.save(products);
    }

    public void deleteProduct(Long id) {
        Products products = getProductById(id);
        if (products != null && products.getImagePath() != null) {
            try {
                Files.deleteIfExists(root.resolve(products.getImagePath()));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        productRepository.deleteById(id);
    }

    public void addProductToCart(String email, Long productId, HttpSession session, long quantity) {
        // Implementation for adding product to cart
        Users users = this.userService.getUserByEmail(email);
        if (users != null){
            //check user da co cart hay chua
            Cart cart = this.cartRepository.findByUsers(users);

            if (cart == null){
                //tao moi cart
                Cart cart1 = new Cart();
                cart1.setUsers(users);
                cart1.setSum(1);

                cart = this.cartRepository.save(cart1);
            }
            //luu cart_detail
            //tim product by Id
            Optional<Products> products = this.productRepository.findById(productId);
            if (products.isPresent()){
                Products realProduct = products.get();

                //check san pham da tung duoc them vao gio hang hay chua
                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart,realProduct);
                if (oldDetail == null){
                    CartDetail cartDetail = new CartDetail();
                    cartDetail.setCart(cart);
                    cartDetail.setProduct(realProduct);
                    cartDetail.setPrice(realProduct.getPrice());
                    cartDetail.setQuantity(1);
                    this.cartDetailRepository.save(cartDetail);

                    //update cart (sum)
                    int s = cart.getSum() + 1;
                    cart.setSum(cart.getSum() + 1);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum",cart.getSum() + 1);
                }else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(oldDetail);
                }


            }
        }
    }
    public Cart fetchByUser(Users user) {
        return this.cartRepository.findByUsers(user);
    }
    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
            // delete cart-detail
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getSum() > 1) {
                // update current cart
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(
            Users user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone) {

        // step 1: get cart by user
        Cart cart = this.cartRepository.findByUsers(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();

            if (cartDetails != null) {

                // create order
                Orders order = new Orders();
                order.setUsers(user);

                double sum = 0;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice();
                }
                order.setTotalPrice(sum);
                order = this.orderRepository.save(order);

                // create orderDetail

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(Long.valueOf(cd.getQuantity()));

                    this.orderDetailRepository.save(orderDetail);
                }

                // step 2: delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                this.cartRepository.deleteById(cart.getId());

                // step 3 : update session
                session.setAttribute("sum", 0);
            }
        }

    }

}