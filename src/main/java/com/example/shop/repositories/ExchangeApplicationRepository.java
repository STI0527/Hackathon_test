package com.example.shop.repositories;

import com.example.shop.models.ExchangeApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ExchangeApplicationRepository extends JpaRepository<ExchangeApplication, Long> {


}
