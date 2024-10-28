<!DOCTYPE HTML>
<head>
    <title>AutoBought</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>
<body >

<header class="header">
<h1 class="header_title">
    AutoBought
</h1>
</header>
<main class="main">
<table class="admin_table">Інтернет-магазин |


    <form action="/logout" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="submit" value="Вийти з акаунта"/>
    </form>

    <h3 class="table_title">Панель адміністратора</h3>

    <table class="table_admin">
        <tr>
            <th>Email</th>
            <th>Номер телефона</th>
            <th>Активність</th>
            <th>Ролі</th>
            <th>Бан</th>
            <th>Детальна інформація</th>
            <th>Редагувати</th>
        </tr>

        <#list users as user>

        <tr>
            <th>${user.email}</th>
            <th>${user.phoneNumber}</th>
            <th><#if user.isActive()> так
                <#else> ні </#if>
            </th>
            <th><#list user.roles as role>
            ${role}
            </#list></th>
            <th>
                <form action="/admin/user/ban/${user.id}" method="post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}" required/>
                    <input class="ban_button" type="submit" value="Бан"/>
                </form>
            </th>
            <th><a class="admin_link" href="/user/${user.id}">Детально...</a></th>
        <th><a class="admin_link" href="/admin/user/edit/${user.id}">Редагувати</a></th>
        </tr>
        <#else><h3>Користувачів немає</h3>

        </#list>


    </table>

<form action="/" method="post">
<input type="hidden" name="_csrf" value="${_csrf.token}" required/>
<input class="home_button" type="submit" value="На головну"/>
</form>
        </main>
        </body>

        </html>