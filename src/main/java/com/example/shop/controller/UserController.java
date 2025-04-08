package com.example.shop.controller;


import com.example.shop.email.EmailSender;
import com.example.shop.models.*;
import com.example.shop.repositories.AvatarRepository;
import com.example.shop.repositories.UserRepository;
import com.example.shop.services.*;
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
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final UserRepository userRepository;
    private final AvatarRepository avatarRepository;
    private final ProductService productService;
    private final ConfirmationTokenService confirmationTokenService;
    private final EmailSender emailSender;
    private final CurrencyExchangeService currencyExchangeService;
    private final PlaceService placeService;
    private final NotificationService notificationService;

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
            model.addAttribute("errorMessage", "User with email "
                    + user.getEmail() + " already exists");
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

        String confirmMessage = "An email has been sent to your email address. " +
                "Follow the link in the email to confirm your email address.";



        emailSender.send(user.getEmail(), buildEmail(user.getName(), link));
        model.addAttribute("confirmMessage", confirmMessage);
        return "/login";
    }

    @PostMapping("/changeAvatar/{id}")
    public String changeAvatar(@RequestParam("file") MultipartFile file, @PathVariable String id) throws IOException {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        User user = userRepository.findById(iD).orElse(null);

        

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
    public String userInfo(@PathVariable("user") String id, Model model,
                           Principal principal, OAuth2AuthenticationToken token){
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        User user = userService.getUserById(iD);

        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        if (token==null)
            model.addAttribute("viewer", userService.findUserByPrincipal(principal.getName()));
        else
            model.addAttribute("viewer", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));

        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));
        return "user_info";
    }


    @PostMapping("/profile/{id}")
    public String profile(@PathVariable("id") String id, Model model){
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        User user = userService.getUserById(iD);
        user.setCoins(BigDecimal.valueOf(user.getCoins())
                .setScale(1, RoundingMode.HALF_UP)
                .doubleValue());
        
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));
        return "profile";
    }


    @GetMapping("/marketplace")
    public String toMarketplace(Model model, Principal principal, Authentication authentication, User user){


        if (authentication != null) {
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

        }

        model.addAttribute("products", productService.findSELL());
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));

        return "marketplace";
    }


    @GetMapping("/exchange")
    public String toExchange(Model model, Principal principal, Authentication authentication, User user){

        if (authentication instanceof OAuth2AuthenticationToken token) {
            model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        }
        model.addAttribute("products", productService.findEXCHANGE());
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));
        return "exchange";
    }

    @GetMapping("/repair")
    public String toRepair(Model model, Principal principal, Authentication authentication, User user){
        if (authentication instanceof OAuth2AuthenticationToken token) {
        model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
    } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
        model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
    }
        model.addAttribute("products", productService.findREPAIR());
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));
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
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        return "referal";
    }

    @GetMapping("/reuse")
    public String toReuse(Model model, Principal principal,
                          Authentication authentication, User user){
        if (authentication instanceof OAuth2AuthenticationToken token) {
            model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        }

        model.addAttribute("places", placeService.getAllPlaces());
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));

        return "reuse";
    }

    @PostMapping("/places/create")
    public String createPlace(@RequestParam String title,
                              @RequestParam double latitude, @RequestParam double longitude,
                              @RequestParam String city, @RequestParam String address, @RequestParam String description,
                              @RequestParam boolean paper, @RequestParam boolean plastic,
                              @RequestParam boolean glass, @RequestParam boolean metal,
                              Principal principal, OAuth2AuthenticationToken token){
        Place place = new Place(title, latitude, longitude, city, address, description, paper, plastic, glass, metal);
        if (token==null)
            placeService.savePlace(principal, place);
        else
            placeService.savePlace(token, place);
        return "redirect:/reuse";
    }


    @GetMapping("/confirm")
    public String confirm(@RequestParam("token") String token, Model model) {
        System.out.println("\u001B[31mToken received: " + token + "\u001b[0m");
        String tokenStatus = userService.confirmToken(token);

        switch (tokenStatus) {
            case "/login?confirmed":
                model.addAttribute("message_already_confirmed", "Your email address has already been confirmed. Please log in.");
                break;

            case "/login?expired":
                model.addAttribute("message_expired", "The confirmation link has expired. Please request a new one.");
                break;

            case "confirmation":
                model.addAttribute("message_confirmed", "Your email address has been successfully confirmed. Please log in.");
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
                "            <p style=\"Margin:0 0 20px 0;font-size:19px;line-height:25px;color:#0b0c0c\">Hello, " + name + ",</p><p style=\"Margin:0 0 20px 0;font-size:19px;line-height:25px;color:#0b0c0c\"> Thank you for registering with ReUse Hub. Please follow this link to confirm your email address: </p><blockquote style=\"Margin:0 0 20px 0;border-left:10px solid #b1b4b6;padding:15px 0 0.1px 15px;font-size:19px;line-height:25px\"><p style=\"Margin:0 0 20px 0;font-size:19px;line-height:25px;color:#0b0c0c\"> <a href=\"" + link + "\">Activate now</a> </p></blockquote>\n The link will expire in 15 minutes. <p>See you at ReUse Hub!</p>" +
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
