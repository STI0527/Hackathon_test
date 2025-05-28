package com.example.shop.services;

import com.example.shop.models.ExchangeApplication;
import com.example.shop.models.Product;
import com.example.shop.repositories.ExchangeApplicationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

@Service
@AllArgsConstructor
public class ExchangeApplicationService {

    private final ExchangeApplicationRepository exchangeApplicationRepository;

    public void saveExchangeApplication(Product desireProduct, Product offer) {
        ExchangeApplication exchangeApplication = new ExchangeApplication();
        exchangeApplication.setProduct(desireProduct);
        exchangeApplication.setOffer(offer);
        exchangeApplication.setOwnerId(desireProduct.getUser().getId());
        exchangeApplication.setDesireProductTitle(desireProduct.getTitle());
        exchangeApplication.setOfferTitle(offer.getTitle());
        exchangeApplication.setOwnerName(desireProduct.getUser().getName());
        exchangeApplication.setProposerName(offer.getUser().getName());
        exchangeApplication.setDateOfOffer(LocalDateTime.now());

        String shortDateOfOffer = String.format("%02d", exchangeApplication.getDateOfOffer().getDayOfMonth()) + " " +
                exchangeApplication.getDateOfOffer().getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH) + " " +
                exchangeApplication.getDateOfOffer().getYear();

        exchangeApplication.setShortDateOfOffer(shortDateOfOffer);

        exchangeApplicationRepository.save(exchangeApplication);

    }

    public List<ExchangeApplication> myProductExchangeOffersList(Long userId, Long productId) {
        List<ExchangeApplication> result = new ArrayList<>();

        for(ExchangeApplication exchangeApplication: exchangeApplicationRepository.findAll()){
            if(exchangeApplication.getOwnerId() == userId && exchangeApplication.getProduct().getId() == productId) {
                result.add(exchangeApplication);
            }
        }

        return result;
    }

    public void deleteOffer(Long id) {
        exchangeApplicationRepository.deleteById(id);
    }

    public ExchangeApplication getOfferById(Long id) {
        return exchangeApplicationRepository.findById(id).orElse(null);
    }
}
