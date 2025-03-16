package com.example.shop.controller;


import com.example.shop.models.LiqPayResponse;
import com.example.shop.models.Order;
import com.example.shop.services.*;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.function.ServerRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final UserService userService;
    private final ProductService productService;
    private final LiqPayService liqPayService;


    @GetMapping("/statistics")
    public String getStatistics(Model model, Principal principal, Authentication authentication){
        if (authentication instanceof OAuth2AuthenticationToken token) {
            model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        }
        if (model.containsAttribute("orders")) {
            model.addAttribute("orders", model.getAttribute("orders"));
        } else {
            model.addAttribute("orders", orderService.getOrderList());
        }
        model.addAttribute("period", "all");

        return "statistics";
    }

    @PostMapping("/statistics")
    public String toStatistics(Model model, Principal principal, Authentication authentication){
        if (authentication instanceof OAuth2AuthenticationToken token) {
            model.addAttribute("user", userService.getUserByEmail(token.getPrincipal().getAttribute("email")));
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            model.addAttribute("user", userService.findUserByPrincipal(principal.getName()));
        }
        model.addAttribute("orders", orderService.getOrderList());
        model.addAttribute("period", "all");
        return "statistics";
    }


    @PostMapping("/orders/all")
    public String allOrders(HttpServletRequest request,
                            RedirectAttributes redirectAttributes, HttpSession session, Model model) {
        String referer = request.getHeader("Referer");
        redirectAttributes.addFlashAttribute("orders", orderService.getOrderList());


        String period = "all";
        String tableTitle = "Усі замовлення";

        redirectAttributes.addFlashAttribute("message", tableTitle);
        model.addAttribute("title", tableTitle);
        session.setAttribute("title", tableTitle);

        //redirectAttributes.addFlashAttribute("period", period);
        model.addAttribute("period", period);
        session.setAttribute("period", period);

        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:/statistics";
    }

    @PostMapping("/orders/hour")
    public String hourOrders(HttpServletRequest request,
                             RedirectAttributes redirectAttributes, HttpSession session, Model model) {
        // Отримуємо замовлення за останню годину
        List<Order> ordersHour = orderService.getOrdersHour();

        // Передаємо нові замовлення і повідомлення
        redirectAttributes.addFlashAttribute("orders", ordersHour);
        redirectAttributes.addFlashAttribute("message", "Замовлення за період " + orderService.getHoursLine(LocalDateTime.now().minusHours(1).getHour()) + ":" + orderService.getMinutesLine(LocalDateTime.now().minusHours(1).getMinute()) + " - "
                + orderService.getHoursLine(LocalDateTime.now().getHour()) + ":" + orderService.getMinutesLine(LocalDateTime.now().getMinute()) + " (" + orderService.getDayLine(LocalDateTime.now().getDayOfMonth()) + "." + orderService.getMonthLine(LocalDateTime.now().getMonthValue()) +  "." + LocalDateTime.now().getYear() + ")");


        String period = "hour";
        String tableTitle = "Замовлення за період " + orderService.getHoursLine(LocalDateTime.now().minusHours(1).getHour()) + ":" + orderService.getMinutesLine(LocalDateTime.now().minusHours(1).getMinute()) + " - "
                + orderService.getHoursLine(LocalDateTime.now().getHour()) + ":" + orderService.getMinutesLine(LocalDateTime.now().getMinute()) + " (" + orderService.getDayLine(LocalDateTime.now().getDayOfMonth()) + "." + orderService.getMonthLine(LocalDateTime.now().getMonthValue()) +  "." + LocalDateTime.now().getYear() + ")";

        redirectAttributes.addFlashAttribute("message", tableTitle);
        model.addAttribute("title", tableTitle);
        session.setAttribute("title", tableTitle);


        //redirectAttributes.addFlashAttribute("period", period);
        model.addAttribute("period", period);
        session.setAttribute("period", period);

        return "redirect:/statistics"; // Перенаправляємо на сторінку статистики
    }


    @PostMapping("/orders/yesterday")
    public String yesterdayOrders(HttpServletRequest request,
                                  RedirectAttributes redirectAttributes, HttpSession session, Model model) {
        String referer = request.getHeader("Referer");
        redirectAttributes.addFlashAttribute("orders", orderService.getOrdersYesterday());

        String period = "yesterday";
        String tableTitle = "Замовлення за період " + "00:00 - 23:59" +
                " (" + orderService.getDayLine(LocalDateTime.now().minusDays(1).getDayOfMonth()) + "." + orderService.getMonthLine(LocalDateTime.now().minusDays(1).getMonthValue()) +  "." + LocalDateTime.now().minusDays(1).getYear() + ")";

        redirectAttributes.addFlashAttribute("message", tableTitle);
        model.addAttribute("title", tableTitle);
        session.setAttribute("title", tableTitle);


        //redirectAttributes.addFlashAttribute("period", period);
        model.addAttribute("period", period);
        session.setAttribute("period", period);

        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:/statistics";
    }

    @PostMapping("/orders/week")
    public String weekOrders(HttpServletRequest request,
                             RedirectAttributes redirectAttributes, HttpSession session, Model model) {
        String referer = request.getHeader("Referer");
        redirectAttributes.addFlashAttribute("orders", orderService.getOrdersWeek());

        String period = "week";
        String tableTitle = "Замовлення за період "
                + orderService.getDayLine(LocalDateTime.now().minusWeeks(1).getDayOfMonth()) + "." + orderService.getMonthLine(LocalDateTime.now().minusWeeks(1).getMonthValue()) + "." + LocalDateTime.now().minusWeeks(1).getYear() + " - "
                + orderService.getDayLine(LocalDateTime.now().getDayOfMonth()) + "." + orderService.getMonthLine(LocalDateTime.now().getMonthValue()) + "." + LocalDateTime.now().getYear();


        redirectAttributes.addFlashAttribute("message", tableTitle);
        model.addAttribute("title", tableTitle);
        session.setAttribute("title", tableTitle);

        //redirectAttributes.addFlashAttribute("period", period);
        model.addAttribute("period", period);
        session.setAttribute("period", period);

        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:/statistics";
    }

    @PostMapping("/orders/month")
    public String monthOrders(HttpServletRequest request,
                              RedirectAttributes redirectAttributes, HttpSession session, Model model) {
        String referer = request.getHeader("Referer");
        redirectAttributes.addFlashAttribute("orders", orderService.getOrdersMonth());

        String period = "month";
        String tableTitle = "Замовлення за період: " + orderService.getMonthName(LocalDateTime.now().minusMonths(1).getMonthValue())
                + " " + LocalDateTime.now().minusMonths(1).getYear() + " року";

        redirectAttributes.addFlashAttribute("message", tableTitle);
        model.addAttribute("title", tableTitle);
        session.setAttribute("title", tableTitle);


        //redirectAttributes.addFlashAttribute("period", period);
        model.addAttribute("period", period);
        session.setAttribute("period", period);

        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:/statistics";
    }


    @PostMapping("/orders/year")
    public String yearOrders(HttpServletRequest request,
                             RedirectAttributes redirectAttributes, HttpSession session, Model model) {
        String referer = request.getHeader("Referer");
        redirectAttributes.addFlashAttribute("orders", orderService.getOrdersYear());

        String period = "year";
        String tableTitle = "Замовлення за " + LocalDateTime.now().minusYears(1).getYear() + " рік";
        redirectAttributes.addFlashAttribute("message", tableTitle);
        model.addAttribute("title", tableTitle);
        session.setAttribute("title", tableTitle);

        //redirectAttributes.addFlashAttribute("period", period);
        model.addAttribute("period", period);
        session.setAttribute("period", period);


        if (referer != null && !referer.isEmpty()) {
            return "redirect:" + referer;
        }
        return "redirect:/statistics";
    }


    @GetMapping("/orders/export/excel")
    public void exportOrdersToExcel(HttpServletResponse response,
                                    HttpSession session) throws IOException {

        String period = (String) session.getAttribute("period");
        String tableTitle = (String) session.getAttribute("title");

        System.out.println("Period: " + period);
        Workbook workbook = orderService.exportToExcel(period, tableTitle);

        String fileName = orderService.getFileExportName(period);

        //String fileName = "orders.xlsx";
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        } finally {
            workbook.close();
        }
        // return "redirect:/statistics";
    }

}
