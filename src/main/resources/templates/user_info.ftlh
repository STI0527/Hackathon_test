<!DOCTYPE HTML>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
</head>

<body>
<header>
    <a href="/">ReUse Hub</a>
</header>

<div class="body-flex">

    <main class="main-flex">

        <div class="user-info-container">
            <#if user.isAdmin()>
            <div class="user-info-title">Пропозиції адміністратора ${user.name}</div>


            <div class="user-info-list">


                <#list products as product>
                <div class="user-info-product-container">

                    <a href="/products/${product.id}">
                        <div class="user-info-product-title"> ${product.title}</div>

                    </a><div class="user-info-product-price"><span class="user-info-span"> — </span> ${product.price} &#8372;
                </div>
                </div>

            </#list>

        </div>
    </#if>

    <#if viewer.isAdmin()>
    <div class="user-info-additional-container">
        <div class="user-info-admin-title">Детальна інформація про користувача (тільки для адміністраторів)</div>
        <div class="user-info-admin-number">Номер телефона: <span class="user-info-admin-number-span">${user.phoneNumber}</span> </div>
        <div class="user-info-admin-email">Email: <span class="user-info-admin-email-span">${user.email}</span></div>
    </div>
</#if>



<#if errorMessage??>
<h2>${errorMessage}</h2>
</#if>

        </div>

        </main>
</body>

</html>