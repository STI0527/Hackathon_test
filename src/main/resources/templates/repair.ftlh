<!DOCTYPE HTML>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

        <!--<#if user.email??>-->
        <!--<h3>Ім'я користувача: <i>${user.name}</i></h3>-->
        <!--<form action="/logout" method="post">-->
        <!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>-->
        <!--<input type="submit" value="Вийти з акаунта"/>-->
        <!--</form>-->

<div class="search-container">

    <div class="search-empty-container">

    </div>

    <form class="middle-container" action="/repair" method="get">

    <input class="search-bar" type="text"  name="title" placeholder="ПОШУК...">
        <input class="search-button" type="submit" value=""/>

    </form>

    <#if user.isAdmin()>
    <button id="addButton" class="add-button" onclick="showForm()">Додати товар</button>
</#if>

<div class="search-empty-container">

</div>

</div>

        <!--<div class="search">-->
        <!--<div class="form-outline" data-mdb-input-init>-->
        <!--    <input id="search-focus" type="search" id="form1" class="form-control" />-->
        <!--&lt;!&ndash;    <label class="form-label" for="form1">Search</label>&ndash;&gt;-->
        <!--</div>-->
        <!--<button type="button" class="btn btn-primary" data-mdb-ripple-init>-->
        <!--    <i class="fas fa-search">Пошук</i>-->
        <!--</button>-->
        <!--</div>-->

        <!--<#if user.isAdmin()>-->
        <!--<br>-->
        <!--<a href="/admin">Панель адміністратора</a>-->
        <!--</#if>-->

        <!--<#else>-->
        <!--<a href="/login">Авторизуватися</h3></a>-->
        <!--        </#if>-->

<div class="product-section">
<div class="product_list">
    <#list products as product>

    <div class="product-container">

        <div class="product-title">
            ${product.title}
        </div>

        <a href="/products/${product.id}">
            <div class="product-image-container">

                <img class="product-image" src="/images/${product.images[0].id}"/>
            </div>
        </a>

        <div class="product-description">
            ${product.description}
        </div>

        <div class="buy-button-container">
            <a href="/products/${product.id}">
                <button class="buy-button">
                    РЕМОНТ
                </button>
            </a>
        </div>


    </div>
    <#else>
    <div class="no-products-container">
        Оголошень немає
    </div>
</#list>

</div>

        </div>

<#if user.email??>
<center>
<button onclick="toggleForm()">Додати оголошення</button>
<div id="productForm" style="display: none; margin-top: 20px;">
    <form action="/products/create" method="post" enctype="multipart/form-data">
        Назва товару: <input type="text" name="title" placeholder="..." required><br><br>
        Опис: <input type="text" name="description" placeholder="..." style="width: 200px; height: 50px;"
                     required><br><br>
        Ціна: <input type="number" name="price" step="100" min="0" placeholder="..." required><br><br>
        Місто: <input type="text" name="city" placeholder="..." required><br><br>
        Додайте фотографії до оголошення<br><br>
        <input type="file" name="file1"/><br><br>
        <input type="file" name="file2"/><br><br>
        <input type="file" name="file3"/><br><br>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Додати товар"/>
    </form>
</div>
</center>
        </#if>

<footer>
<div class="empty-container">

</div>
<div class="footer-container">
    <div class="footer-element">
        <a href="/main">
            Головна
        </a>
    </div>
    <div class="footer-element">
        <a href="/#carousel_0b16" data-page-id="65053303">
            Контакти
        </a>
    </div>

    <div class="footer-element">
        <a href="/#carousel_840a" data-page-id="65053303">
            Відгуки
        </a>
    </div>
    <div class="footer-element">
        <a  href="/#carousel_acb2" data-page-id="65053303">
            Зворотній зв'язок
        </a>
    </div>
</div>
<div class="footer-bottom-element">
    <a class="footer-link" href="/">ReUse Hub &#xa9 2025</a>
</div>
<div class="empty-container">

</div>
</footer>

<script src="/script.js"></script>
<script>

document.getElementById("toggleMenu").addEventListener("click", function () {
const menu = document.getElementById("menu");
menu.classList.toggle("active");
});

document.getElementById("addButton").addEventListener("click", function () {
const addForm = document.getElementById("addForm");
addForm.classList.toggle("active");
});

document.getElementById("close-button").addEventListener("click", function() {

const addForm = document.getElementById("addForm");
addForm.classList.toggle("active");
});


</script>

<script>
document.querySelector('.middle-container').addEventListener('submit', function(event) {
    event.preventDefault(); // Запобігаємо стандартному відправленню
    let query = document.querySelector('.search-bar').value.trim();
    if (query.length > 0) {
        window.location.href = '/repair?title=' + encodeURIComponent(query);
    }
});
</script>

        </body>

        </html>