package com.example.shop.enums;

public enum ROCounties {
    Alba("Alba"),
    Arad("Arad"),
    Argeș("Argeș"),
    Bacău("Bacău"),
    Bihor("Bihor"),
    BistrițaNăsăud("Bistrița-Năsăud"),
    Botoșani("Botoșani"),
    Brașov("Brașov"),
    Brăila("Brăila"),
    București("București"),
    Buzău("Buzău"),
    CarașSeverin("Caraș-Severin"),
    Călărași("Călărași"),
    Cluj("Cluj"),
    Constanța("Constanța"),
    Covasna("Covasna"),
    Dâmbovița("Dâmbovița"),
    Dolj("Dolj"),
    Galați("Galați"),
    Giurgiu("Giurgiu"),
    Gorj("Gorj"),
    Harghita("Harghita"),
    Hunedoara("Hunedoara"),
    Ialomița("Ialomița"),
    Iași("Iași"),
    Ilfov("Ilfov"),
    Maramureș("Maramureș"),
    Mehedinți("Mehedinți"),
    Mureș("Mureș"),
    Neamț("Neamț"),
    Olt("Olt"),
    Prahova("Prahova"),
    SatuMare("Satu Mare"),
    Sălaj("Sălaj"),
    Sibiu("Sibiu"),
    Suceava("Suceava"),
    Teleorman("Teleorman"),
    Timiș("Timiș"),
    Tulcea("Tulcea"),
    Vaslui("Vaslui"),
    Vâlcea("Vâlcea"),
    Vrancea("Vrancea");

    private final String englishName;

    ROCounties(String englishName) {
        this.englishName = englishName;
    }

    public String getEnglishName() {
        return englishName;
    }
}
