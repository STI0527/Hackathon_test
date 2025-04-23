package com.example.shop.models;


import com.example.shop.enums.Rewards;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Entity
@Table(name="NOTIFICATIONS")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notification {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private long id;

    @Column(name="customer_name")
    private String customerName;

    @Column(name="customer_id")
    private long customerId;

    @Column(name="customer_email")
    private String customerEmail;

    @Column(name="seller_id")
    private long sellerId;

    @Column(name="seller_name")
    private String sellerName;

    @Column(name="seller_email")
    private String sellerEmail;

    @Column(name="date_of_operation")
    private LocalDateTime dateOfOperation;

    @Column(name="product_id")
    private Long productId;

    @Column(name="product_title")
    private String productTitle;

    @Column(name="reward_type", length = 50)
    @Enumerated(EnumType.STRING)
    private Rewards rewardType;

    @Column(name="reward_amount")
    private double rewardAmount;

    @Column(name="short_date_of_operation")
    private String shortDateOfOperation;

    @Setter
    @Column(name="is_read")
    private boolean read = false;

}
