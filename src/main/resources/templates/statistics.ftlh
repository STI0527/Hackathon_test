<!DOCTYPE html>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
</head>

<body>

<header>
    <div class="header-left">
        <#if user.email??>
        <div class="notification-wrapper">
            <img id="notificationIcon" class="notification-image" src="/notification_icon.png">
            <span id="notificationBadge" class="notification-badge" style="display: none;"></span>
        </div>
    </#if>
</div>
    <a href="/">ReUse Hub</a>
    <div id="toggleMenu" class="account-logo-container">
        <#if user.email??>

        <img class="coins-image" src="/coins_logo.png">
        <div class="coins-container">${user.getCoins()}</div>

        <img class="account-logo-image" src="/avatars/${user.avatar.id?string('0')}">
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

            <img class="user-avatar" src="/avatars/${user.avatar.id?string('0')}" alt="avatar">

                <div class="user_menu-name">${user.name}</div>

                <div class="euro_exchange_rate_container">
                    1 EUR — ${euro_exchange_rate} UAH
                </div>

                <div class="material-statistics-container">
                    <canvas id="userMaterialsChart" width="100%" height="20"></canvas>
                    <div class="legend-container">
                        <div class="legend-item">
                            <div class="legend-item-color-plastic"></div>
                            <div class="legend-item-title">Plastic</div>

                        </div>
                        <div class="legend-item">
                            <div class="legend-item-color-metal"></div>
                            <div class="legend-item-title">Metal</div>

                        </div>
                        <div class="legend-item">
                            <div class="legend-item-color-glass"></div>
                            <div class="legend-item-title">Glass</div>

                        </div>
                        <div class="legend-item">
                            <div class="legend-item-color-co2"></div>
                            <div class="legend-item-title">CO<sub>2</sub></div>

                        </div>
                    </div>
                </div>

                <form action="/profile/${user.id?string('0')}" method="post">
                    <input class="user-menu-private-page-text" type="submit" name="profile" value="Profile"/>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                </form>


                <#if user.isAdmin()>
                <a class="user-menu-admin-link" href="/admin">Admin Panel</a>
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


<div id="notificationMenu" class="notifications-container">
    <#list notifications as notification>
    <div id="notification-${notification.id?string('0')}" class="notification-container <#if !notification.read>unread</#if>" onclick="markAsRead(${notification.id?string('0')})">
        <div class="notification-date-container">
            ${notification.shortDateOfOperation}
        </div>

        <#if notification.rewardType == "INFO_SELLER">
        <div class="notification-text-container">
            Exchange offer received! ${notification.sellerName} wants to trade for your <a href="/products/${notification.productId?string('0')}">${notification.productTitle}</a>.
        </div>
        <#elseif notification.rewardType == "INFO_USER">
        <div class="notification-text-container">
            Exchange offer sent for <a href="/products/${notification.productId?string('0')}">${notification.productTitle}</a>!
        </div>
        <#elseif notification.rewardType == "USER_EXCHANGE_DATA_RECEIVED">
        <div class="notification-text-container">
            ${notification.rewardType.operationType} for <a href="/products/${notification.productId?string('0')}">${notification.productTitle}</a>!
        </div>
        <#else>
        <div class="notification-text-container">
            You've got +${notification.rewardAmount}
            <img class="coins-image-notifications" src="/coins_logo.png">
            for ${notification.rewardType.operationType}: ${notification.productTitle}!
        </div>
    </#if>

    <div class="notification-time-container">
        ${notification.dateOfOperation.getHour()?string("00")} : ${notification.dateOfOperation.getMinute()?string("00")}
    </div>

    <form action="/notifications/delete/${notification.id?string('0')}" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button type="submit" onclick="deleteNotification(event, ${notification.id?string('0')})" class="delete-notification-button">
            <img class="cancel-image-notification" src="/cancel_logo.png">
        </button>
    </form>
</div>
<#else>
<div class="no-notifications-text">No notifications</div>
</#list>
        </div>

