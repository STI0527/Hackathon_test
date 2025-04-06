package com.example.shop.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

@Service
@AllArgsConstructor
public class CurrencyExchangeService {

    private final RestTemplate restTemplate;

    @Setter
    @Getter
    private static double euroExchangeRate;

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

    public Double getEuroToUahRate() {
        String date = this.getCurrentDate();
        String json = getExchangeRates(date);

        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode root = mapper.readTree(json);
            for (JsonNode node : root) {
                if (node.get("CurrencyCodeL").asText().equals("EUR")) {
                    double rate = node.get("Amount").asDouble();
                    return BigDecimal.valueOf(rate)
                            .setScale(2, RoundingMode.HALF_UP)
                            .doubleValue();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null; // якщо не знайдено
    }

}
