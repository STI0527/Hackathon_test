package com.example.shop.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

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

    @Getter
    @Setter
    @Column(name = "city")
    private String city;

    @Getter
    @Setter
    @Column(name = "address")
    private String address;

    @Getter
    @Setter
    @Column(name = "description")
    private String description;

    @Getter
    @Setter
    @Column(name = "paper")
    private boolean paper;
    @Getter
    @Setter
    @Column(name = "plastic")
    private boolean plastic;
    @Getter
    @Setter
    @Column(name = "glass")
    private boolean glass;
    @Getter
    @Setter
    @Column(name = "metal")
    private boolean metal;


    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "place")
    private List<Image> images = new ArrayList<>();
    private Long previewImageId;


    public Place(String name, double latitude, double longitude, String city, String address, String description,
                 boolean paper, boolean plastic, boolean glass, boolean metal) {
        this.name = name;
        this.latitude = latitude;
        this.longitude = longitude;
        this.city = city;
        this.address = address;
        this.description = description;
        this.paper = paper;
        this.plastic = plastic;
        this.glass = glass;
        this.metal = metal;
    }
}
