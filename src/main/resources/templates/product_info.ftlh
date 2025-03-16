<!DOCTYPE HTML>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
</head>

<body>


<header>
    <div class="header-left"></div>
    <a href="/">ReUse Hub</a>
    <div id="toggleMenu" class="account-logo-container">
        <#if user.email??>
        <img class="account-logo-image" src="/avatars/${user.avatar.id}">
        <#else>
        <img class="account-logo-image" src="/default_avatar.png">
        </#if>

        <img class="dropdown-icon" src="/dropdown-logo.png">
    </div>
    <div class="header-right"></div>

</header>

<div class="body-flex">

    <main class="main-flex">

    <div id="menu" class="user-menu-container">
        <div class="user-menu-inner">
            <#if user.email??>

            <img class="user-avatar" src="/avatars/${user.avatar.id}" alt="avatar">

                <div class="user_menu-name">${user.name}</div>

                <form action="/profile/${user.id}" method="post">
                    <input class="user-menu-private-page-text" type="submit" name="profile" value="Особистий кабінет"/>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>


                <#if user.isAdmin()>
                <a class="user-menu-admin-link" href="/admin">Панель адміністратора</a>
            </#if>


            <form action="/logout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input class="user-menu-quit-text" type="submit" value="Вийти з акаунта"/>
            </form>
            <#else>
            <img class="user-avatar" src="/default_avatar.png" alt="avatar">
                <a class="burger_menu_authorize burger_btn-base" href="/login">Авторизуватися</h3></a>
        </#if>

    </div>
</div>


<#if productNotFound??>
<div class="product-not-found-container">
    <div class="title-text" style="
    padding: 25px 45px;
    background-color: rgb(255, 255, 255, 1);">
        ${productNotFound}
    </div>
</div>

<#else>

<div class="product-info-container">

    <div class="product-card">
        <div class="left-container">

            <div class="swiper">
                <div class="swiper-wrapper">
                    <#list images as img>
                    <div class="swiper-slide">
                        <img class="product-info-image" src="/images/${img.id}" alt="Фото ${img.id}">
                    </div>
                </#list>

            </div>

            <!-- Кнопки для навігації -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>

            <!-- Індикатори пагінації -->
            <div class="swiper-pagination"></div>

        </div> <!-- Закриваючий тег для swiper -->

    </div> <!-- Закриваючий тег для left-container -->

    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
        const swiper = new Swiper('.swiper', {
            loop: true,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });
    </script>

    <div class="right-container">


    <div class="product-info-title">${product.title}</div>
        <div class="product-info-price">${product.price} ₴</div>
        <div class="product-info-description"> ${product.description}</div>
        <div class="pink-container">
            <div class="product-info-city"> ${product.city}</div>
            <div class="product-info-author"> Автор: <a href="/user/${product.user.id}">${product.user.name}</a></div

            <div class="product-info-buy">
                <form method="post" accept-charset="utf-8" action="https://www.liqpay.ua/api/3/checkout">
                    <input type="hidden" name="data" value="${liqPayData}" />
                    <input type="hidden" name="signature" value="${liqPaySignature}" />

                    <button class="liqpay-button">
                        BUY NOW
                    </button>
                </form>
            </div>
        </div>
        <!--<b>Номер телефона:</b>${product.user.phoneNumber}<br>-->
        <hr>
        <!--<form action = "/products/delete/${product.id}" method = "post">-->
        <!--<input type = "submit" value = "Видалити товар"/>-->
        <!--</form>-->



    </div>
</div>

<#if message??>
<br>
    <h3>${message}</h3>
</#if>

</div>

</#if>
</main>
        </body>

        </html>


<script>
document.getElementById("toggleMenu").addEventListener("click", function () {
    const menu = document.getElementById("menu");
    menu.classList.toggle("active");
});

</script>