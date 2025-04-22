package com.example.shop.repositories;

import com.example.shop.models.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Set;

public interface NotificationRepository extends JpaRepository<Notification, Long> {


    List<Notification> findAllByCustomerId(Long customerId);
    List<Notification> findAllBySellerId(Long sellerId);

}
