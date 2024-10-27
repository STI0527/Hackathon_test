<!DOCTYPE HTML>
<html>
<head>
    <title>AutoBought</title>
    <link rel="stylesheet" href="/style.css">
</head>

<body>
<header class="header">
    <h1 class="header_title">AutoBought</h1>
    <link rel="icon" type="image/png" href="/icon.png">
</header>
<center>
<h1>Особистий кабінет</h1>


    <h2>${user.name}</h2>

            <#if user.avatar??>
    <img src="/avatars/${user.avatar.id}" alt="Фото профіля" width="230px" height="216px"/>
    <#else >
    <img src="/default_avatar.png" alt="Фото профіля"/>
    </#if>

<form action="/changeAvatar/${user.id}" method="post" enctype="multipart/form-data">
    <input id="file-upload" type="file" name="file"/>
    <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
    <input type="submit" value="Змінити фотографію"/>
</form>

        <br><br>
    Електронна пошта: ${user.email}<br>
    Телефон: ${user.phoneNumber}<br><br>

    <h3>Мої оголошення</h3>

    <#list products as product>
        <p>${product.title} ${product.price} USD| <a href="/products/${product.id}">Додатково</a></p>
        <#else>
        Оголошень немає!
    </#list>

    <br><br>
     <hr>
    <center>
        <form action="/logout" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
            <input type="submit" value="Вийти з акаунта"/>
        </form>
    </center>
    <hr>
    <center>
        <h3>Створити новий товар</h3>
        <form action="/products/create" method="post" enctype="multipart/form-data">
            Назва товару: <input type="text" name="title" placeholder="..." required><br><br>
            Опис: <input type="text" name="description" placeholder="..." style="width: 200px; height: 50px;"
                         required><br><br>
            Ціна: <input type="number" name="price" step="100" min="0" placeholder="..." required><br><br>
            Місто: <input type="text" name="city" placeholder="..." required><br><br>
            Додайте фотографії до оголошення<br><br>
            <input type="file" name="file1"/><br><br>
            <input type="file" name="file2"/><br><br>
            <input type="file" name="file3"/><br><br>

            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <input type="submit" value="Додати товар"/>
        </form>
    </center>


<hr>
    <center>
        <form action="/" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
            <input type="submit" value="На головну"/>
        </form>
    </center>



</center>


</body>
        </html>