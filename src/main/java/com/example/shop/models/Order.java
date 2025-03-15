package com.example.shop.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name="ORDERS")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private long id;

    @Column(name="customer_name")
    private String customerName;

    @Column(name="customer_id")
    private long customerId;

    @Column(name="customer_phone")
    private String customerPhoneNumber;

    @Column(name="customer_email")
    private String customerEmail;

    @Column(name="operational_system")
    private String operationalSystem;

    @Column(name="date_of_purchase")
    private LocalDateTime dateOfPurchase;

    private Long productId;

    @Column(name="order_name")
    private String orderName;


    @Column(name="order_price, UAH")
    private int orderPrice;

    @Column(name="order_city")
    private String orderCity;


}
