<!DOCTYPE HTML>
<head>
    <title>AutoBought</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>

<body>
<h1>AutoBought</h1>
<h4>Товари користувача ${user.name}</h4><br>
    <#list products as product>
    <p>${product.title} ${product.price} USD| <a href="/products/${product.id}">Додатково</a></p>
    <#else><h3>Оголошень немає</h3>

</#list>

    <hr>
    <h3>Детальна інформація про користувача</h3>
    <b>Номер телефона:</b> ${user.phoneNumber}<br>
    <b>Email:</b> ${user.email}<br>
    <hr>

        <center>
            <form action="/" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                <input type="submit" value="На головну"/>
            </form>
        </center>

<#if errorMessage??>
<h2>${errorMessage}</h2>
</#if>

</body>

</html>