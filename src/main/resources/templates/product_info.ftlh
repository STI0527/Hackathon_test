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
    <div class="header-left">
        <#if user.email??>
        <img id="notificationIcon" class="notification-image" src="/notification_icon.png">
        </#if>
    </div>
    <a href="/">ReUse Hub</a>
    <div id="toggleMenu" class="account-logo-container">
        <#if user.email??>

        <img class="coins-image" src="/coins_logo.png">
        <div class="coins-container">${user.getCoins()}</div>

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

<div id="notificationMenu" class="notifications-container">
    <#list notifications as notification>
    <div id="notification-${notification.id}" class="notification-container">
        <div class="notification-date-container">
            ${notification.shortDateOfOperation}

        </div>

        <div class="notification-text-container">You've got +${notification.rewardAmount}
            <img class="coins-image-notifications" src="/coins_logo.png">
            for ${notification.rewardType.getOperationType()}: ${notification.productTitle}!
        </div>

        <div class="notification-time-container">
            ${notification.dateOfOperation.getHour()?string("00")} : ${notification.dateOfOperation.getMinute()?string("00")}

        </div>

        <form action="/notifications/delete/${notification.id}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button type="submit" onclick="deleteNotification(event, ${notification.id})" class="delete-notification-button">
                <img class="cancel-image-notification" src="/cancel_logo.png">
            </button>

        </form>

    </div>


    <#else>
    <div class="no-notifications-text">No notifications</div>
</#list>
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
</script>

<script>
// Дані користувача
<!--const plasticSaved = ${user.plasticSaved};-->
<!--const metalSaved = ${user.metalSaved};-->
<!--const glassSaved = ${user.glassSaved};-->
<!--const CO2Saved = ${user.CO2Saved};-->

const plasticSaved = 12;
const metalSaved = 24;
const glassSaved = 24;
const CO2Saved = 40;

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
<!--            title: {-->
<!--                display: true,-->
<!--                text: 'Відсоток збережених матеріалів'-->
<!--            }-->
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
