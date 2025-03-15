<!DOCTYPE html>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
</head>

<body>
<header class="header">
    <h1 class="header_title">
        Hackathon
    </h1>
</header>

<main class="main">
<h4 class="table_title">Редагувати профіль користувача ${user.name}</h4>

    <div class="edit_block">

<form action="/admin/user/edit" method="post">

    <#list roles as role>
            <input type="radio" name="role" value="${role}" ${user.roles?seq_contains(role)?string("checked", "")}/> ${role}<hr><br><br>
    </#list>


</div>


    <input type="hidden" name="userId" value="${user.id}"/>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <input class="home_button" type="submit" value="Зберегти"/>

</form>
</main>
</body>
        </html>