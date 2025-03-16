<!DOCTYPE HTML>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
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



<div class="admin-container">
<div class="admin-table-title">
    Панель адміністратора

    <form action="/statistics" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input class="statistics-button" type="submit" value="Статистика замовлень"/>
    </form>

</div>

<div class="table-container">
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Email</th>
            <th scope="col">Номер телефона</th>
            <th scope="col">Активність</th>
            <th scope="col">Ролі</th>
            <th scope="col">Бан</th>
            <th scope="col">Детальна інформація</th>
            <th scope="col">Редагувати</th>
            <th scope="col">Видалити користувача</th>
        </tr>
        </thead>

        <tbody>
        <#list users as user>
        <tr>
            <td>${user.email}</td>
            <td>${user.phoneNumber}</td>
            <td><#if user.isActive()>
                <img class="activeness-image" src="/yes_icon.png">
                <#else>
                <img class="activeness-image" src="/no_icon.png">
                </#if>
            </td>

            <td><#list user.roles as role>
                ${role}
            </#list></td>
        <td>
            <form action="/admin/user/ban/${user.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                <input class="ban_button" type="submit" value="Бан"/>
            </form>
        </td>
        <td>
            <a class="admin_link" href="/user/${user.id}">
                Детально...
            </a>
        </td>

        <td>
            <a class="admin_link" href="/admin/user/edit/${user.id}">
                <img class="edit_button" src="/edit_icon.png">
            </a>
        </td>
        <td>

            <form action="/admin/user/delete/${user.id}" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                <button>
                    <img class="delete_button" src="/delete_icon.png">
                    <input type="submit" value=""/>
                </button>
            </form>

        </td>
        </tr>
        <#else><h3>Користувачів немає</h3>

    </#list>
</tbody>
</table>

        </div>

        </div>

<form action="/" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}" required/>
<input class="home_button" type="submit" value="На головну"/>
</form>
        </main>

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

        </body>

        </html>
<script>
document.getElementById("toggleMenu").addEventListener("click", function () {
    const menu = document.getElementById("menu");
    menu.classList.toggle("active");
});


// Додаємо обробник події, щоб переконатися, що iframe завантажений
document.getElementById("myIframe").onload = function() {
    console.log("iframe завантажений.");
};


</script>