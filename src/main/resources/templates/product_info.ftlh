<!DOCTYPE HTML>
<html>
<head>
    <title>ReUse Hub</title>
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
                    <input class="user-menu-private-page-text" type="submit" name="profile" value="Profile"/>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>


                <#if user.isAdmin()>
                <a class="user-menu-admin-link" href="/admin">Administration Panel</a>
            </#if>


            <form action="/logout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input class="user-menu-quit-text" type="submit" value="Log out"/>
            </form>
            <#else>
            <img class="user-avatar" src="/default_avatar.png" alt="avatar">
                <a class="burger_menu_authorize burger_btn-base" href="/login">Sign in</h3></a>
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
        <div class="product-info-virtual-price">${product.virtualPrice}
        <img class="coins-image-product-info" src="/coins_logo.png">
        </div>
        <div class="product-info-description"> ${product.description}</div>
        <div class="pink-container">
            <div class="product-info-city"> ${product.city}</div>
            <div class="product-info-author"> Author: <a href="/user/${product.user.id}">${product.user.name}</a></div

            <div class="product-info-buy">

                    <button class="liqpay-button" onclick="showTypesOfPayment();">
                        BUY NOW
                    </button>

            </div>
        </div>
        <!--<b>Номер телефона:</b>${product.user.phoneNumber}<br>-->
        <hr>
        <!--<form action = "/products/delete/${product.id}" method = "post">-->
        <!--<input type = "submit" value = "Видалити товар"/>-->
        <!--</form>-->


</div>
</div>

<div id="paymentModal" style="display: none; position: fixed; top: 0; left: 0;
width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 9999;"
onclick="onModalBackgroundClick(event)">

<div style="background-color: white; padding: 20px; border-radius: 10px;
        width: 450px; margin: 100px auto; text-align: center;">

    <div id="modalContent" style="background-color: white;">

    <h3>Choose a payment method</h3>

    <form method="post" accept-charset="utf-8" action="https://www.liqpay.ua/api/3/checkout">
        <input type="hidden" name="data" value="${liqPayData}" />
        <input type="hidden" name="signature" value="${liqPaySignature}" />

        <button class="liqpay-button">
            ${product.price} UAH
        </button>
    </form>

        <form action="/buy/virtual/${product.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type="hidden" name="virtualPrice" value="${product.virtualPrice}">
    <button class="liqpay-button">
        ${product.virtualPrice}
        <img class="coins-image" src="/coins_logo.png">
    </button>
        </form>
        <br><br>

    <button onclick="closeModal()">❌ Скасувати</button>
</div>
</div>

<script>
    function showTypesOfPayment() {
            document.getElementById("paymentModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("paymentModal").style.display = "none";
        }

        function payWithMoney() {
            closeModal();
            alert("Оплата реальними грошима вибрана ✅");
            // Тут можна редіректити або викликати API
        }

        function payWithVirtual() {
            closeModal();
            alert("Оплата віртуальною валютою вибрана ✅");
            // Тут також обробити оплату віртуальною
        }

        function onModalBackgroundClick(event) {
        const modalContent = document.getElementById("modalContent");
        if (!modalContent.contains(event.target)) {
            closeModal();
        }
    }

</script>


<#if message??>
<br>
    <h3>${message}</h3>
</#if>

</div>

</#if>

<footer>
<div class="empty-container">

</div>
<div class="footer-container">
    <div class="footer-element">
        <a href="/main">
            Home
        </a>
    </div>
    <div class="footer-element">
        <a href="/#carousel_0b16" data-page-id="65053303">
            Contacts
        </a>
    </div>

    <div class="footer-element">
        <a href="/#carousel_840a" data-page-id="65053303">
            Reviews
        </a>
    </div>
    <div class="footer-element">
        <a  href="/#carousel_acb2" data-page-id="65053303">
            Feedback
        </a>
    </div>
</div>
<div class="footer-bottom-element">
    <a class="footer-link" href="/">ReUse Hub &#xa9; 2025</a>
</div>
<div class="empty-container">

</div>
</footer>


</body>

</html>


<script>
document.getElementById("toggleMenu").addEventListener("click", function () {
    const menu = document.getElementById("menu");
    menu.classList.toggle("active");
});

</script>
