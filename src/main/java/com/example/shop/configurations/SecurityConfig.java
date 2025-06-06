package com.example.shop.configurations;


import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.SecurityBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.WebSecurityConfigurer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

//@EnableWebSecurity
//@RequiredArgsConstructor
//public class SecurityConfig implements WebSecurityConfigurer {
//
//    @Override
//    public void init(SecurityBuilder builder) throws Exception {
//
//    }
//
//    @Override
//    public void configure(SecurityBuilder builder) throws Exception {
//
//    }
//}

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.authorizeHttpRequests((requests) -> requests
                        .requestMatchers("/","/product/", "/images/**", "/registration", "/user/**", "/static/**", "/style.css", "/script.js", "/background_gif_cars.gif", "/default_avatar.png", "/img_cars_background.png",
                                "/marketplace", "/exchange", "/repair", "/referal","/confirm", "/confirmation", "/reuse", "marketplace.png",
                                "exchange.png", "recycle.png", "repair.png", "authorization_picture.jpg", "background.jpg", "search.svg", "coins_logo.png", "notification_icon.png", "dropdown-logo.png",
                                "/payment/result", "payment_result", "ai_response", "style.css")
                        .permitAll()
                        .anyRequest()
                        .authenticated()).
                formLogin((form) -> form.loginPage("/login").permitAll().defaultSuccessUrl("/", true))
                .logout((logout) -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .deleteCookies("JSESSIONID")
                        .invalidateHttpSession(true)
                        .permitAll()
                        ).oauth2Login(oauth2Login->{
                    oauth2Login.loginPage("/login")
                            .successHandler(((request, response, authentication) -> response.sendRedirect("/")));})
                .csrf(withDefaults()).csrf(csrf -> csrf.ignoringRequestMatchers("/payment", "/payment/result"));;
        return http.build();
    }
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(8);
    }
}

//@Configuration
//@EnableWebSecurity
//@AllArgsConstructor
//public class SecurityConfig {
//
//    @Autowired
//    private final CustomUserDetailsService userDetailService;
//
//    @Bean
//    protected SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http
//// та самая строчка, которая фиксик доступ к бд
//                .csrf(AbstractHttpConfigurer::disable)
//                .authorizeHttpRequests((requests) -> requests
//                        .requestMatchers("/", "/registration").permitAll()
//                        .requestMatchers("/product/**", "/image/**")
//                        .hasAnyAuthority("ROLE_ADMIN","ROLE_USER")
//                        .anyRequest().authenticated()
//
//                )
//                .formLogin((form) -> form
//                        .loginPage("/login")
//                        .permitAll()
//                )
//                .logout((logout) -> logout.permitAll());
//
//        return http.build();
//    }
//
//    @Bean
//    public AuthenticationProvider authenticationProvider() {
//        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
//        authenticationProvider.setUserDetailsService(userDetailService);
//        authenticationProvider.setPasswordEncoder(passwordEncoder());
//        return authenticationProvider;
//    }
//
//    @Bean
//    PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder(8);
//    }
//}

