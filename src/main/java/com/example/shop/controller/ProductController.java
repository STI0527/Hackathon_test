package com.example.shop.controller;

import com.example.shop.enums.AdvertType;
import com.example.shop.enums.Rewards;
import com.example.shop.enums.TypeOfPayment;
import com.example.shop.models.Image;
import com.example.shop.models.Notification;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.repositories.NotificationRepository;
import com.example.shop.services.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {

    private final ProductService productService;
    private final UserService userService;
    private final LiqPayService liqPayService;
    private final OrderService orderService;
    private final CurrencyExchangeService currencyExchangeService;
    private final NotificationService notificationService;
    private final ExchangeApplicationService exchangeApplicationService;

//Через анотацію @RequiredArgsConstructor ці рядки не потрібні;
    //____________________________________________________________
//    public ProductController(ProductService productService) {
//        this.productService = productService;
//    }


    @GetMapping("/")
    public String main(@RequestParam(name = "title", required = false) String title, Model model, Principal principal,
                           Authentication authentication, User user,
                       HttpServletRequest httpServletRequest) throws IOException {

        if (authentication instanceof OAuth2AuthenticationToken token) {
            // Якщо аутентифікація через OAuth2
            userService.createUserFromOAuth2(model, token);
            String email = token.getPrincipal().getAttribute("email");
            user = userService.getUserByEmail(email);
            user.setCoins(BigDecimal.valueOf(user.getCoins())
                    .setScale(1, RoundingMode.HALF_UP)
                    .doubleValue());

            model.addAttribute("user", user);
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            // Якщо аутентифікація через ім'я користувача та пароль
            user = userService.getUserByPrincipal(principal);
            user.setCoins(BigDecimal.valueOf(user.getCoins())
                    .setScale(1, RoundingMode.HALF_UP)
                    .doubleValue());
            model.addAttribute("user", productService.getUserByPrincipal(principal));
        }

        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));

        CsrfToken token = (CsrfToken) httpServletRequest.getAttribute("_csrf");
        model.addAttribute("csrfParameterName", token.getParameterName());
        model.addAttribute("csrfToken", token.getToken());
        return "main";
    }


    @PostMapping("/products/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3,
                                @RequestParam("type") AdvertType type,
                                Product product, Principal principal,Authentication authentication) throws IOException {

        product.setType(type);
        if (authentication instanceof UsernamePasswordAuthenticationToken)
            productService.saveProduct(principal, product, file1, file2, file3);
        else if (authentication instanceof OAuth2AuthenticationToken token)
            productService.saveProduct(token, product, file1, file2, file3);
        return "redirect:/";

    }

    @PostMapping("/products/delete/{id}")
    public String deleteProduct(@PathVariable String id) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        productService.deleteProduct(iD);
        return "redirect:/";
    }

    @GetMapping("/products/{id}")
    public String productInfo(@PathVariable String id, Model model, Principal principal,
                              HttpServletRequest request,
                              HttpSession session,Authentication authentication) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Product product = productService.getProductById(iD);
        double virtualPrice = (product.getPrice() / currencyExchangeService.getEuroToUahRate()) * productService.getCurrencyIndex();

        product.setVirtualPrice(BigDecimal.valueOf(virtualPrice)
                .setScale(1, RoundingMode.HALF_UP)
                .doubleValue());


        if (authentication != null) {
            User user = null;
            if (authentication instanceof OAuth2AuthenticationToken token) {
                user = userService.getUserByEmail(token.getPrincipal().getAttribute("email"));
                user.setCoins(BigDecimal.valueOf(user.getCoins())
                        .setScale(1, RoundingMode.HALF_UP)
                        .doubleValue());

                model.addAttribute("user", user);

            } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
                user = userService.findUserByPrincipal(principal.getName());

                user.setCoins(BigDecimal.valueOf(user.getCoins())
                        .setScale(1, RoundingMode.HALF_UP)
                        .doubleValue());

                model.addAttribute("user", user);

            }
            model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
            model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));


            if(product.getType() == AdvertType.EXCHANGE && product.getUser().getEmail().equals(user.getEmail())){
                model.addAttribute("exchange_offers", exchangeApplicationService.myProductExchangeOffersList(user.getId(), product.getId()));
            }
        }
        if(product == null){
            model.addAttribute("productNotFound", "The item was removed by the user who added it.");
            return "product_info";
        }


        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());

        String data = liqPayService.generateData(
                productService.getProductById(iD).getPrice(),
                "UAH",
                "Purchase payment " + productService.getProductById(iD).getTitle(),
                "https://af51-46-150-81-93.ngrok-free.app/payment/result",
                "https://af51-46-150-81-93.ngrok-free.app/payment/result"
        );

        String signature = liqPayService.generateSignature(data);

        String userAgent = request.getHeader("User-Agent");
        String os = orderService.getOperationalSystem(userAgent);

        if (authentication instanceof UsernamePasswordAuthenticationToken)
            session.setAttribute("user_id", productService.getUserByPrincipal(principal).getId());
        else if(authentication instanceof OAuth2AuthenticationToken token)
            session.setAttribute("user_id", userService.getUserByEmail(token.getPrincipal().getAttribute("email")).getId());

        session.setAttribute("product_id", iD);
        session.setAttribute("os", os);

        // Передача форми для LiqPay
        model.addAttribute("liqPayData", data);
        model.addAttribute("liqPaySignature", signature);
        if (authentication instanceof UsernamePasswordAuthenticationToken)
            model.addAttribute("user_id", productService.getUserByPrincipal(principal).getId());
        else if (authentication instanceof OAuth2AuthenticationToken token)
            model.addAttribute("user_id", userService.getUserByEmail(token.getPrincipal().getAttribute("email")).getId());
        return "product_info";
    }

    @PostMapping("/notifications/delete/{id}")
    public String deleteNotification(@PathVariable String id) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        notificationService.deleteNotification(iD);
        return "redirect:/";
    }
    
    @PostMapping("/buy/virtual/{id}")
    public String buyVirtual(@PathVariable String id, Principal principal,
                                     HttpServletRequest request,
                                     HttpSession session, Authentication authentication, Model model, RedirectAttributes redirectAttributes,
                                        @RequestParam(name = "virtualPrice") String virtualPriceLine){
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Product product = productService.getProductById(iD);

        User customer = null;
        
        if (authentication instanceof UsernamePasswordAuthenticationToken)
            customer = productService.getUserByPrincipal(principal);
        else if(authentication instanceof OAuth2AuthenticationToken token)
            customer = userService.getUserByEmail(token.getPrincipal().getAttribute("email"));

        System.out.println("Customer id = " + customer.getId());

        String virtualPriceLine1 = String.valueOf(virtualPriceLine).replace("\u00A0", "");
        double virtualPrice = Double.parseDouble(virtualPriceLine1.replace(",", "."));


        System.out.println("Customer balance: " + customer.getCoins());
        System.out.println("Product virtual price: " + virtualPrice);

        if(customer.getCoins() < virtualPrice) {
            model.addAttribute("payment_message", "You don’t have enough coins!");
            redirectAttributes.addFlashAttribute("payment_message", "You don’t have enough coins!");
            return "redirect:/marketplace";
        }
        else {
            System.out.println("New customer balance: " + (customer.getCoins() - virtualPrice));
            customer.setCoins((customer.getCoins() - virtualPrice));
            String os = (String) session.getAttribute("os");
            userService.save(customer);
            orderService.saveOrder(customer, product, TypeOfPayment.VIRTUAL_CURRENCY, virtualPrice, os);
            customer.setCoins((customer.getCoins() + (virtualPrice
                    * Rewards.BUY.getRewardPercentage())));
            System.out.println("Customer's reward: " + (virtualPrice
                    * Rewards.BUY.getRewardPercentage()));
            System.out.println("Seller's reward: " + (virtualPrice
                    * Rewards.SELL.getRewardPercentage()));

            product.getUser().setCoins((product.getUser().getCoins() + (virtualPrice
                    * Rewards.SELL.getRewardPercentage())));

            userService.save(customer);
            userService.save(product.getUser());

            double customerReward = BigDecimal.valueOf(virtualPrice
                    * Rewards.BUY.getRewardPercentage())
                    .setScale(1, RoundingMode.HALF_UP)
                    .doubleValue();

            double sellerReward = BigDecimal.valueOf(virtualPrice
                            * Rewards.SELL.getRewardPercentage())
                    .setScale(1, RoundingMode.HALF_UP)
                    .doubleValue();

            notificationService.saveNotification(customer, product.getUser(), Rewards.BUY, product, customerReward);
            notificationService.saveNotification(product.getUser(), customer, Rewards.SELL, product, sellerReward);

            //productService.deleteProduct(product.getId());

            model.addAttribute("payment_message", "Purchase completed successfully!");
            redirectAttributes.addFlashAttribute("payment_message", "Purchase completed successfully!");
            return "redirect:/marketplace";
        }

    }

    @PostMapping("/")
    public String toMain(){
        return "redirect:/";
    }
}
