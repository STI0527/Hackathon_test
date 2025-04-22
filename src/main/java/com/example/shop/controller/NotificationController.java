package com.example.shop.controller;

import com.example.shop.repositories.NotificationRepository;
import com.example.shop.services.NotificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @PostMapping("/notifications/markAsRead/{id}")
    public void markAsRead(@PathVariable("id") long notificationId) {
        notificationService.markAsRead(notificationId);
    }

}
