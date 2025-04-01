<!DOCTYPE html>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link rel="stylesheet" href="/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">

    <style>
        .login-with-google-btn {
            transition: background-color .3s, box-shadow .3s;

            padding: 12px 16px 12px 42px;
            border: none;
            border-radius: 3px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 1px rgba(0, 0, 0, .25);

            color: #757575;
            font-size: 14px;
            font-weight: 500;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;

            background-image: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTgiIGhlaWdodD0iMTgiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGcgZmlsbD0ibm9uZSIgZmlsbC1ydWxlPSJldmVub2RkIj48cGF0aCBkPSJNMTcuNiA5LjJsLS4xLTEuOEg5djMuNGg0LjhDMTMuNiAxMiAxMyAxMyAxMiAxMy42djIuMmgzYTguOCA4LjggMCAwIDAgMi42LTYuNnoiIGZpbGw9IiM0Mjg1RjQiIGZpbGwtcnVsZT0ibm9uemVybyIvPjxwYXRoIGQ9Ik05IDE4YzIuNCAwIDQuNS0uOCA2LTIuMmwtMy0yLjJhNS40IDUuNCAwIDAgMS04LTIuOUgxVjEzYTkgOSAwIDAgMCA4IDV6IiBmaWxsPSIjMzRBODUzIiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBkPSJNNCAxMC43YTUuNCA1LjQgMCAwIDEgMC0zLjRWNUgxYTkgOSAwIDAgMCAwIDhsMy0yLjN6IiBmaWxsPSIjRkJCQzA1IiBmaWxsLXJ1bGU9Im5vbnplcm8iLz48cGF0aCBkPSJNOSAzLjZjMS4zIDAgMi41LjQgMy40IDEuM0wxNSAyLjNBOSA5IDAgMCAwIDEgNWwzIDIuNGE1LjQgNS40IDAgMCAxIDUtMy43eiIgZmlsbD0iI0VBNDMzNSIgZmlsbC1ydWxlPSJub256ZXJvIi8+PHBhdGggZD0iTTAgMGgxOHYxOEgweiIvPjwvZz48L3N2Zz4=);
            background-color: white;
            background-repeat: no-repeat;
            background-position: 12px 11px;

            &:hover {
                box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 2px 4px rgba(0, 0, 0, .25);
            }

            &:active {
                background-color: #eeeeee;
            }

            &:focus {
                outline: none;
                box-shadow: 0 -1px 0 rgba(0, 0, 0, .04),
                0 2px 4px rgba(0, 0, 0, .25),
                0 0 0 3px #c8dafc;
            }

            &:disabled {
                filter: grayscale(100%);
                background-color: #ebebeb;
                box-shadow: 0 -1px 0 rgba(0, 0, 0, .04), 0 1px 1px rgba(0, 0, 0, .25);
                cursor: not-allowed;
            }
        }


        body {
            text-align: center;
            padding-top: 2rem;
        }
    </style>
</head>

<body class="body_animated">
<header>
    <a href="/">ReUse Hub</a>
</header>
<div class="body-flex">

    <div class="main-flex">

        <main class="authorization-main">
            <div class="authorization_block">
                <div class="form_title">Sign in</div>
                <div class="authorization-two-sides">
                    <div class="authorization-left-side">
                        <form class="authorization_form" action="/login" method="post" onsubmit="return validatePassword()">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="floatingInput" name="username" placeholder="name@example.com" required>
                                <label for="floatingInput">Email</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="floatingPassword" name="password" placeholder="Password" required minlength="0">
                                <label for="floatingPassword">Password</label>
                            </div>

                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                            <input class="authorization_form_submit" type="submit" value="Log in" />
                            <br/><br/>
                            <span>Don't have an account yet?</span>
                            <a class="registration_link" href="/registration">Sign up</a>
                        </form>
                    </div>
                    <div class="authorization-image-div">
                        <img class="authorization-image" src="authorization_picture.jpg" alt=""></img>
                    </div>

                </div>

                <form action="/oauth2/authorization/google" method="GET">
                    <button type="submit" class="login-with-google-btn">
                        Sign in with Google
                    </button>
                </form>
                <!-- Повідомлення про успішну авторизацію -->
                <#if message_confirmed??>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message_confirmed}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </#if>


            <#if message_already_confirmed??>
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                ${message_already_confirmed}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </#if>

                <!-- Повідомлення про термін дії токену -->
        <#if message_expired??>
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            ${message_expired}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <form action="/registration" method="post">
            <input class="home_button" type="submit" value="Register again" />
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
        </form>
    </#if>

            <!-- Повідомлення про помилки -->
    <#if message??>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</#if>

<#if confirmMessage??>
<div class="confirm-message">${confirmMessage}</div>
</#if>
</div>



<form action="/" method="post">
<input class="skip-button" type="submit" value="Skip" />
<input type="hidden" name="_csrf" value="${_csrf.token}" />
</form>
        </main>
        </div>
</body>
</html>