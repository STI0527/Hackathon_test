<!DOCTYPE html>
<html>
<head>
    <title>SHOP</title>
    <link rel="stylesheet" href="/style.css">
</head>

<body>
<header class="header">
        <h1 class="header_title">SHOP</h1>
</header>

<main class="main">
        <div class="registration_block">
            <h4 class="form_title">Реєстрація</h4>

            <form class="registration_form" action="/registration" method="post" enctype="multipart/form-data">
                <input class="registration_form_name" type="text" name="name" placeholder="Ім'я користувача" required/>
                <input class="registration_form_email" type="email" name="email" placeholder="Електронна пошта"
                       required/>
                <input class="registration_form_password" type="password" name="password" placeholder="Пароль"
                       required/>
                <input class="registration_form_number" type="text" name="phoneNumber" placeholder="Номер телефона"
                       required/>
                <input class="registration_form_avatar" type="file" name="fileAvatar"
                       required/>
                <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                <input class="registration_form_submit" type="submit" value="Зареєструватися"/>
            </form>

            <#if errorMessage??>
            <h2 class="error_message">${errorMessage}</h2>
        </#if>
</div>

<form action="/" method="post">
    <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
    <input class="home_button" type="submit" value="На головну"/>
</form>
</main>

</body>
        </html>