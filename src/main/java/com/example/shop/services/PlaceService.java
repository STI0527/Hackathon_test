package com.example.shop.services;

import com.example.shop.models.Place;
import com.example.shop.repositories.PlaceRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;

@Service
@NoArgsConstructor
@AllArgsConstructor
public class PlaceService {

    @Autowired
    private PlaceRepository placeRepository;

    public List<Place> getAllPlaces() {
        return placeRepository.findAll();
    }

    @Transactional
    public void savePlace(Principal principal, Place place){
        placeRepository.save(place);
    }
    @Transactional
    public void savePlace(OAuth2AuthenticationToken token, Place place) {
        // Збереження місця в базі даних
        placeRepository.save(place);
    }
}