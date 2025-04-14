<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

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
            <button type="submit" onclick="deleteNotification(event, ${notification.id})" class="delete-notification-button">
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
        Welcome to the ReUse Hub reuse section — explore the map to find nearby drop-off points and give your materials a second chance!
    </div>
</section>

<center>
<#if user.isAdmin()>
<button id="addPlaceButton" class="add-button" onclick="showPlaceAddingForm()">Add Place</button>
</#if>

<div class="dropdown">
    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
        Display mode
    </button>
    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
        <#list oblasts as oblast>
        <li>
            <button class="dropdown-item" onclick="selectModeView('${oblast.getEnglishName()}')">
                ${oblast.getEnglishName()}
            </button>
        </li>
    </#list>
</ul>
</div>



<div class="add-place-window">

    <div id="addPlaceForm" class="add-place-container">

        <div class="add-product-top-container">

            <div class="add-title">
                Add place
            </div>

            <div class="close-button-container">
                <button id="close-button" type="button" class="close-button" data-bs-dismiss="toast" aria-label="Close">X</button>
            </div>

        </div>

        <div class="form-add-container">
            <form id="productFormToast" action="/places/create" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}">

                <div class="form-floating mb-3">
                    <input type="text" class="form-control"  id="floatingTitle" name="title" placeholder="Name..." required>
                    <label for="floatingTitle">Name :</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="number" step="any" class="form-control"  id="floatingLatitude" name="latitude" placeholder="Latitude..." required>
                    <label for="floatingLatitude">Latitude :</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="number" step="any" class="form-control"  id="floatingLongitude" name="longitude" placeholder="Longitude..." required>
                    <label for="floatingLongitude">Longitude :</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control"  id="floatingCity" name="city" placeholder="City..." required>
                    <label for="floatingCity">City :</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control"  id="floatingAddress" name="address" placeholder="Address..." required>
                    <label for="floatingAddress">Address :</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control"  id="floatingDescription" name="description" placeholder="Description..." required>
                    <label for="floatingDescription">Description :</label>
                </div>

                <input type="hidden" name="paper" id="1" value="false">
                <input type="hidden" name="plastic" id="2" value="false">
                <input type="hidden" name="glass" id="3" value="false">
                <input type="hidden" name="metal" id="4" value="false">

                <div class="icon-container">
                    <div class="icon" id="icon1">
                        <img src="/paper1.png" alt="Paper">
                    </div>
                    <div class="icon" id="icon2">
                        <img src="/plastic.png" alt="Plastic">
                    </div>
                    <div class="icon" id="icon3">
                        <img src="/glass1.png" alt="Glass">
                    </div>
                    <div class="icon" id="icon4">
                        <img src="/metal1.png" alt="Metal">
                    </div>
                </div>


                <div class="add-subtitle">Add photos to the place</div>

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
                    <input  class="add-button-confirm" type="submit" onsubmit="submitForm(event)" value="Add">
                </div>

            </form>
        </div>
    </div>

</div>
</center>

<div class="map">
<div id="map"></div>
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
        <a class="footer-link" href="/">ReUse Hub &#xa9; 2025</a>
    </div>
    <div class="empty-container">

    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


<script>
const allMarkers = [];
 const map = L.map('map', {zoomControl: false}).setView([49.0, 31.0], 6); // Центр України

 L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
     attribution: '&copy; Carto & OpenStreetMap',
     subdomains: 'abcd',
     maxZoom: 20
 }).addTo(map);

 // Тестовий маркер для перевірки
 L.marker([50.4501, 30.5234]).addTo(map).bindPopup("<b>Kyiv</b>");

 <#if places??>
     <#list places as place>
     <#assign latitude = place.latitude?string?replace(",", ".") />
     <#assign longitude = place.longitude?string?replace(",", ".") />

     var popupContent = "<b>${place.name}</b><br>${place.description}<br><b>City:</b> ${place.city}<br><b>Address:</b> ${place.address}<br><b>Recycling Materials:</b><br>";
