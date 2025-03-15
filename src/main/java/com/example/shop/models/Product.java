package com.example.shop.models;

import com.example.shop.enums.AdvertType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

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

    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private AdvertType type;

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
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return getPrice() == product.getPrice() && Objects.equals(getId(), product.getId()) && Objects.equals(getTitle(), product.getTitle()) && Objects.equals(getDescription(), product.getDescription()) && Objects.equals(getCity(), product.getCity()) && getType() == product.getType() && Objects.equals(getImages(), product.getImages()) && Objects.equals(getPreviewImageId(), product.getPreviewImageId()) && Objects.equals(getDateOfCreation(), product.getDateOfCreation()) && Objects.equals(getUser(), product.getUser());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getTitle(), getDescription(), getPrice(), getCity(), getType(), getImages(), getPreviewImageId(), getDateOfCreation(), getUser());
    }

    @Override
    public String toString() {
        return "Product{id=" + id + ", title='" + title + "', price=" + price + "}"; //уникнення рекурсії
    }
}
