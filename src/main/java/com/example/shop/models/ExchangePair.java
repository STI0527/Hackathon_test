package com.example.shop.models;


import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name="exchange_pairs")
@Data
public class ExchangePair {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "first_product_id")
    private Long firstProductId;

    @Column(name = "second_product_id")
    private  Long secondProductId;

    @Column(name = "first_user_data_id")
    private Long firstUserDataId;

    @Column(name = "second_user_data_id")
    private Long secondUserDataId;

}
