<!DOCTYPE HTML>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

<div class="admin-container">
<div class="admin-table-title">
    Administration Panel

    <form action="/statistics" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input class="statistics-button" type="submit" value="Order Statistics"/>
    </form>

</div>

<div class="table-container">
    <table class="table">
        <thead>
        <tr>
            <th scope="col">Email</th>
            <th scope="col">Telephone number</th>
            <th scope="col">Activeness</th>
            <th scope="col">Roles</th>
            <th scope="col">Ban</th>
            <th scope="col">Detailed information</th>
            <th scope="col">Edit</th>
            <th scope="col">Delete user</th>
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
                <input class="ban_button" type="submit" value="Ban"/>
            </form>
        </td>
        <td>
            <a class="admin_link" href="/user/${user.id}">
                Details...
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
        <#else><h3>Users not found</h3>

    </#list>
</tbody>
</table>

        </div>

        </div>

<form action="/" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}" required/>
<input class="home_button" type="submit" value="Home"/>
</form>
        </main>

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
// Додаємо обробник події, щоб переконатися, що iframe завантажений
document.getElementById("myIframe").onload = function() {
    console.log("iframe завантажений.");
};

</script>

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