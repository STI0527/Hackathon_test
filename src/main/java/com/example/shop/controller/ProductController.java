package com.example.shop.controller;

import com.example.shop.enums.AdvertType;
import com.example.shop.models.Image;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.services.ProductService;
import com.example.shop.services.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final UserService userService;

//Через анотацію @RequiredArgsConstructor ці рядки не потрібні;
    //____________________________________________________________
//    public ProductController(ProductService productService) {
//        this.productService = productService;
//    }


    @GetMapping("/")
    public String main(@RequestParam(name = "title", required = false) String title, Model model, Principal principal,
                           Authentication authentication, User user) throws IOException {

        if (authentication instanceof OAuth2AuthenticationToken token) {
            // Якщо аутентифікація через OAuth2
            userService.createUserFromOAuth2(model, token);
            String email = token.getPrincipal().getAttribute("email");
            user = userService.getUserByEmail(email);
            model.addAttribute("user", user);
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            // Якщо аутентифікація через ім'я користувача та пароль
            model.addAttribute("user", productService.getUserByPrincipal(principal));
        }

        return "main";
    }

    @PostMapping("/products/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3,
                                @RequestParam("type") AdvertType type,
                                Product product, Principal principal) throws IOException {

        product.setType(type);
        productService.saveProduct(principal, product, file1, file2, file3);
        return "redirect:/";
    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return "redirect:/";
    }

    @GetMapping("/products/{id}")
    public String productInfo(@PathVariable String id, Model model, Principal principal,
                              HttpServletRequest request,
                              HttpSession session) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Product product = productService.getProductById(iD);

        model.addAttribute("user", userService.getUserByPrincipal(principal));
        if(product == null){
            model.addAttribute("productNotFound", "Товар було вилучено адміністратором");
            return "product_info";
        }

        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());

        String data = liqPayService.generateData(
                productService.getProductById(iD).getPrice(),
                "UAH",
                "Оплата замовлення " + productService.getProductById(iD).getTitle(),
                "https://f68b-89-209-136-227.ngrok-free.app/payment/result",
                "https://f68b-89-209-136-227.ngrok-free.app/payment/result"
        );

        String signature = liqPayService.generateSignature(data);

        String userAgent = request.getHeader("User-Agent");
        String os = orderService.getOperationalSystem(userAgent);

        session.setAttribute("user_id", productService.getUserByPrincipal(principal).getId());
        session.setAttribute("product_id", iD);
        session.setAttribute("os", os);

        // Передача форми для LiqPay
        model.addAttribute("liqPayData", data);
        model.addAttribute("liqPaySignature", signature);
        model.addAttribute("user_id", productService.getUserByPrincipal(principal).getId());
        return "product_info";
    }

    @PostMapping("/")
    public String toMain(){
        return "redirect:/";
    }
}
