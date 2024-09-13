<!DOCTYPE HTML>
<html>
<head>
    <title>SHOP</title>
    <link rel="stylesheet" href="/style.css">
</head>
<body>
<header class="header_advanced">
    <div class="container">
        <div class="header_advanced_inner">
        <button class="burger_menu-btn">
<!--            <span class="burger_span"></span>-->
        </button>
        <h1 class="header_title">SHOP</h1>

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
    <div class="burger_menu-inner">
        <#if user.email??>
            <img class="burger_user-avatar" src="/default_avatar.png" alt="avatar">

            <h3 class="burger_menu-user">${user.name}</h3>
                <form action="/profile/${user.id}" method="post">
                    <input class="burger_menu_personal burger_btn-base" type="submit" name="profile" value="Особистий кабінет"/>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>

        <#if user.isAdmin()>
                <a class="burger_menu_admin burger_btn-base" href="/admin">Панель адміністратора</a>
        </#if>

        <form action="/logout" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="burger_menu_quit burger_btn-base" type="submit" value="Вийти з акаунта"/>
        </form>
        <#else>
        <img class="user_avatar" src="/default_avatar.png" alt="avatar">
            <a class="burger_menu_authorize burger_btn-base" href="/login">Авторизуватися</h3></a>
    </#if>

    </div>
</div>

<h3>Інтернет-магазин |</h3>

<#if user.email??>
<h3>Ім'я користувача: <i>${user.name}</i></h3>
<form action="/logout" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
<input type="submit" value="Вийти з акаунта"/>
</form>

<form action="/profile/${user.id}" method="post">
<input type="submit" name="profile" value="Особистий кабінет"/>
<input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>
<form action="/" method="get"/>
        Пошук за назвою оголошення: <input type="text" name="title"/>

<input type="submit" value="Пошук"/>
        </form>

<#if user.isAdmin()>
<br>
<a href="/admin">Панель адміністратора</a>
</#if>

<#else>
<a href="/login">Авторизуватися</h3></a>
        </#if>


<#list products as product>
<div>
<p>${product.title} ${product.price} USD| <a href="/products/${product.id}">Додатково</a></p>

</div>

<#else>
<h3><i>Оголошень немає</i></h3>

        </#list>

<hr></hr>
<#if user.email??>
<center>
<h3>Створити новий товар</h3>
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
</center>
        </#if>

<script src="/script.js"></script>

        </body>

        </html>