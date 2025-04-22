<!DOCTYPE HTML>
<html>

<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    <div id="menu" class="user-menu-container">
        <div class="user-menu-inner">
            <#if user.email??>

            <img class="user-avatar" src="/avatars/${user.avatar.id}" alt="avatar">

                <div class="user_menu-name">${user.name}</div>

                <form action="/profile/${user.id}" method="post">
                    <input class="user-menu-private-page-text" type="submit" name="profile" value="Profile" />
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                </form>


                <#if user.isAdmin()>
                <a class="user-menu-admin-link" href="/admin">Administration Panel</a>
            </#if>


            <form action="/logout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input class="user-menu-quit-text" type="submit" value="Log out" />
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
            ${notification.dateOfOperation.getHour()?string("00")} :
            ${notification.dateOfOperation.getMinute()?string("00")}

        </div>

        <form action="/notifications/delete/${notification.id}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            <button type="submit" onclick="deleteNotification(event, ${notification.id})"
                    class="delete-notification-button">
                <img class="cancel-image-notification" src="/static/cancel_logo.png">
            </button>

        </form>

    </div>


    <#else>
    <div class="no-notifications-text">No notifications</div>
</#list>
</div>

<div class="profile-container">
    <div class="profile-card">

        <div class="profile-card-left-container">
            <div class="profile-title">Profile</div>


            <div class="profile-subtitle">${user.name}</div>

            <#if user.avatar??>
            <img class="profile-page-avatar" src="/avatars/${user.avatar.id}" alt="Profile image"
                 width="230px" height="216px" />
            <#else>
            <img class="profile-page-avatar" src="/default_avatar.png" alt="Profile image" />
        </#if>

        <div class="change-avatar-container">
            <form id="uploadForm" action="/changeAvatar/${user.id}" method="post"
                  enctype="multipart/form-data">
                <input id="file-upload" type="file" name="file"
                       onchange="document.getElementById('uploadForm').submit();" />
                <input type="hidden" name="_csrf" value="${_csrf.token}" required />
                <label for="file-upload" class="file-upload-btn">Change photo</label>
            </form>
        </div>

        <div>
            Balance: ${user.coins}
            <img class="coins-image" src="/coins_logo.png">
        </div>

        <#if euro_exchange_rate??>
        <div>Euro exchange rate: ${euro_exchange_rate}</div>
    </#if>

    <div class="profile-information-container">
        <div class="profile-user-information">Email: ${user.email}</div>
        <div class="profile-user-information">Telephone number: ${user.phoneNumber}</div>
    </div>


    <#if user.isAdmin()>
    <h3>
        <button onclick="toggleMyProducts()" style="background-color: rgba(202, 202, 202, 0.6);
                                            border-radius: 16px;
                                            padding: 6px 12px;">
            My products
            <img class="dropdown-icon" style="margin:0;" src="/dropdown-logo.png"></img>
        </button>

    </h3>

    <div id="myProducts" style="display: none;">
        <#list products as product>
        <p>${product.title} ${product.price} USD| <a href="/products/${product.id}">Details</a>
        </p>
        <form action="/products/delete/${product.id}" method="post"
              enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}" required />
            <input type="submit" value="Delete" />
        </form>

        <button onclick="toggleForm()">Edit</button>
        <div id="productForm" style="display: none; margin-top: 20px;">
            <form action="/products/edit/${product.id}" method="post"
                  enctype="multipart/form-data">
                <input type="hidden" name="newTitle" id="newDrinkName" placeholder="..."
                       required>
                <br><br>
                Description: <input type="text" name="newDescription" placeholder="..."
                                    value="${product.description}" style="width: 200px; height: 50px;"
                                    required><br><br>
                Price: <input type="number" name="newPrice" step="100" min="0" placeholder="..."
                              value="${product.price}" required><br><br>
                City: <input type="text" name="newCity" placeholder="..."
                             value="${product.city}" required><br><br>
                Change the advertisement photos<br><br>
                <#if product.images??>
                <#list product.images as image>
                <img src="/images/${image.id}" width="180px" height="180px" />



            </#list>

                <#else>
                No photos available

            </#if>
                <br><br>

                <input type="file" name="newFile1" /><br>
                <>
                <input type="file" name="newFile2" />
                <><br>
                <input type="file" name="newFile3" /><br><br>

                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Edit Product" />
            </form>
        </div>
        <#else>
        Оголошень немає!
    </#list>
    <br><br>

</#if>

</div>

<#if user.isAdmin()>
<button id="addButton" class="add-button" onclick="showForm()">
    Add Product
</button>
</#if>



<#if user.isAdmin()>

<div class="add-product-window">