<#if place.paper == true>
     popupContent += '<img src="/paper1.png" alt="Paper" class="tooltip-icon selected" title="Paper (Recyclable)"> ';
 <#else>
     popupContent += '<img src="/paper1.png" alt="Paper" class="tooltip-icon" title="Paper (Not Recyclable)"> ';
 </#if>

 <#if place.plastic == true>
     popupContent += '<img src="/plastic.png" alt="Plastic" class="tooltip-icon selected" title="Plastic (Recyclable)"> ';
 <#else>
     popupContent += '<img src="/plastic.png" alt="Plastic" class="tooltip-icon" title="Plastic (Not Recyclable)"> ';
 </#if>

 <#if place.glass == true>
     popupContent += '<img src="/glass1.png" alt="Glass" class="tooltip-icon selected" title="Glass (Recyclable)"> ';
 <#else>
     popupContent += '<img src="/glass1.png" alt="Glass" class="tooltip-icon" title="Glass (Not Recyclable)"> ';
 </#if>

 <#if place.metal == true>
     popupContent += '<img src="/metal1.png" alt="Metal" class="tooltip-icon selected" title="Metal (Recyclable)"> ';
 <#else>
     popupContent += '<img src="/metal1.png" alt="Metal" class="tooltip-icon" title="Metal (Not Recyclable)"> ';
 </#if>

var marker = L.marker([${latitude}, ${longitude}]).addTo(map);
marker.bindPopup(popupContent);
console.log(popupContent);
allMarkers.push(marker);

     </#list>
 </#if>


function selectModeView(oblastName) {

event.preventDefault();

// Оновлюємо текст кнопки
document.getElementById('dropdownMenuButton').textContent = oblastName;
     console.log("Selected mode:", oblastName);
     updateMapDisplayMode(oblastName);
 }
 const oblastCoordinates = {
    "Cherkasy Oblast": [49.4444, 32.0590],
    "Chernihiv Oblast": [51.9794, 31.8697],
    "Chernivtsi Oblast": [48.2972, 25.9352],
    "Dnipropetrovsk Oblast": [48.4647, 35.0462],
    "Donetsk Oblast": [48.0159, 37.8028],
    "Ivano-Frankivsk Oblast": [48.9220, 24.7105],
    "Kharkiv Oblast": [49.9935, 36.2304],
    "Kherson Oblast": [46.6356, 32.6167],
    "Khmelnytskyi Oblast": [49.4191, 27.0290],
    "Kirovohrad Oblast": [48.5074, 32.2597],
    "Kyiv Oblast": [50.4501, 30.5234],
    "Luhansk Oblast": [48.5678, 39.2986],
    "Lviv Oblast": [49.8397, 24.0297],
    "Mykolaiv Oblast": [46.9750, 32.0010],
    "Odesa Oblast": [46.4825, 30.7343],
    "Poltava Oblast": [49.5893, 34.5517],
    "Rivne Oblast": [50.6194, 26.2516],
    "Sumy Oblast": [50.9077, 34.7986],
    "Ternopil Oblast": [49.5531, 25.5948],
    "Vinnytsia Oblast": [49.2331, 28.4680],
    "Volyn Oblast": [50.7385, 25.3943],
    "Zakarpattia Oblast": [48.5792, 22.3133],
    "Zaporizhzhia Oblast": [47.8388, 35.1396],
    "Zhytomyr Oblast": [50.4500, 28.1132],
    "Crimea": [44.9522, 34.1025],
    "Kyiv": [50.4501, 30.5234]
};
// Фільтруємо точки на мапі за областю
 function updateMapDisplayMode(oblastName) {
     // Центруємо карту залежно від вибраної області
    if (oblastName === "Kyiv") {
        map.setView([50.4501, 30.5234], 12);
    }else if (oblastCoordinates[oblastName]) {
        map.setView(oblastCoordinates[oblastName], 8); // Центр на вибрану область
    } else {
        map.setView([49.0, 31.0], 6); // Центр України (за замовчуванням)
    }
 }
</script>

</body>
</html>

<script>


const addPlaceButton = document.getElementById("addPlaceButton");
if (addPlaceButton) {
    addPlaceButton.addEventListener("click", function () {
        const addPlaceForm = document.getElementById("addPlaceForm");
        addPlaceForm.classList.toggle("active");
    });
}

const closeButton = document.getElementById("close-button");
if (closeButton) {
    closeButton.addEventListener("click", function () {
        const addPlaceForm = document.getElementById("addPlaceForm");
        addPlaceForm.classList.toggle("active");
    });
}

const icons = document.querySelectorAll('.icon');

icons.forEach(icon => {
    icon.addEventListener('click', function() {
        const iconId = icon.id; // Наприклад, "icon1"
        const input = document.getElementById(iconId.replace('icon', '').toLowerCase()); // Отримуємо правильне приховане поле

        // Якщо іконка вибрана, змінюємо значення на true і додаємо клас 'selected'
        if (icon.classList.contains('selected')) {
            icon.classList.remove('selected');
            input.value = 'false'; // Встановлюємо значення на false
        } else {
            icon.classList.add('selected');
            input.value = 'true'; // Встановлюємо значення на true
        }
    });
});
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
