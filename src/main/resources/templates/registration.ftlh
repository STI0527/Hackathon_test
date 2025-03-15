<!DOCTYPE html>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>

<body class="body_animated">
<header class="header">
        <h1 class="header_title">Hackathon</h1>
</header>

<main class="main">
    <div class="registration_block">
        <h4 class="form-title">Реєстрація</h4>

        <form class="registration_form needs-validation" action="/registration" method="post" enctype="multipart/form-data" novalidate>
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingInputGroup1" name="name" placeholder="Username" required>
                <label for="floatingInputGroup1">Ім'я користувача</label>
                <div class="invalid-feedback">
                    Будь ласка, введіть ім'я користувача.
                </div>
            </div>

            <div class="form-floating mb-3">
                <input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com" required>
                <label for="floatingInput">Електронна адреса</label>
                <div class="invalid-feedback">
                    Будь ласка, введіть правильну електронну адресу.
                </div>
            </div>

            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required minlength="8">
                <label for="floatingPassword">Пароль</label>
                <div class="invalid-feedback">
                    Пароль повинен бути не менше 8 символів.
                </div>
            </div>

            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingTextarea2" name="phoneNumber" placeholder="Phone number" required>
                <label for="floatingTextarea2">Номер телефону</label>
                <div class="invalid-feedback">
                    Будь ласка, введіть правильний номер телефону.
                </div>
            </div>

            <div class="mb-3">
                <label for="fileAvatar" class="file-upload-btn">Виберіть аватар</label>
                <input type="file" name="fileAvatar" id="fileAvatar" required />
                <div class="invalid-feedback">
                    Будь ласка, завантажте фото.
                </div>
            </div>


            <h4>Виберіть спосіб активації акаунта</h4>

            <div class="btn-group" role="group">

            </div>

            <hr><br><br>



            <input type="hidden" name="_csrf" value="${_csrf.token}" required />
            <input class="registration_form_submit" type="submit" value="Зареєструватися" />
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