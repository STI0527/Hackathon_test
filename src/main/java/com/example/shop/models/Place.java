package com.example.shop.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Place {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Getter
    @Column(name = "name")
    private String name;

    @Getter
    @Setter
    @Column(name = "latitude")
    private double latitude;

    @Getter
    @Setter
    @Column(name = "longitude")
    private double longitude;

    public Place(String name, double lat, double lng) {
        this.name = name;
        this.latitude = lat;
        this.longitude = lng;
    }

}
