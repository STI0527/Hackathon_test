<!DOCTYPE HTML>
<html>
<head>
    <title>SHOP</title>
    <link rel="stylesheet" href="/style.css">
</head>

<body>
<h1>SHOP</h1>
<h4>Детальна інформація про товар</h4>
<!--<img src="/images/${product.images[0]?if_exists}" height="60px"/><br><br>-->
<!--<img src="/images/${product.images[1]?if_exists}" height="60px"/><br><br>-->
<!--<img src="/images/${product.images[2]?if_exists}" height="60px"/><br><br>-->

<#list images as img>
    <img src="/images/${img.id}" height="60px"/><br><br>
</#list>


<b>Назва товару:</b> ${product.title}<br>
<b>Ціна:</b> ${product.price} $<br>
<b>Опис:</b> ${product.description}<br>
<b>Місто:</b> ${product.city}<br>
<b>Автор:</b> <a href="/user/${product.user.id}">${product.user.name}</a><br>
<!--<b>Номер телефона:</b>${product.user.phoneNumber}<br>-->
<hr>
<!--<form action = "/products/delete/${product.id}" method = "post">-->
<!--<input type = "submit" value = "Видалити товар"/>-->
<!--</form>-->
<br>
<br>
        <center>
        <form action="/" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
            <input type="submit" value="На головну"/>
        </form>
        </center>
</body>

</html>