<div id="addForm" class="add-product-container">

    <div class="add-product-top-container">

        <div class="add-title">
            Add Product
        </div>

        <div class="close-button-container">
            <button id="close-button" type="button" class="close-button" data-bs-dismiss="toast"
                    aria-label="Close">X</button>
        </div>

    </div>

    <div class="form-add-container">
        <form id="productFormToast" action="/products/create" method="post"
              enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="hidden" name="type" value="SELL" required />
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingTitle" name="title"
                       placeholder="Title..." required>
                <label for="floatingDescription">Title:</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingDescription"
                       name="description" placeholder="Description..." required>
                <label for="floatingDescription">Description:</label>

            </div>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingPrice" name="price"
                       placeholder="Price..." required>
                <label for="floatingPrice">Price:</label>
            </div>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingCity" name="city"
                       placeholder="City..." required>
                <label for="floatingCity">City:</label>
            </div>



            <div class="add-subtitle">Add photos to the product</div>

            <div class="add-files-container">
                <label for="file1" class="file-upload-btn">Select file</label>
                <input type="file" name="file1" id="file1" required>

                <label for="file2" class="file-upload-btn">Select file</label>
                <input type="file" name="file2" id="file2">

                <label for="file3" class="file-upload-btn">Select file</label>
                <input type="file" name="file3" id="file3">
            </div>

            <div class="confirm-adding-container">
                <p id="file-error" style="color: red; display: none;">Please select a file!</p>
                <input class="add-button-confirm" type="submit" onsubmit="submitForm(event)"
                       value="Add">
            </div>

        </form>
    </div>
</div>

</div>

        </#if>


<div class="history-container">
<button class="add-button" onclick="toggleHistory()">Order History
    <img class="dropdown-icon" src="/dropdown-logo.png"></img>
</button>
</div>

<div id="historyTable" style="display: none; margin-top: 20px;">
<table class="table">

    <tbody>
    <#if orders?? && (orders?size> 0)>
    <#list orders as order>
    <tr>
        <th>${order.orderName}</th>
        <th>${order.orderPrice} UAH</th>
        <th>${order.dateOfPurchase}</th>
        <th><a href="/products/${order.productId}">Order Again</th>
        <#else>
        <div style="background-color: white;">
            <h3>No Orders</h3>
        </div>

    </#list>
    <#else>
    <div>No purchases found</div>
    </#if>
</tbody>
</table>
        </div>

        </div>

<div class="profile-card-right-container">
<canvas id="myPieChart" width="100%" height="20"></canvas>

<h4 id="totalSaved"></h4>

<div>Plastic — ${user.plasticSaved} kg</div>
<div>Metal — ${user.metalSaved} kg</div>
<div>Glass — ${user.glassSaved} kg</div>
<div>CO2 — ${user.CO2Saved} kg</div>

</div>

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
        <a href="/#carousel_acb2" data-page-id="65053303">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


<script>
const user = {
    plasticSaved: ${ user.plasticSaved },
    metalSaved: ${ user.metalSaved },
    glassSaved: ${ user.glassSaved },
    CO2Saved: ${ user.CO2Saved }
};

const total = user.plasticSaved + user.metalSaved + user.glassSaved + user.CO2Saved;

document.getElementById('totalSaved').innerHTML = `Total saved: <#noparse>${total.toFixed(2)}</#noparse> kg`;
</script>



<script>
const ctx = document.getElementById('myPieChart').getContext('2d');
const myPieChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: ['Plastic', 'Metal', 'Glass', 'CO2'],
        datasets: [{
            label: 'Saved (kg): ',
            data: [${ user.plasticSaved }, ${ user.metalSaved }, ${ user.glassSaved }, ${ user.CO2Saved }],
            backgroundColor: [
                '#4CAF50',
                '#2196F3',
                '#FFC107',
                '#FF5722'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'bottom'
            },
            title: {
                display: false,
                text: 'Saved materials by you'
            }
        }
    }
});
</script>

<script>
// Показати форму в Toast
function showHistory() {
    const toastElement = document.getElementById('historyToast');
    const toast = new bootstrap.Toast(toastElement);
    toast.show();
}

// Показати форму в Toast
function showForm() {
    const toastElement = document.getElementById('productToast');
    const toast = new bootstrap.Toast(toastElement);
    toast.show();
}

// Обробка відправки форми в Toast
function submitForm(event) {
    event.preventDefault();  // Зупиняємо стандартну відправку форми

    const form = document.getElementById('productFormToast');
    const formData = new FormData(form);

    // Відправка даних форми
    fetch(form.action, {
        method: 'POST',
        body: formData
    })
    toast.hide();  // Сховати Toast

}


</script>

<script>
document.getElementById("addButton").addEventListener("click", function () {
    const addForm = document.getElementById("addForm");
    addForm.classList.toggle("active");
});

document.getElementById("close-button").addEventListener("click", function () {

    const addForm = document.getElementById("addForm");
    addForm.classList.toggle("active");
});


</script>

<script>
const toggleMenu = document.getElementById("toggleMenu");
const menu = document.getElementById("menu");
let hideTimeout;


toggleMenu.addEventListener("click", function () {
    if (menu.classList.contains("active")) {
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
    xhr.onload = function () {
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
    xhr.onerror = function () {
        console.error('Помилка при виконанні запиту');
    };

    // Відправляємо запит
    xhr.send();
}
</script>

<script>
// Дані користувача
<!--const plasticSaved = ${user.plasticSaved};-->
< !--const metalSaved = ${ user.metalSaved }; -->
< !--const glassSaved = ${ user.glassSaved }; -->
< !--const CO2Saved = ${ user.CO2Saved }; -->

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
                            label: function (context) {
                                return `
                        <#noparse>
                        ${context.dataset.label}: ${context.raw}%`;
                        </#noparse >
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
< !--title: {
            -->
< !--display: true, -->
< !--text: 'Відсоток збережених матеріалів'-- >
< !--            } -->
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

        </body>

        </html>