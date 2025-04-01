<!DOCTYPE html>
<html>
<head>
    <title>YUKI</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

<div class="order-statistics">
    <#if user.isAdmin()>

    <div class="dropdowns">
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                Режим показу
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li class="dropdown-item-li">
                    <form action="/orders/all" method="post">
                        <a class="dropdown-item" onclick="selectModeView('Всі')" hidden></a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Всі"/>
                    </form>

                </li>

                <li class="dropdown-item-li">
                    <form action="/orders/hour" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('За вчора')" hidden>Остання година</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Остання година"/>
                    </form>
                </li>

                <li class="dropdown-item-li">
                    <form action="/orders/yesterday" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('За вчора')" hidden>За вчора</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="За вчора"/>
                    </form>
                </li>
                <li class="dropdown-item-li">
                    <form action="/orders/week" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('За тиждень')" hidden>За тиждень</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="За тиждень"/>
                    </form>
                </li>
                <li class="dropdown-item-li">
                    <form action="/orders/month" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('Минулий місяць')" hidden>Минулий місяць</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Минулий місяць"/>
                    </form>
                </li>
                <li class="dropdown-item-li">
                    <form action="/orders/year" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('Минулий рік')" hidden>Минулий рік</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Минулий рік"/>
                    </form>
                </li>

            </ul>
        </div>

        <div class="dropdown">
            <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                <!--                style="background-color: rgba(235, 154, 169, 1); color: white;"-->
                Експорт
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li>
                    <form action="/orders/export/excel" method="get">
                        <a class="dropdown-item" href="#" onclick="selectModeExport('Excel')" hidden>Excel</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Excel"/>
                    </form>
                </li>
                <!--<li>
                    <a class="dropdown-item" href="#" onclick="selectModeExport('PDF')" >PDF</a>
                </li>-->


            </ul>
        </div>
    </div>

    <#if message??>
    <div class="order-statistics-title">${message}</div>
</#if>


        <!--    <button class="alert_button" onclick="dropTableOrders()">Очистити статистику замовлень (рекомендується після експорту)</button>-->

        <!--    <script>-->
        <!--        function dropTableOrders() {-->
        <!--            fetch('/dropTableOrders', {-->
        <!--                method: 'GET',-->
        <!--            })-->
        <!--            .then(response => response.text())-->
        <!--            .then(data => alert(data))-->
        <!--            .catch(error => alert('Error: ' + error));-->
        <!--        }-->
        <!--    </script>-->

<div class="table-container">
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Номер замовлення</th>
            <th scope="col">Ім'я покупця</th>
            <th scope="col">Email покупця</th>
            <th scope="col">Номер телефона</th>
            <th scope="col">Дата</th>
            <th scope="col">Назва продукта</th>
            <th scope="col">Ціна, грн</th>
            <th scope="col">Операційна система</th>
            <th scope="col">Місто</th>
        </tr>
        </thead>

        <tbody>
        <#if orders?? && (orders?size > 0)>
        <#list orders as order>
        <tr>
            <td>${order.id}</td>
            <td>${order.customerName}</td>
            <td>${order.customerEmail}</td>
            <td>${order.customerPhoneNumber}</td>
            <td>${order.dateOfPurchase}</td>
            <td>${order.orderName}</td>
            <td>${order.orderPrice}</td>
            <td>${order.operationalSystem}</td>
            <td>${order.orderCity}</td>
        </tr>
        </#list>
        <#else>
        <tr>
            <td  colspan="9"><h3>Замовлень немає</h3></td>
        </tr>
    </#if>

</tbody>
</table>
</body>
<#else>
        У Вас немає дозволу для цієї сторінки!
        </#if>

        </div>
        </main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
function selectModeView(value) {
// Задаємо значення прихованому полю
event.preventDefault();

// Оновлюємо текст кнопки
document.getElementById('dropdownMenuButton').textContent = value;
}

function selectModeExport(value) {
// Задаємо значення прихованому полю
event.preventDefault();

// Оновлюємо текст кнопки
document.getElementById('dropdownMenuButton1').textContent = value;
}

</script>


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

<script>
document.getElementById("toggleMenu").addEventListener("click", function () {
    const menu = document.getElementById("menu");
    menu.classList.toggle("active");
});

</script>