<div class="order-statistics">
    <#if user.isAdmin()>

    <div class="dropdowns">
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                Display mode
            </button>
            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                <li class="dropdown-item-li">
                    <form action="/orders/all" method="post">
                        <a class="dropdown-item" onclick="selectModeView('Всі')" hidden></a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="All"/>
                    </form>

                </li>

                <li class="dropdown-item-li">
                    <form action="/orders/hour" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('За вчора')" hidden>Last hour</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Last hour"/>
                    </form>
                </li>

                <li class="dropdown-item-li">
                    <form action="/orders/yesterday" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('За вчора')" hidden>Since yesterday</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Since yesterday"/>
                    </form>
                </li>
                <li class="dropdown-item-li">
                    <form action="/orders/week" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('За тиждень')" hidden>For the week</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="For the week"/>
                    </form>
                </li>
                <li class="dropdown-item-li">
                    <form action="/orders/month" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('Минулий місяць')" hidden>Last month</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Last month"/>
                    </form>
                </li>
                <li class="dropdown-item-li">
                    <form action="/orders/year" method="post">
                        <a class="dropdown-item" href="/work" onclick="selectModeView('Минулий рік')" hidden>Last year</a>
                        <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                        <input class="dropdown-submit" type="submit" value="Last year"/>
                    </form>
                </li>

            </ul>
        </div>

        <div class="dropdown">
            <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                <!--                style="background-color: rgba(235, 154, 169, 1); color: white;"-->
                Export
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
            <th scope="col">ID</th>
            <th scope="col">Username</th>
            <th scope="col">Buyer’s email</th>
            <th scope="col">Phone number</th>
            <th scope="col">Date</th>
            <th scope="col">Product name</th>
            <th scope="col">Price, UAH</th>
            <th scope="col">Operating system</th>
            <th scope="col">City</th>
        </tr>
        </thead>

        <tbody>
        <#if orders?? && (orders?size > 0)>
        <#list orders as order>
        <tr>
            <td>${order.id?string('0')}</td>
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
            <td  colspan="9"><h3>No operations found</h3></td>
        </tr>
    </#if>

</tbody>
</table>
</body>
<#else>
        You don't have a permission to visit this page!
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
const toggleMenu = document.getElementById("toggleMenu");
const menu = document.getElementById("menu");
let hideTimeout;


    toggleMenu.addEventListener("click", function () {
        if(menu.classList.contains("active")){
        menu.classList.remove("active");
        clearTimeout(hideTimeout);
        hideTimeout = setTimeout(() => {
            menu.style.visibility = "hidden";
        }, 300);
        } else {
        clearTimeout(hideTimeout);
        menu.style.visibility = "visible";
        menu.classList.add("active");
        document.addEventListener("click", function (event) {
    if (!menu.contains(event.target) && !toggleMenu.contains(event.target)) {
        menu.classList.remove("active");
    }
});

        }
    });

const notificationIcon = document.getElementById("notificationIcon");
const notificationModule = document.getElementById("notificationMenu");


notificationIcon.addEventListener("click", function () {
    // Якщо вже активне — приховуємо з затримкою
    if (notificationMenu.classList.contains("active")) {
        notificationMenu.classList.remove("active");
        clearTimeout(hideTimeout);
        hideTimeout = setTimeout(() => {
            notificationMenu.style.visibility = "hidden";
        }, 300);
    } else {
        clearTimeout(hideTimeout);
        notificationMenu.style.visibility = "visible";
        notificationMenu.classList.add("active");
        document.addEventListener("click", function (event) {
    if (!notificationModule.contains(event.target) && !notificationIcon.contains(event.target)) {
        notificationModule.classList.remove("active");
    }
});
    }
});


</script>

