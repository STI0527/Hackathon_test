package com.example.shop.controller;


import com.example.shop.models.Avatar;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.repositories.AvatarRepository;
import com.example.shop.repositories.UserRepository;
import com.example.shop.services.ProductService;
import com.example.shop.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;
    private final AvatarRepository avatarRepository;
    private final ProductService productService;

    @GetMapping("/login")
    public String login(){
        return "login";
    }


    @GetMapping("/registration")
    public String registration() {

        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(@RequestParam("fileAvatar") MultipartFile fileAvatar, User user, Model model) throws IOException {
        if(!userService.createUser(user, fileAvatar)){
            model.addAttribute(fileAvatar.getName());
            model.addAttribute("errorMessage", "Користувач з email"
                    + user.getEmail() + " вже існує");
            return "registration";
        }

        return "redirect:/login";
    }

    @PostMapping("/changeAvatar/{id}")
    public String changeAvatar(@RequestParam("file") MultipartFile file, @PathVariable Long id) throws IOException {
        User user = userRepository.findById(id).orElse(null);

        

       if(user.getAvatar() != null) {
            //if(user.getAvatar() != null) {
                //avatarRepository.deleteById(user.getAvatar().getId());
                user.getAvatar().setName(file.getName());
                user.getAvatar().setOriginalFileName(file.getOriginalFilename());
                user.getAvatar().setContentType(file.getContentType());
                user.getAvatar().setSize(file.getSize());
                user.getAvatar().setBytes(file.getBytes());
            //}
            //user.addAvatar(avatar);
            userRepository.save(user);
        }
        System.out.println("\u001B[31mProfile " + user.getEmail() + " avatar changed\u001B[0m");
        return "redirect:/";
    }


    //перевірка Security: Доступ аутентифікованого та неаутентифікованого користувача.
    // Коли не зайшли у свій профіль, то має перекинути на сторінку з login;
    @GetMapping("/hello")
    public String securityUrl() {
        return "hello";
    }


    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model){
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "user_info";
    }


    @PostMapping("/profile/{id}")
    public String profile(@PathVariable("id") Long id, Model model){
        User user = userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "profile";
    }


    @GetMapping("/marketplace")
    public String toMarketplace(Model model, Principal principal){
        model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        model.addAttribute("products", productService.findAll());
        return "marketplace";
    }


    @GetMapping("/exchange")
    public String toExchange(Model model, Principal principal){
        model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        model.addAttribute("products", productService.findAll());
        return "exchange";
    }

    @GetMapping("/repair")
    public String toRepair(Model model, Principal principal){
        model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        model.addAttribute("products", productService.findAll());
        return "repair";
    }

    @GetMapping("/referal")
    public String toReferal(Model model, Principal principal){
        model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        model.addAttribute("products", productService.findAll());
        return "referal";
    }





}
