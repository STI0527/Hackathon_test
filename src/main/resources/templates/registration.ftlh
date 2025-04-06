<!DOCTYPE html>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
</head>

<body>
<header>
    <a href="/">ReUse Hub</a>
</header>

<div class="body-flex">

    <div class="main-flex">

        <main class="registration-main">
        <div class="registration_block">
            <h4 class="form-title">Registration</h4>

            <form class="registration_form needs-validation" action="/registration" method="post" enctype="multipart/form-data" novalidate>
                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingInputGroup1" name="name" placeholder="Username" required>
                    <label for="floatingInputGroup1">Username</label>
                    <div class="invalid-feedback">
                        Please enter your username.
                    </div>
                </div>

                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="floatingInput" name="email" placeholder="name@example.com" required>
                    <label for="floatingInput">Email address</label>
                    <div class="invalid-feedback">
                        Please enter a valid email address.
                    </div>
                </div>

                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required minlength="8">
                    <label for="floatingPassword">Password</label>
                    <div class="invalid-feedback">
                        The password must be at least 8 characters long.
                    </div>
                </div>

                <div class="form-floating mb-3">
                    <input type="text" class="form-control" id="floatingTextarea2" name="phoneNumber" placeholder="Phone number" required>
                    <label for="floatingTextarea2">Phone number</label>
                    <div class="invalid-feedback">
                        Please enter a valid phone number.
                    </div>
                </div>

                <div class="mb-3">
                    <label for="fileAvatar" class="file-upload-btn">Select an avatar</label>
                    <input type="file" name="fileAvatar" id="fileAvatar" required />
                    <div class="invalid-feedback">
                        Please upload a photo.
                    </div>
                </div>


                <hr><br><br>

                <input type="hidden" name="plasticSaved" value="0">
                <input type="hidden" name="metalSaved" value="0">
                <input type="hidden" name="glassSaved" value="0">
                <input type="hidden" name="CO2Saved" value="0">
                    <input type="hidden" name="coins" value="100">
                <input type="hidden" name="_csrf" value="${_csrf.token}" required />
                <input class="registration_form_submit" type="submit" value="Sign up" />
            </form>



            <#if errorMessage??>
            <h2 class="error_message">${errorMessage}</h2>
        </#if>
    </div>

</main>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Валідація форми за допомогою Bootstrap
    (function () {
        'use strict';

        // Отримати всі форми, що потребують валідації
        var forms = document.querySelectorAll('.needs-validation');

        // Додати обробник події submit
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
    })();
</script>
</div>

</div>

</body>
        </html>