package com.example.shop.controller;

import com.example.shop.enums.Rewards;
import com.example.shop.models.Notification;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.services.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class OfferController {

    private final ProductService productService;
    private final UserService userService;
    private final NotificationService notificationService;
    private final CurrencyExchangeService currencyExchangeService;
    private final ExchangeApplicationService exchangeApplicationService;
    private final  UserDataService userDataService;
    private final ExchangePairService exchangePairService;


    @PostMapping("/exchange/offer/{id}")
    public String makeOffer(@PathVariable String id, Model model, Principal principal,
                            @RequestParam("offer_id") String offerId,
                            Authentication authentication, User user){
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Long offeriD = Long.parseLong(offerId.replace("\u00A0", ""));

        Product desireProduct = productService.getProductById(iD);

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

        notificationService.saveNotification(user, desireProduct.getUser(), Rewards.INFO_USER, desireProduct, 0);
        notificationService.saveNotification(desireProduct.getUser(), user, Rewards.INFO_SELLER, desireProduct, 0);
        exchangeApplicationService.saveExchangeApplication(desireProduct, productService.getProductById(offeriD));

        model.addAttribute("products", productService.findEXCHANGE());
        model.addAttribute("euro_exchange_rate", currencyExchangeService.getEuroToUahRate());
        model.addAttribute("notifications", notificationService.getNotificationsList(user.getId()));
        return "exchange";
    }

    @PostMapping("/offer/accept/{id}")
    public String acceptOffer(@PathVariable String id) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Long desireProductId = exchangeApplicationService.getOfferById(iD).getProduct().getId();

        return "redirect:/products/" + desireProductId;
    }

    @PostMapping("/offer/decline")
    public String declineOffer(@RequestParam(name = "offerId") String id) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Long desireProductId = exchangeApplicationService.getOfferById(iD).getProduct().getId();


        notificationService.saveNotification(exchangeApplicationService.getOfferById(iD).getOffer().getUser(), exchangeApplicationService.getOfferById(iD).getProduct().getUser(),
                Rewards.DECLINE_EXCHANGE_OFFER, exchangeApplicationService.getOfferById(iD).getProduct(), 0,
                exchangeApplicationService.getOfferById(iD).getOffer().getId(),
                exchangeApplicationService.getOfferById(iD).getOffer().getTitle());


        exchangeApplicationService.deleteOffer(iD);

        return "redirect:/products/" + desireProductId;
    }


    @PostMapping("/send/exchangeData/{id}")
    public String sendExchangeData(@PathVariable String id,
                                   @RequestParam("userId") String userId,
                                   @RequestParam("name") String name,
                                   @RequestParam("phone") String phone,
                                   @RequestParam("city") String city,
                                   @RequestParam("warehouse") Integer warehouseNumber,
                                   @RequestParam("offerId") String offerId
                                   ) {
        Long iD = Long.parseLong(id.replace("\u00A0", ""));
        Long offerIdNum = Long.parseLong(offerId.replace("\u00A0", ""));
        Long userIdNum = Long.parseLong(userId.replace("\u00A0", ""));

        
        userDataService.saveUserData(userIdNum, name, phone, city, warehouseNumber);

        notificationService.saveNotification(exchangeApplicationService.getOfferById(offerIdNum).getOffer().getUser(), productService.getProductById(iD).getUser(),
                Rewards.USER_EXCHANGE_DATA_RECEIVED, exchangeApplicationService.getOfferById(offerIdNum).getProduct(), 0,
                exchangeApplicationService.getOfferById(offerIdNum).getOffer().getId(),
                exchangeApplicationService.getOfferById(offerIdNum).getOffer().getTitle());

        exchangePairService.saveExchangePair(iD, productService.getProductById(iD).getUser().getId());

        return "redirect:/products/" + iD;
    }


    @GetMapping("/offers/accepted")
    public String toAcceptedOffers(Model model, Principal principal,
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

        model.addAttribute("myExchangePairs", exchangePairService.allExchangePairsList());


        return "accepted_offers";
    }

}
