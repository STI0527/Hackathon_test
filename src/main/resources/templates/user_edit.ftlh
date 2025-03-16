<!DOCTYPE html>
<html>
<head>
    <title>Hackathon Test</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
</head>

<body>
<header>
    <a href="/work">ReUse Hub</a>
</header>

<div class="user-edit-wrapper">

    <div class="user-edit-container">
        <div class="user-edit_title">Редагувати профіль ${user.name}</div>

        <div class="edit_block">

            <form action="/admin/user/edit" method="post">

                <#list roles as role>
                <input type="radio" class="btn-check" name="role" id="${role}" value="${role}"
                ${user.roles?seq_contains(role)?string("checked", "")} autocomplete="off">
                <#if role == "admin">
                <label class="btn-role" for="${role}"
                       style="background-color: rgb(235, 154, 169); color: white;
                padding: 12px 25px;
                border: 1px solid rgb(245, 170, 175);
                border-radius: 12px;
                transition: background-color 0.3s ease, color 0.3s ease;
                  ">
                    ${role}
                </label>
                <#else>
                <label class="btn-role" for="${role}"
                       style="background-color: white; color: black;
                padding: 12px 25px;
                border: 1px solid rgb(245, 170, 175);
                border-radius: 12px;
                transition: background-color 0.3s ease, color 0.3s ease;
                ">
                    ${role}
                </label>
            </#if>

        </#list>


    </div>


    <input type="hidden" name="userId" value="${user.id}"/>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <button class="save-button" onclick="location.href='/product_info'">Зберегти</button>

</form>
</div>
</div>
</body>
        </html>