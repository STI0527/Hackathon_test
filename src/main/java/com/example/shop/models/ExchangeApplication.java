package com.example.shop.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Entity
@Table(name="EXCHANGE_APPLICATION")
@AllArgsConstructor
@NoArgsConstructor
public class ExchangeApplication {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "offer_id")
    private Product offer;

    @Column(name = "owner_id")
    private Long ownerId;

    @Column(name = "owner_name")
    private String ownerName;

    @Column(name = "proposer_name")
    private String proposerName;

    @Column(name = "offer_product_name")
    private String offerTitle;

    @Column(name = "desire_product_name")
    private String desireProductTitle;

    @Column(name = "date_of_offer")
    private LocalDateTime dateOfOffer;

    @Column(name = "short_date")
    private String shortDateOfOffer;


}
