package com.example.shop.services;


import com.example.shop.enums.Rewards;
import com.example.shop.models.Notification;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.repositories.NotificationRepository;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.*;

@Service
@AllArgsConstructor
public class NotificationService {

    private final NotificationRepository notificationRepository;

    public void saveNotification(User customer, User user, Rewards rewards, Product product, double rewardAmount){
        Notification notification = new Notification();
        notification.setCustomerId(customer.getId());
        notification.setCustomerName(customer.getName());
        notification.setSellerId(user.getId());
        notification.setRewardType(rewards);
        notification.setRewardAmount(rewardAmount);
        notification.setSellerName(user.getName());
        notification.setCustomerEmail(customer.getEmail());
        notification.setSellerEmail(user.getEmail());
        notification.setDateOfOperation(LocalDateTime.now());
        notification.setProductId(product.getId());
        notification.setProductTitle(product.getTitle());
        notificationRepository.save(notification);
    }

    private List<Notification> finByCustomerId(Long id){
        return notificationRepository.findAllByCustomerId(id);
    }

    private List<Notification> finBySellerId(Long id){
        return notificationRepository.findAllBySellerId(id);
    }

    public List<Notification> getNotificationsList(Long id) {
        List<Notification> list1 = finByCustomerId(id);
        List<Notification> list2 = finBySellerId(id);

        //To get rid of duplicates;
        Set<Notification> set = new LinkedHashSet<>();
        set.addAll(list1);
        set.addAll(list2);


        List<Notification> sortedList = new ArrayList<>(set);

        sortedList.sort((n1, n2) -> n2.getDateOfOperation().compareTo(n1.getDateOfOperation()));

        return sortedList;
    }
}
