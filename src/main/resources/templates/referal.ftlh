<!DOCTYPE HTML>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>
<body>
<header class="header_advanced">
    <div class="container">
        <div class="header_advanced_inner">
            <button class="burger_menu-btn">
                <!--            <span class="burger_span"></span>-->
            </button>
            <h1 class="header_title">Hackathon</h1>

            <#if user.email??>
            <a href="/profile/${user.id}">
                <img class="user_avatar" src="/default_avatar.png" alt="avatar">
            </a>
        </#if>

        <#if !user.email??>
        <a href="/login">
            <img class="user_avatar" src="/default_avatar.png" alt="avatar">
        </a>
    </#if>
</div>
</div>
</header>

<div class="burger_menu">
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

<h3>Реферальна система |</h3>

        <!--<#if user.email??>-->
        <!--<h3>Ім'я користувача: <i>${user.name}</i></h3>-->
        <!--<form action="/logout" method="post">-->
        <!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>-->
        <!--<input type="submit" value="Вийти з акаунта"/>-->
        <!--</form>-->

<form action="/profile/${user.id}" method="post">
<input type="submit" name="profile" value="Особистий кабінет"/>
<input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>

<div class="search">
<form action="/" method="get"/>
Пошук за назвою оголошення: <input type="text" name="title"/>

<input type="submit" value="Пошук"/>
</form>
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

<div class="product_list">
<#list products as product>
<p><img src="/images/${product.images[0].id}" height="150px" width="150px"/> ${product.title} ${product.price} USD| <a href="/products/${product.id}">Додатково</a></p>


<#else>
<h3><i>Оголошень немає</i></h3>

</#list>
        </div>

<hr></hr>

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

<script src="/script.js"></script>


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
    <a class="footer-link" href="/">ReUse Hub &#xa9 2025</a>
</div>
<div class="empty-container">

</div>
</footer>

        </body>

        </html>