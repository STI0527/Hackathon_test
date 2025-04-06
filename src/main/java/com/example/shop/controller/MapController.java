    package com.example.shop.controller;

    import com.example.shop.models.Place;
    import com.example.shop.models.Product;
    import com.example.shop.services.PlaceService;
    import lombok.RequiredArgsConstructor;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
    import org.springframework.stereotype.Controller;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.PostMapping;
    import org.springframework.web.bind.annotation.RequestParam;
    import org.springframework.web.bind.annotation.RestController;

    import java.security.Principal;
    import java.util.List;

    @RestController
    @RequiredArgsConstructor
    public class MapController {


        private final PlaceService placeService;


        @GetMapping("/places")
        public List<Place> getPlaces() {
            return placeService.getAllPlaces();
        }
    }
