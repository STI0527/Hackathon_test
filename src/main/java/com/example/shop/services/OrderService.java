package com.example.shop.services;

import com.example.shop.models.Order;
import com.example.shop.models.Product;
import com.example.shop.models.User;
import com.example.shop.repositories.OrderRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@RequiredArgsConstructor
public class OrderService {


    private final OrderRepository orderRepository;


//    public void saveOrder(User customer, Product product, String os) {
//        Order order = new Order();
//        order.setCustomerName(customer.getName());
//        order.setCustomerId(customer.getId());
//        order.setCustomerPhoneNumber(customer.getPhoneNumber());
//        order.setCustomerEmail(customer.getEmail());
//        order.setDateOfPurchase(LocalDateTime.now());
//        order.setProductId(product.getId());
//        order.setOrderName(product.getTitle());
//        order.setOrderPrice(product.getPrice());
//        order.setOrderCity(product.getCity());
//        order.setOperationalSystem(os);
//
//        System.out.println("\u001b[31mUser with email" + customer.getEmail() + " ordered product with id " + product.getId() + " (" + product.getTitle() + "):"
//                + "\u001b[33m " + product.getPrice() + " UAH; \u001b[0m");
//        orderRepository.save(order);
//    }
//
//
//    public List<Order> getOrderList() {
//        return orderRepository.findAll();
//    }

    public String getOperationalSystem(String userAgent) {
        if (userAgent == null) {
            return "Невідома ОС";
        }

        if (userAgent.contains("Windows")) {
            return "Windows";
        } else if (userAgent.contains("Linux")) {
            return "Linux";
        } else if (userAgent.contains("Mac OS X")) {
            return "macOS";
        } else if (userAgent.contains("Android")) {
            return "Android";
        } else if (userAgent.contains("iPhone") || userAgent.contains("iPad")) {
            return "iOS";
        } else {
            return "Невідома ОС";
        }

    }


//    public List<Order> getOrdersHour() {
//        LocalDateTime hourAgo = LocalDateTime.now().minusHours(1);
//
//        List<Order> result = orderRepository.findAll().stream()
//                .filter(order -> {
//                    LocalDateTime orderDate = order.getDateOfPurchase();
//                    return orderDate.isAfter(hourAgo);
//                })
//                .collect(Collectors.toList());
//
//        System.out.println("За останню годину надійшло " + result.size() + " замовлень");
//
//        return result;
//
//    }
//
//    public List<Order> getOrdersYesterday() {
//        LocalDate yesterday = LocalDate.now().minusDays(1);  // Отримуємо вчорашню дату
//        LocalDateTime startOfDay = yesterday.atStartOfDay();  // Початок дня вчора
//        LocalDateTime endOfDay = yesterday.atTime(LocalTime.MAX);  // Кінець дня вчора
//
//        return orderRepository.findAll().stream()
//                .filter(order -> {
//                    LocalDateTime orderDate = order.getDateOfPurchase();
//                    return orderDate.isAfter(startOfDay) && orderDate.isBefore(endOfDay);  // Фільтруємо замовлення вчорашнього дня
//                })
//                .collect(Collectors.toList());
//    }
//
//    public List<Order> getOrdersWeek() {
//        LocalDate weekAgo = LocalDate.now().minusWeeks(1); // Віднімаємо тиждень від поточної дати
//        LocalDateTime startOfWeek = weekAgo.atStartOfDay(); // Початок тижня
//        LocalDateTime endOfWeek = LocalDateTime.now(); // Поточний момент (початок сьогоднішнього дня)
//
//        return orderRepository.findAll().stream()
//                .filter(order -> {
//                    LocalDateTime orderDate = order.getDateOfPurchase();
//                    return orderDate.isAfter(startOfWeek) && orderDate.isBefore(endOfWeek);
//                })
//                .collect(Collectors.toList());
//    }
//
//
//    public List<Order> getOrdersMonth() {
//        // Отримуємо поточний місяць і віднімаємо один місяць
//        LocalDate lastMonth = LocalDate.now().minusMonths(1);
//
//        // Визначаємо початок минулого місяця (перший день місяця)
//        LocalDate startOfMonth = lastMonth.withDayOfMonth(1);
//
//        // Визначаємо кінець минулого місяця (останній день місяця)
//        LocalDate endOfMonth = lastMonth.withDayOfMonth(lastMonth.lengthOfMonth()); // Останній день минулого місяця
//
//        // Перетворюємо ці дати в LocalDateTime для порівняння з даними в базі
//        LocalDateTime startOfMonthDateTime = startOfMonth.atStartOfDay(); // Початок дня першого числа
//        LocalDateTime endOfMonthDateTime = endOfMonth.atTime(LocalTime.MAX); // Кінець дня останнього числа (23:59:59.999999999)
//
//        return orderRepository.findAll().stream()
//                .filter(order -> {
//                    LocalDateTime orderDate = order.getDateOfPurchase();
//                    // Фільтруємо замовлення, які потрапляють в минулий місяць
//                    return orderDate.isAfter(startOfMonthDateTime) && orderDate.isBefore(endOfMonthDateTime);
//                })
//                .collect(Collectors.toList());
//    }

//
//    public List<Order> getOrdersYear() {
//        // Отримуємо поточний рік і віднімаємо один рік
//        LocalDate lastYear = LocalDate.now().minusYears(1);
//
//        // Визначаємо початок минулого року (перший день року)
//        LocalDate startOfYear = lastYear.withDayOfYear(1);
//
//        // Визначаємо кінець минулого року (останній день року)
//        LocalDate endOfYear = lastYear.withDayOfYear(lastYear.lengthOfYear()); // Останній день року
//
//        // Перетворюємо ці дати в LocalDateTime для порівняння з даними в базі
//        LocalDateTime startOfYearDateTime = startOfYear.atStartOfDay(); // Початок дня першого числа року
//        LocalDateTime endOfYearDateTime = endOfYear.atTime(LocalTime.MAX); // Кінець дня останнього числа року (23:59:59.999999999)
//
//        return orderRepository.findAll().stream()
//                .filter(order -> {
//                    LocalDateTime orderDate = order.getDateOfPurchase();
//                    // Фільтруємо замовлення, які потрапляють в минулий рік
//                    return orderDate.isAfter(startOfYearDateTime) && orderDate.isBefore(endOfYearDateTime);
//                })
//                .collect(Collectors.toList());
//    }

