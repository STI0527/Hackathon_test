package com.example.shop.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Arrays;
import java.util.Objects;

@Entity
@Table(name = "IMAGES")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Image {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "originalFileName")
    private String originalFileName;

    @Column(name = "size")
    private Long size;

    @Column(name = "contentType")
    private String contentType;

    @Column(name = "isPreviewImage")
    private boolean isPreviewImage; //true для головної фотографії оголошення;


    @Column(name = "bytes", columnDefinition = "bytea")
    private byte[] bytes;


    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)//фотографії -> товар;
    private Product product;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)//фотографії -> товар;
    private Place place;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Image image = (Image) o;
        return isPreviewImage() == image.isPreviewImage() && Objects.equals(getId(), image.getId()) && Objects.equals(getName(), image.getName()) && Objects.equals(getOriginalFileName(), image.getOriginalFileName()) && Objects.equals(getSize(), image.getSize()) && Objects.equals(getContentType(), image.getContentType()) && Arrays.equals(getBytes(), image.getBytes()) && Objects.equals(getProduct(), image.getProduct());
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(getId(), getName(), getOriginalFileName(), getSize(), getContentType(), isPreviewImage(), getProduct());
        result = 31 * result + Arrays.hashCode(getBytes());
        return result;
    }
}