<script>
function deleteNotification(event, id) {
    // Створюємо новий об'єкт XMLHttpRequest для AJAX запиту

    event.preventDefault();

    var xhr = new XMLHttpRequest();

    // Встановлюємо метод та URL для запиту
    xhr.open('POST', '/notifications/delete/' + id, true);

    // Встановлюємо заголовки запиту, включаючи CSRF токен
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('X-CSRF-TOKEN', document.querySelector('input[name="${_csrf.parameterName}"]').value);  // Інжектуємо CSRF токен через Thymeleaf

    // Коли запит завершиться
    xhr.onload = function() {
        if (xhr.status === 200) {
            // Якщо успішно, видаляємо елемент з DOM
            var element = document.getElementById('notification-' + id);
            if (element) {
                element.remove();  // Видаляємо елемент з DOM
            }
            console.log('Сповіщення успішно видалене!');
        } else {
            console.error('Не вдалося видалити сповіщення');
        }
    };

    // Якщо сталася помилка при запиті
    xhr.onerror = function() {
        console.error('Помилка при виконанні запиту');
    };

    // Відправляємо запит
    xhr.send();
}


window.addEventListener('DOMContentLoaded', function () {
    const unreadNotifications = document.querySelectorAll('.notification-container.unread');
    const notificationBadge = document.getElementById('notificationBadge');

    if (unreadNotifications.length > 0) {
        notificationBadge.style.display = 'block';
    } else {
        notificationBadge.style.display = 'none';
    }
});

function markAsRead(notificationId) {
    // Знаходимо сповіщення за ID
    const notificationElement = document.getElementById('notification-'+notificationId);
    const notificationBadge = document.getElementById('notificationBadge');

    // Оновлюємо клас, позначаючи як прочитане
    notificationElement.classList.remove('unread');  // Видаляємо клас unread

    // Перевіряємо наявність непрочитаних сповіщень
    const unreadNotifications = document.querySelectorAll('.notification-container.unread');

    if (unreadNotifications.length === 0) {
        notificationBadge.style.display = 'none';  // Ховаємо бейдж, якщо немає непрочитаних
    }

    // AJAX запит для оновлення статусу повідомлення на сервері
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/notifications/markAsRead/'+notificationId, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.setRequestHeader('X-CSRF-TOKEN', document.querySelector('input[name="${_csrf.parameterName}"]').value);
    xhr.send();
}
</script>

<script>
// Дані користувача
const plasticSaved = ${user.plasticSaved?string("0")};
const metalSaved = ${user.metalSaved?string("0")};
const glassSaved = ${user.glassSaved?string("0")};
const CO2Saved = ${user.CO2Saved?string("0")};

<!--const plasticSaved = 12;-->
<!--const metalSaved = 24;-->
<!--const glassSaved = 24;-->
<!--const CO2Saved = 40;-->

const totalSaved = plasticSaved + metalSaved + glassSaved + CO2Saved;

// Розрахунок відсотків
const percent = (val) => Math.round((val / totalSaved) * 100);

const data = {
    labels: [''],
    datasets: [{
        label: 'Plastic',
        data: [percent(plasticSaved)],
        backgroundColor: 'rgba(255, 99, 132, 0.8)'
    }, {
        label: 'Metal',
        data: [percent(metalSaved)],
        backgroundColor: 'rgba(54, 162, 235, 0.8)'
    }, {
        label: 'Glass',
        data: [percent(glassSaved)],
        backgroundColor: 'rgba(255, 206, 86, 0.8)'
    }, {
        label: 'CO₂',
        data: [percent(CO2Saved)],
        backgroundColor: 'rgba(75, 192, 192, 0.8)'
    }]
};

const config = {
    type: 'bar',
    data: data,
    options: {
        indexAxis: 'y',
        plugins: {
            tooltip: {
                callbacks: {
                    label: function(context) {
                        return `
                        <#noparse>
                        ${context.dataset.label}: ${context.raw}%`;
                        </#noparse>
                    }
                },
                bodyFont: {
                    size: 10
                },
                 padding: 10,
                 maxWidth: 20,
                 backgroundColor: 'rgba(0, 0, 0, 0.8)'

            },
            legend: {
                position: 'none'
            },

        },
        responsive: true,
        scales: {
            x: {
                stacked: true,
                max: 100,
                ticks: {
                    callback: function(value) {
                        return value + '%';
                    }
                }
            },
            y: {
                stacked: true,
                grid: {
                    display: false
                }
            }
        }
    }
};

new Chart(
    document.getElementById('userMaterialsChart'),
    config
);

</script>