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


    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <style>
        #map {
    width: 80vw;
    height: 80vh;
    border: 2px solid #333;
    border-radius: 16px;
  }
        .map{
            display: flex;
            justify-content: center;
    align-items: center;
        }
        #menu{
            z-index: 999;
        }

    </style>
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

<section class="title-text-section">
    <div class="marketplace-title">
        Welcome to the ReUse Hub reuse section — explore the map to find nearby drop-off points and give your materials a second chance!
    </div>
</section>

<center>
<#if user.isAdmin()>
<button id="addPlaceButton" class="add-button" onclick="showPlaceAddingForm()">Add Place</button>
</#if>



<div class="add-place-window">

    <div id="addPlaceForm" class="add-product-container">

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


                <div class="confirm-adding-container">
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

<script>
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
                console.log('Invalid [${latitude}, ${longitude}] "<b>${place.name}</b>"');
                L.marker([${latitude}, ${longitude}]).addTo(map)
                    .bindPopup("<b>${place.name}</b>");
        </#list>
    </#if>
</script>

</body>
</html>

<script>
document.getElementById("toggleMenu").addEventListener("click", function () {
    const menu = document.getElementById("menu");
    menu.classList.toggle("active");
});

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
</script>

