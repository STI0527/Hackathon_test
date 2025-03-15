<!DOCTYPE html>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>

<body class="body_animated">
<header class="header">
        <h1 class="header_title">Hackathon</h1>
</header>
<main class="main">
    <div class="authorization_block">
        <h4 class="form_title">Авторизація</h4>

        <form class="authorization_form" action="/login" method="post">
            <input type="email" name="username" placeholder="Електронна пошта" required/>
            <input type="password" name="password" placeholder="Пароль" required/>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input class="authorization_form_submit" type="submit" value="Вхід"/>
        </form>
    </div>
    <a class="registration_link" href="/registration">Зареєструватися</a>


    <form action="/" method="post">
        <input class="home_button" type="submit" value="Пропустити"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    </form>

</main>
</body>
</html>