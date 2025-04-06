package com.example.shop.services;

import org.springframework.cglib.core.Local;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class ScheduledCurrencyUpdater {

    private final CurrencyExchangeService currencyExchangeService;

    public ScheduledCurrencyUpdater(CurrencyExchangeService currencyExchangeService) {
        this.currencyExchangeService = currencyExchangeService;
    }

    @Scheduled(fixedRate = 21600000) //Updating every 6 hours
    public void updateCurrency() {
        Double rate = currencyExchangeService.getEuroToUahRate();
        if (rate != null) {
            CurrencyExchangeService.setEuroExchangeRate(rate);//Updating static variable;
            String currentTime = String.format("%02d:%02d", LocalDateTime.now().getHour(),
                    LocalDateTime.now().getMinute());
            System.out.println("\u001b[33mUpdated Euro to UAH rate (scheduled, " + currentTime + "): " + rate + "\u001b[0m");
        } else {
            System.out.println("\u001b[31mFailed to update Euro to UAH rate (scheduled).\u001b[0m");
        }
    }
}