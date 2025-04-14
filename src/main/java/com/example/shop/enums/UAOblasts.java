package com.example.shop.enums;

public enum UAOblasts {
    Cherkasy_Oblast("Cherkasy Oblast"),
    Chernihiv_Oblast("Chernihiv Oblast"),
    Chernivtsi_Oblast("Chernivtsi Oblast"),
    Dnipropetrovsk_Oblast("Dnipropetrovsk Oblast"),
    Donetsk_Oblast("Donetsk Oblast"),
    IvanoFrankivsk_Oblast("Ivano-Frankivsk Oblast"),
    Kharkiv_Oblast("Kharkiv Oblast"),
    Kherson_Oblast("Kherson Oblast"),
    Khmelnytskyi_Oblast("Khmelnytskyi Oblast"),
    Kirovohrad_Oblast("Kirovohrad Oblast"),
    Kyiv_Oblast("Kyiv Oblast"),
    Luhansk_Oblast("Luhansk Oblast"),
    Lviv_Oblast("Lviv Oblast"),
    Mykolaiv_Oblast("Mykolaiv Oblast"),
    Odesa_Oblast("Odesa Oblast"),
    Poltava_Oblast("Poltava Oblast"),
    Rivne_Oblast("Rivne Oblast"),
    Sumy_Oblast("Sumy Oblast"),
    Ternopil_Oblast("Ternopil Oblast"),
    Vinnytsia_Oblast("Vinnytsia Oblast"),
    Volyn_Oblast("Volyn Oblast"),
    Zakarpattia_Oblast("Zakarpattia Oblast"),
    Zaporizhzhia_Oblast("Zaporizhzhia Oblast"),
    Zhytomyr_Oblast("Zhytomyr Oblast"),
    Kyiv_City("Kyiv"),
    Crimea("Crimea");

    private final String englishName;

    UAOblasts(String englishName) {
        this.englishName = englishName;
    }

    public String getEnglishName() {
        return englishName;
    }
}