    public StringBuilder getMinutesLine(int minutesNumber) {
        StringBuilder dayLine = new StringBuilder(String.valueOf(minutesNumber));

        if (minutesNumber < 10) {
            dayLine.append("0");
            dayLine.reverse();
        }

        return dayLine;
    }


    public StringBuilder getHoursLine(int hoursNumber) {
        StringBuilder dayLine = new StringBuilder(String.valueOf(hoursNumber));

        if (hoursNumber < 10) {
            dayLine.append("0");
            dayLine.reverse();
        }

        return dayLine;
    }


    public StringBuilder getDayLine(int dayNumber) {
        StringBuilder dayLine = new StringBuilder(String.valueOf(dayNumber));

        if (dayNumber < 10) {
            dayLine.append("0");
            dayLine.reverse();
        }

        return dayLine;
    }

    public StringBuilder getMonthLine(int monthNumber) {
        StringBuilder monthLine = new StringBuilder(String.valueOf(monthNumber));

        if (monthNumber < 10) {
            monthLine.append("0");
            monthLine.reverse();
        }

        return monthLine;
    }

    public String getMonthName(int monthValue) {
        String[] months = new String[]{"січень", "лютий", "березень",
                "квітень", "травень", "червень", "липень", "серпень",
                "вересень", "жовтень", "листопад", "грудень"};

        return months[monthValue - 1];

    }

