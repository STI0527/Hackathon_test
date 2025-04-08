<!DOCTYPE HTML>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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


<section class="title-text-section">
    <div class="marketplace-title">
        Welcome to the ReUse Hub marketplace! Here you can buy and sell used items to help protect the environment!
    </div>
</section>


<div class="search-container">

    <div class="search-empty-container">

    </div>

    <form class="middle-container" action="/marketplace" method="get"/>

    <input class="search-bar" type="text"  name="title" placeholder="Search...">
        <input class="search-button" type="submit" value=""/>

    </form>


    <button id="addButton" class="add-button" onclick="showForm()">Add product</button>


<div class="search-empty-container">

</div>

</div>

<div class="add-product-window">

    <div id="addForm" class="add-product-container">

        <div class="add-product-top-container">

            <div class="add-title">
                Add product
            </div>

            <div class="close-button-container">
                <button id="close-button" type="button" class="close-button" data-bs-dismiss="toast" aria-label="Close">X</button>
            </div>

        </div>

        <div class="form-add-container">
            <form id="productFormToast" action="/products/create" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="hidden" name="type" value="SELL" required/>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control"  id="floatingTitle" name="title" placeholder="Name..." required>
                    <label for="floatingTitle">Name :</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control"  id="floatingDescription" name="description" placeholder="Description..." required>
                    <label for="floatingDescription">Description:</label>

                </div>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingPrice" name="price" placeholder="Price..." required>
                    <label for="floatingPrice">Price:</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingCity" name="city" placeholder="City..." required>
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
                    <input  class="add-button-confirm" type="submit" onsubmit="submitForm(event)" value="Add">
                </div>

            </form>
        </div>
    </div>

</div>



    <div class="product-section">
        <div class="product_list">
    <#list products as product>

    <div class="product-container">

        <div class="product-title">
            ${product.title}
        </div>

        <a href="/products/${product.id}">
            <div class="product-image-container">

                <img class="product-image" src="/images/${product.images[0].id}"/>
            </div>
        </a>

        <div class="product-price">
            ${product.price} ₴
        </div>
        <div class="product-price">
            ${((product.price / euro_exchange_rate) * 50)?string("0.0")}
            <div class="coins-container">
                <img class="coins-image-card" src="coins_logo.png">
            </div>
        </div>

        <div class="product-description">
            ${product.description}
        </div>

        <div class="buy-button-container">
            <a href="/products/${product.id}">
                <button class="buy-button">
                    BUY
                </button>
            </a>
        </div>


    </div>
    <#else>
    <div class="no-products-container">
        No products
    </div>
</#list>

</div>

        </div>


<hr></hr>


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