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


<hr></hr>

<form action="/marketplace" method="get">
<button type="submit">
Маркетплейс
</button>
<input type="hidden" name="_csrf" value="${_csrf.token}"/>
</form>

<br><br>

    <form action="/marketplace" method="get">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit">
            Маркетплейс
        </button>
    </form>

    <br><br>

        <form action="/exchange" method="get">
            <button type="submit">
                Обмін
            </button>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>

        <br><br>

            <form action="/repair" method="get">
                <button type="submit">
                    Ремонт
                </button>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            </form>

            <br><br>

                <form action="/referal" method="get">
                    <button type="submit">
                        Реферальна система
                    </button>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>

<script src="/script.js"></script>

        </body>

        </html>