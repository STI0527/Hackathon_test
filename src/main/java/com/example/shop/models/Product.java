package com.example.shop.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "PRODUCTS")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @Column(name = "title")
    private String title;

    @Column(name = "description", columnDefinition = "text") //бо varchar максимально може містити 255 символів;
    private String description;

    @Column(name = "price")
    private int price;

    @Column(name = "city")
    private String city;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "product")
    private List<Image> images = new ArrayList<>();
    private Long previewImageId;

    private LocalDateTime dateOfCreation;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;

    @PrePersist
    private void init(){
        dateOfCreation = LocalDateTime.now();
    }


    public void addImageToProduct(Image image){
        image.setProduct(this);
        images.add(image);
    }

    @Override
    public String toString() {
        return "Product{id=" + id + ", title='" + title + "', price=" + price + "}"; //уникнення рекурсії
    }
}
