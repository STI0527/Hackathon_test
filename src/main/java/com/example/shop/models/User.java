package com.example.shop.models;

import com.example.shop.enums.Role;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.*;

@Entity
@Table(name = "users")
@Data
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "name")
    private String name;

    @Column(name = "active")
    private boolean isActive;
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "image_id")
    private Avatar avatar;

    @Column(name = "password", length = 1000)
    private String password;

    @Column(name = "coins")
    private double coins;

    @Column(name = "plastic_saved, kg")
    private double plasticSaved;

    @Column(name = "metal_saved, kg")
    private double metalSaved;

    @Column(name = "glass_saved, kg")
    private double glassSaved;

    @Column(name = "CO2_saved, kg")
    private double CO2Saved;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles = new HashSet<>();
    private LocalDateTime dateOfRegistration;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "user")
    private List<Product> products = new ArrayList<>();

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", phoneNumber='" + phoneNumber + '\'' +
                ", name='" + name + '\'' +
                ", isActive=" + isActive +
                ", avatar=" + avatar +
                ", password='" + password + '\'' +
                ", coins=" + coins +
                ", roles=" + roles +
                ", dateOfRegistration=" + dateOfRegistration +
                '}';
    }

    public void addAvatar(Avatar avatar){
        this.avatar = avatar;
        avatar.setUser(this);

    }
    //security
    @PrePersist
    private void init() {
        dateOfRegistration = LocalDateTime.now();
    }

    public boolean isAdmin(){return roles.contains(Role.ROLE_ADMIN);
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return roles;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return isActive() == user.isActive() && Double.compare(getCoins(), user.getCoins()) == 0 && Double.compare(getPlasticSaved(), user.getPlasticSaved()) == 0 && Double.compare(getMetalSaved(), user.getMetalSaved()) == 0 && Double.compare(getGlassSaved(), user.getGlassSaved()) == 0 && Double.compare(getCO2Saved(), user.getCO2Saved()) == 0 && Objects.equals(getId(), user.getId()) && Objects.equals(getEmail(), user.getEmail()) && Objects.equals(getPhoneNumber(), user.getPhoneNumber()) && Objects.equals(getName(), user.getName()) && Objects.equals(getPassword(), user.getPassword()) && Objects.equals(getRoles(), user.getRoles()) && Objects.equals(getDateOfRegistration(), user.getDateOfRegistration()) && Objects.equals(getProducts(), user.getProducts());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getEmail(), getPhoneNumber(), getName(), isActive(), getPassword(), getCoins(), getPlasticSaved(), getMetalSaved(), getGlassSaved(), getCO2Saved(), getRoles(), getDateOfRegistration(), getProducts());
    }

    //Цей метод відповідає за можливість банити користувача;
    @Override
    public boolean isEnabled() {
        return isActive;
    }
}