    public String getFileExportName(String period) {
        System.out.println("Export period: " + period);

        switch (period) {
            case "hour":
                return "last_hour_orders.xlsx";
            case "yesterday":
                return "yesterday_orders.xlsx";
            case "week":
                return "last_week_orders.xlsx";
            case "month":
                return "previous_month_orders.xlsx";
            case "year":
                return "previous_year_orders.xlsx";
            default:
                return "all_orders.xlsx";
        }


    }

//    public Workbook exportToExcel(String period, String tableTitle) {
//
//        List<Order> orders;
//
//        switch (period) {
//            case "hour":
//                orders = this.getOrdersHour();
//                break;
//            case "yesterday":
//                orders = this.getOrdersYesterday();
//                break;
//            case "week":
//                orders = this.getOrdersWeek();
//                break;
//            case "month":
//                orders = this.getOrdersMonth();
//                break;
//            case "year":
//                orders = this.getOrdersYear();
//                break;
//            default:
//                orders = this.getOrderList();
//        }
//
//        //List<Order> orders = this.getOrderList();
//        // Створення Excel книги
//        Workbook workbook = new XSSFWorkbook();
//        Sheet sheet = workbook.createSheet("Orders");
//
//        // Заголовки таблиці
//        String[] columns = {
//                "Order ID", "Customer Name", "Customer ID", "Phone Number", "Email",
//                "OS", "Date of Purchase", "Order Name", "Price (UAH)", "City"
//        };
//
//
//        CellStyle borderStyle = workbook.createCellStyle();
//        borderStyle.setBorderTop(BorderStyle.THIN);
//        borderStyle.setBorderBottom(BorderStyle.THIN);
//        borderStyle.setBorderLeft(BorderStyle.THIN);
//        borderStyle.setBorderRight(BorderStyle.THIN);
//
//
//        Row titleRow = sheet.createRow(0);
//        Cell titleCell = titleRow.createCell(0);
//        titleCell.setCellValue(tableTitle);
//
//        CellStyle titleStyle = workbook.createCellStyle();
//        Font titleFont = workbook.createFont();
//        titleFont.setBold(true);
//        titleFont.setFontHeightInPoints((short) 12); // Розмір шрифту
//        titleStyle.setFont(titleFont);
//        titleStyle.setBorderTop(BorderStyle.THIN);
//        titleStyle.setBorderBottom(BorderStyle.THIN);
//        titleStyle.setBorderLeft(BorderStyle.THIN);
//        titleStyle.setBorderRight(BorderStyle.THIN);
//        titleStyle.setAlignment(HorizontalAlignment.CENTER); // Горизонтальне центрування
//        titleStyle.setVerticalAlignment(VerticalAlignment.CENTER); // Вертикальне центрування
//        titleCell.setCellStyle(titleStyle);
//        ;
//// Об'єднання комірок
//        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 9));
//        for (int col = 1; col <= 9; col++) {
//            Cell cell = titleRow.createCell(col);
//            cell.setCellStyle(borderStyle);
//        }
//
//        Row headerRow = sheet.createRow(1);
//        for (int i = 0; i < columns.length; i++) {
//            Cell cell = headerRow.createCell(i);
//            cell.setCellValue(columns[i]);
//            CellStyle style = workbook.createCellStyle();
//            Font font = workbook.createFont();
//            font.setBold(true);
//            style.setFont(font);
//            style.setBorderTop(BorderStyle.THIN);
//            style.setBorderBottom(BorderStyle.THIN);
//            style.setBorderLeft(BorderStyle.THIN);
//            style.setBorderRight(BorderStyle.THIN);
//            cell.setCellStyle(style);
//        }
//
//        /*// Формат дати
//        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");*/
//
//        // Заповнення таблиці даними
//        int rowIndex = 2;
//        for (Order order : orders) {
//            Row row = sheet.createRow(rowIndex++);
//            row.createCell(0).setCellValue(order.getId());
//            row.createCell(1).setCellValue(order.getCustomerName());
//            row.createCell(2).setCellValue(order.getCustomerId());
//            row.createCell(3).setCellValue(order.getCustomerPhoneNumber());
//            row.createCell(4).setCellValue(order.getCustomerEmail());
//            row.createCell(5).setCellValue(order.getOperationalSystem());
//            row.createCell(6).setCellValue(order.getDateOfPurchase().toString());
//            /*row.createCell(6).setCellValue(order.getDateOfPurchase().format(dateFormatter));*/
//            row.createCell(7).setCellValue(order.getOrderName());
//            row.createCell(8).setCellValue(order.getOrderPrice());
//            row.createCell(9).setCellValue(order.getOrderCity());
//
//            row.getCell(0).setCellStyle(borderStyle);
//            row.getCell(1).setCellStyle(borderStyle);
//            row.getCell(2).setCellStyle(borderStyle);
//            row.getCell(3).setCellStyle(borderStyle);
//            row.getCell(4).setCellStyle(borderStyle);
//            row.getCell(5).setCellStyle(borderStyle);
//            row.getCell(6).setCellStyle(borderStyle);
//            row.getCell(7).setCellStyle(borderStyle);
//            row.getCell(8).setCellStyle(borderStyle);
//            row.getCell(9).setCellStyle(borderStyle);
//
//        }
//
//        // Автоматичне підлаштування ширини колонок
//        for (int i = 0; i < columns.length; i++) {
//            sheet.autoSizeColumn(i);
//        }
//
//        return workbook;
//
//    }
//
}
