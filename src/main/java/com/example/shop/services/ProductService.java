package com.example.shop.services;

import com.example.shop.enums.AdvertType;
import com.example.shop.models.Image;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.repositories.ProductRepository;
import com.example.shop.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductService {


    private final ProductRepository productRepository;
    private final UserRepository userRepository;



//    private List<Product> products = new ArrayList<>();
//    private Long ID = 0L;
//
//    {
//        products.add(
//                new Product(++ID, "BMW X5", "Was produced in 2005", 15000, "Kyiv", "Perekup"));
//
//        products.add(
//                new Product(++ID, "Mazda CX50", "Was produced in 2016", 25000, "Lviv", "Western_Perekup"));
//    }



    public List<Product> productList(String title) {
        //List<Product> products = productRepository.findAll();
        log.info("\u001B[31mSearching for product {}\u001B[0m", title);
        if(title != null){
           return productRepository.findByTitle(title);
        }
        return productRepository.findAll();
    }

    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {

        product.setUser(getUserByPrincipal(principal));

        Image image1;
        Image image2;
        Image image3;
        if(file1.getSize() != 0){
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if(file2.getSize() != 0){
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if(file3.getSize() != 0){
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }

        log.info("\u001B[31mSaving new Product: Title: {}; Price: {}\u001B[0m", product.getTitle(), product.getPrice());
        Product prFromDB = productRepository.save(product);
        prFromDB.setPreviewImageId(prFromDB.getImages().get(0).getId());
        productRepository.save(product);
    }
    public void saveProduct(OAuth2AuthenticationToken token, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {

        product.setUser(userRepository.findByEmail(token.getPrincipal().getAttribute("email")));

        Image image1;
        Image image2;
        Image image3;
        if(file1.getSize() != 0){
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if(file2.getSize() != 0){
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if(file3.getSize() != 0){
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }

        log.info("\u001B[31mSaving new Product: Title: {}; Price: {}\u001B[0m", product.getTitle(), product.getPrice());
        Product prFromDB = productRepository.save(product);
        prFromDB.setPreviewImageId(prFromDB.getImages().get(0).getId());
        productRepository.save(product);
    }

    public User getUserByPrincipal(Principal principal) {
        if(principal == null)
            return new User();

        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;

    }

    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
        log.info("Deleted product with ID {}", id);
    }

    public Product getProductById(Long id) {
//        for(Product product: products){
//            if(product.getId().equals(id)){
//                return product;
//            }
//        }
//        return null;
        return productRepository.findById(id).orElse(null);
    }

    public List<Product> findAll() {
        return productRepository.findAll();
    }

    public List<Product> findSELL() {
        List<Product> products = new ArrayList<>();
        for(Product product: findAll()){
            if (product.getType() == AdvertType.SELL) products.add(product);
        }
        return products;
    }

    public List<Product> findEXCHANGE() {
        List<Product> products = new ArrayList<>();
        for(Product product: findAll()){
            if (product.getType()== AdvertType.EXCHANGE) products.add(product);
        }
        return products;
    }

    public List<Product> findREPAIR() {
        List<Product> products = new ArrayList<>();
        for(Product product: findAll()){
            if (product.getType()== AdvertType.REPAIR) products.add(product);
        }
        return products;
    }
}
