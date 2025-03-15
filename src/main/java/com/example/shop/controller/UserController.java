package com.example.shop.controller;


import com.example.shop.email.EmailSender;
import com.example.shop.models.Avatar;
import com.example.shop.models.ConfirmationToken;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.repositories.AvatarRepository;
import com.example.shop.repositories.UserRepository;
import com.example.shop.services.ConfirmationTokenService;
import com.example.shop.services.ProductService;
import com.example.shop.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
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
    private final ConfirmationTokenService confirmationTokenService;
    private final EmailSender emailSender;

    @GetMapping("/login")
    public String login(){
        return "login";
    }


    @GetMapping("/registration")
    public String registration() {

        return "registration";
    }

/*    @GetMapping("/oauth2/authorization/google")
    public String createUserOAuth2(Model model, OAuth2AuthenticationToken token) throws IOException {
        System.out.println(token);
        if (token != null) {
            userService.createUserFromOAuth2(model, token);
        }
        return "work";
    }*/

    @PostMapping("/registration")
    public String createUser(@RequestParam("fileAvatar") MultipartFile fileAvatar, User user, Model model) throws IOException {

        if(!userService.createUser(user, fileAvatar)){
            model.addAttribute(fileAvatar.getName());
            model.addAttribute("errorMessage", "Користувач з email"
                    + user.getEmail() + " вже існує");
            return "registration";
        }
        ConfirmationToken confirmationToken = confirmationTokenService.getConfirmationToken(user.getId());
        //String link = "https://robotcoffees.com/confirm?token=" + confirmationToken.getToken();
        String link = "http://localhost:1799/confirm?token=" + confirmationToken.getToken();

//        if(activationMethod.equals("email")){
//        emailSender.send(user.getEmail(), buildEmail(user.getName(), link));
//        }
//        else if(activationMethod.equals("phoneNumber")){
//            smsService.send(user.getPhoneNumber(), user.getName(), link);
//        }

        String confirmMessage = "На Вашу електронну адресу відправлено лист. " +
                "Перейдіть за посиланням в ньому для підтвердження електронної пошти";



        emailSender.send(user.getEmail(), buildEmail(user.getName(), link));
        model.addAttribute("confirmMessage", confirmMessage);
        return "/login";
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
    public String userInfo(@PathVariable("user") User user, Model model,
                           Principal principal, OAuth2AuthenticationToken token){
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        if (token==null)
            model.addAttribute("viewer", userService.findUserByPrincipal(principal.getName()));
        else
            model.addAttribute("viewer", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));

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
    public String toMarketplace(Model model, Principal principal, Authentication authentication, User user){

        if (authentication != null) {
            if (authentication instanceof OAuth2AuthenticationToken token) {
                model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
            } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
                model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
            }

        }

        model.addAttribute("products", productService.findAll());
        return "marketplace";
    }


    @GetMapping("/exchange")
    public String toExchange(Model model, Principal principal, Authentication authentication, User user){

        if (authentication instanceof OAuth2AuthenticationToken token) {
            model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        }
        model.addAttribute("products", productService.findAll());
        return "exchange";
    }

    @GetMapping("/repair")
    public String toRepair(Model model, Principal principal, Authentication authentication, User user){
        if (authentication instanceof OAuth2AuthenticationToken token) {
        model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
    } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
        model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
    }
        model.addAttribute("products", productService.findAll());
        return "repair";
    }

    @GetMapping("/referal")
    public String toReferal(Model model, Principal principal, Authentication authentication, User user){
        if (authentication instanceof OAuth2AuthenticationToken token) {
            model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        }
        model.addAttribute("products", productService.findAll());
        return "referal";
    }

    @GetMapping("/reuse")
    public String toReuse(Model model, Principal principal){
        return "reuse";
    }


    @GetMapping("/confirm")
    public String confirm(@RequestParam("token") String token, Model model) {
        System.out.println("\u001B[31mToken received: " + token + "\u001b[0m");
        String tokenStatus = userService.confirmToken(token);

        switch (tokenStatus) {
            case "/login?confirmed":
                model.addAttribute("message_already_confirmed", "Ваша електронна адреса вже підтверджена. Авторизуйтеся, будь ласка");
                break;

            case "/login?expired":
                model.addAttribute("message_expired", "Термін дії посилання для підтвердження минув. Будь ласка, попросіть новий");
                break;

            case "confirmation":
                model.addAttribute("message_confirmed", "Ваша електронна адреса успішно підтверджена. Авторизуйтеся, будь ласка");
                break;

            default:
                model.addAttribute("message", "Unexpected error. Please contact support.");
                break;
        }

        return "login";
    }


    private String buildEmail(String name, String link) {
        return "<div style=\"font-family:Helvetica,Arial,sans-serif;font-size:16px;margin:0;color:#0b0c0c\">\n" +
                "\n" +
                "<span style=\"display:none;font-size:1px;color:#fff;max-height:0\"></span>\n" +
                "\n" +
                "  <table role=\"presentation\" width=\"100%\" style=\"border-collapse:collapse;min-width:100%;width:100%!important\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n" +
                "    <tbody><tr>\n" +
                "      <td width=\"100%\" height=\"53\" bgcolor=\"#0b0c0c\">\n" +
                "        \n" +
                "        <table role=\"presentation\" width=\"100%\" style=\"border-collapse:collapse;max-width:580px\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"center\">\n" +
                "          <tbody><tr>\n" +
                "            <td width=\"70\" bgcolor=\"#0b0c0c\" valign=\"middle\">\n" +
                "                <table role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-collapse:collapse\">\n" +
                "                  <tbody><tr>\n" +
                "                    <td style=\"padding-left:10px\">\n" +
                "                  \n" +
                "                    </td>\n" +
                "                    <td style=\"font-size:28px;line-height:1.315789474;Margin-top:4px;padding-left:10px\">\n" +
                "                      <span style=\"font-family:Helvetica,Arial,sans-serif;font-weight:700;color:#ffffff;text-decoration:none;vertical-align:top;display:inline-block\">Confirm your email</span>\n" +
                "                    </td>\n" +
                "                  </tr>\n" +
                "                </tbody></table>\n" +
                "              </a>\n" +
                "            </td>\n" +
                "          </tr>\n" +
                "        </tbody></table>\n" +
                "        \n" +
                "      </td>\n" +
                "    </tr>\n" +
                "  </tbody></table>\n" +
                "  <table role=\"presentation\" class=\"m_-6186904992287805515content\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-collapse:collapse;max-width:580px;width:100%!important\" width=\"100%\">\n" +
                "    <tbody><tr>\n" +
                "      <td width=\"10\" height=\"10\" valign=\"middle\"></td>\n" +
                "      <td>\n" +
                "        \n" +
                "                <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-collapse:collapse\">\n" +
                "                  <tbody><tr>\n" +
                "                    <td bgcolor=\"#1D70B8\" width=\"100%\" height=\"10\"></td>\n" +
                "                  </tr>\n" +
                "                </tbody></table>\n" +
                "        \n" +
                "      </td>\n" +
                "      <td width=\"10\" valign=\"middle\" height=\"10\"></td>\n" +
                "    </tr>\n" +
                "  </tbody></table>\n" +
                "\n" +
                "\n" +
                "\n" +
                "  <table role=\"presentation\" class=\"m_-6186904992287805515content\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-collapse:collapse;max-width:580px;width:100%!important\" width=\"100%\">\n" +
                "    <tbody><tr>\n" +
                "      <td height=\"30\"><br></td>\n" +
                "    </tr>\n" +
                "    <tr>\n" +
                "      <td width=\"10\" valign=\"middle\"><br></td>\n" +
                "      <td style=\"font-family:Helvetica,Arial,sans-serif;font-size:19px;line-height:1.315789474;max-width:560px\">\n" +
                "        \n" +
                "            <p style=\"Margin:0 0 20px 0;font-size:19px;line-height:25px;color:#0b0c0c\">Привіт, " + name + ",</p><p style=\"Margin:0 0 20px 0;font-size:19px;line-height:25px;color:#0b0c0c\"> Дякуємо за реєстрацію в ReUse Hub. Перейдіть, будь ласка, за цим посиланням для пітвердження своєї електронної адреси: </p><blockquote style=\"Margin:0 0 20px 0;border-left:10px solid #b1b4b6;padding:15px 0 0.1px 15px;font-size:19px;line-height:25px\"><p style=\"Margin:0 0 20px 0;font-size:19px;line-height:25px;color:#0b0c0c\"> <a href=\"" + link + "\">Активувати зараз</a> </p></blockquote>\n Термін дії посилання закінчиться через 15 хвилин. <p>До зустрічі в ReUse Hub!</p>" +
                "        \n" +
                "      </td>\n" +
                "      <td width=\"10\" valign=\"middle\"><br></td>\n" +
                "    </tr>\n" +
                "    <tr>\n" +
                "      <td height=\"30\"><br></td>\n" +
                "    </tr>\n" +
                "  </tbody></table><div class=\"yj6qo\"></div><div class=\"adL\">\n" +
                "\n" +
                "</div></div>";
    }
}
