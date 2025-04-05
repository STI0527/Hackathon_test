package com.example.shop.services;

import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class CurrencyExchangeService {

    private final RestTemplate restTemplate;

    public String getExchangeRates(String date) {
        String url = "https://bank.gov.ua/NBU_Exchange/exchange?date=" + date + "&json";
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
        return response.getBody();
    }

    public String getCurrentDate() {
        String dateToday = String.format("%02d.%02d", LocalDateTime.now().getDayOfMonth(),
                LocalDateTime.now().getMonthValue()) + "." +  LocalDateTime.now().getYear();

        System.out.println("\u001b[32mGetting currency rates for: " + dateToday + "\u001b[0m");

        return dateToday;

    }
}
