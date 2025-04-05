package com.example.shop.controller;


import com.example.shop.services.CurrencyExchangeService;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Controller
@RequiredArgsConstructor
public class CurrencyController {

    private final CurrencyExchangeService currencyExchangeService;

    @GetMapping("/exchange-rates")
    public String showExchangeRates(@RequestParam(required = false) String date, Model model) {
        String exchangeRates = currencyExchangeService.getExchangeRates(currencyExchangeService.getCurrentDate());
        model.addAttribute("exchangeRates", exchangeRates);
        model.addAttribute("date", date);
        return "exchange_rates";
    }

}
