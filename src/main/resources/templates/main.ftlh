<!DOCTYPE HTML>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="script.js"></script>
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

<div id="menu" class="user-menu-container">
    <div class="user-menu-inner">
        <#if user.email??>

        <img class="user-avatar" src="/avatars/${user.avatar.id}" alt="avatar">

            <div class="user_menu-name">${user.name}</div>

            <div class="euro_exchange_rate_container">
                1 EUR — ${euro_exchange_rate} UAH
            </div>

            <div class="material-statistics-container">
                <canvas id="userMaterialsChart" width="100%" height="20"></canvas>
            </div>




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
        <img class="coins-image-notifications" src="coins_logo.png">
   for ${notification.rewardType.getOperationType()}: ${notification.productTitle}!
        </div>

        <div class="notification-time-container">
            ${notification.dateOfOperation.getHour()?string("00")} : ${notification.dateOfOperation.getMinute()?string("00")}

        </div>

        <form action="/notifications/delete/${notification.id}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button type="submit" onclick="deleteNotification(${notification.id})" class="delete-notification-button">
                <img class="cancel-image-notification" src="cancel_logo.png">
            </button>

        </form>

    </div>


    <#else>
    <div class="no-notifications-text">No notifications</div>
    </#list>
</div>

<section class="title-text-section">
    <div class="marketplace-title">
        Welcome to ReUse Hub — your one-stop place to buy, swap, repair, and reuse items to help the planet and connect with your community!
    </div>
</section>


    <div class="general-modes-container">

    <div class="empty-container">

    </div>

    <div class="mode-container">
        <div class="mode">
            <a href="/marketplace">
            <div class="img-container">
                <img class="img-mode" src="marketplace.png">
            </div>
            </a>
    <form action="/marketplace" method="get">
        <button class="mode-button" type="submit">
            Marketplace
        </button>
    </form>
        </div>


        <div class="mode">
            <a href="/exchange">
            <div class="img-container">
                <img class="img-mode" src="exchange.png">
            </div>
            </a>
        <form action="/exchange" method="get">
            <button class="mode-button" type="submit">
                Exchange
            </button>
        </form>
        </div>

        <div class="mode">
            <a href="/repair">
            <div class="img-container">
                <img class="img-mode" src="repair.png">
            </div>
            </a>
            <form action="/repair" method="get">
                <button class="mode-button" type="submit">
                    Repair
                </button>
            </form>
        </div>


        <div class="mode">
            <a href="/reuse">
            <div class="img-container">
                <img class="img-mode" src="recycle.png">
            </div>
            </a>
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
function deleteNotification(id) {
    fetch(`/notifications/delete/<#noparse>${notification.id}</#noparse>`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': <#noparse>'${_csrf.token}'</#noparse>
        }
    })
    .then(response => {
        if (response.ok) {
            // Видаляємо повідомлення з DOM
            const element = document.getElementById(`notification-<#noparse>${id}</#noparse>`);
            if (element) element.remove();
        } else {
            console.error('Не вдалося видалити сповіщення');
        }
    })
    .catch(error => console.error('Помилка:', error));
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

        </html>