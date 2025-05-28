package com.example.shop.services;


import com.example.shop.models.ExchangePair;
import com.example.shop.models.UserData;
import com.example.shop.repositories.ExchangePairRepository;
import com.example.shop.repositories.UserDataRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ExchangePairService {

    private final ExchangePairRepository exchangePairRepository;
    private final UserDataRepository userDataRepository;

    public void saveExchangePair(Long firstProductId, Long firstUserDataId){
        ExchangePair exchangePair = new ExchangePair();

        exchangePair.setFirstProductId(firstProductId);
        exchangePair.setFirstUserDataId(firstUserDataId);

        exchangePairRepository.save(exchangePair);
    }


    public List allExchangePairsList() {
        return exchangePairRepository.findAll();
    }

    public List getExchangePairsByUser(Long id) {
        List<ExchangePair> result = new ArrayList<>();

        UserData userData = userDataRepository.findByUserId(id);

        for(ExchangePair exchangePair: exchangePairRepository.findAll()) {

            if(exchangePair.getFirstUserDataId() == userData.getId()) {
                result.add(exchangePair);
            }

        }

        return result;
    }
}
