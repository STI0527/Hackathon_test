<!DOCTYPE HTML>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
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


<!--<#if user.email??>-->
<!--<h3>Ім'я користувача: <i>${user.name}</i></h3>-->
<!--<form action="/logout" method="post">-->
<!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>-->
<!--<input type="submit" value="Вийти з акаунта"/>-->
<!--</form>-->


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
            Marketplace
        </button>
    </form>
        </div>


        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="exchange.png">
            </div>
        <form action="/exchange" method="get">
            <button class="mode-button" type="submit">
                Exchange
            </button>
        </form>
        </div>

        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="repair.png">
            </div>
            <form action="/repair" method="get">
                <button class="mode-button" type="submit">
                    Repair
                </button>
            </form>
        </div>


        <div class="mode">
            <div class="img-container">
                <img class="img-mode" src="recycle.png">
            </div>
                <form action="/reuse" method="get">
                    <button class="mode-button" type="submit">
                        Reuse
                    </button>
                </form>
        </div>

    </div>

    <div class="empty-container">

    </div>

    </div>

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

<script src="/script.js"></script>

        </body>

                <style>
                    .mode-container {
                    display: grid;
                    grid-template-columns: 1fr 1fr 1fr 1fr;
                    column-gap: 24px;
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
                    background-color: rgba(255, 255, 255, 0.85);
                    border-radius: 15%;
                    color: white;
                    font-size: 20px;
                    padding: 25px 45px;
                    cursor: pointer;

                    }

                    .img-mode {
                    width: 120px;
                    height: 120px;
                    margin-bottom: 16px;
                    object-fit: cover;
                    }

                    .mode-button {
                    color: white;
                    font-weight: 700;
                    font-size: 20px;
                    background-color: rgba(141, 141, 141, 0.7);
                    padding: 20px 40px;
                    border-radius: 16px;
                    cursor: pointer;
                    }

                    .mode-button:hover {
                    background-color: rgba(141, 141, 141, 1);
                    }



                </style>
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
        </html>