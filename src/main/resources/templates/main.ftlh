<!DOCTYPE HTML>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>
<body>
<header>
    <div class="header-left"></div>
    <a href="/">YUKI — СМАК МАЙБУТНЬОГО</a>
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

<div id="menu" class="user-menu-container">
    <div class="user-menu-inner">
        <#if user.email??>
            <img class="user-avatar" src="/default_avatar.png" alt="avatar">

            <h3 class="user_menu-name" >${user.name}</h3>
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
        <img class="user_avatar" src="/default_avatar.png" alt="avatar">
            <a class="" href="/login">Авторизуватися</h3></a>
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


<br><br>
<br><br>

    <div class="general-modes-container">

    <div class="empty-container">

    </div>

    <div class="mode-container">
        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="marketplace.png">
            </div>
    <form action="/marketplace" method="get">
        <button class="mode-button" type="submit">
            Маркетплейс
        </button>
    </form>
        </div>


        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="exchange.png">
            </div>
        <form action="/exchange" method="get">
            <button class="mode-button" type="submit">
                Обмін
            </button>
        </form>
        </div>

        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="repair.png">
            </div>
            <form action="/repair" method="get">
                <button class="mode-button" type="submit">
                    Ремонт
                </button>
            </form>
        </div>


        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="recycle.png">
            </div>
                <form action="/referal" method="get">
                    <button class="mode-button" type="submit">
                        Реферальна система
                    </button>
                </form>
        </div>

    </div>

    <div class="empty-container">

    </div>

    </div>

<script src="/script.js"></script>

        </body>

                <style>
                    .mode-container {
                    display: grid;
                    grid-template-columns: 1fr 1fr 1fr 1fr;
                    column-gap: 42px;
                    padding-top: 30px;
                    }

                    .general-modes-container {
                    display: flex;
                    align-items: center;
                    justify-center: center;
                    }

                    .empty-container{
                    display: flex;
                    flex: 1;
                    }

                    .mode{
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    background-color: #4CAF50;
                    border-radius: 15%;
                    color: white;
                    font-size: 20px;
                    padding: 25px 45px;

                    }

                    .img-mode {
                    width: 120px;
                    height: 120px;
                    margin-bottom: 16px;
                    }

                    .mode-button {
                    font-size: 20px;
                    }



                </style>

        </html>