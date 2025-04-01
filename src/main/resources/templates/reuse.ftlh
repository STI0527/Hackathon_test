<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Maps Chart</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
        google.charts.load('current', {
            packages: ['map'],
            mapsApiKey: 'AIzaSyCSqwdmdwdSvp2EwsAvmP9wbhsXkbAAjt0'
        });

        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
                ['Lat', 'Long', 'Name'],
                [50.4501, 30.5234, 'Kyiv, Ukraine'],
                [48.8566, 2.3522, 'Paris, France'],
                [40.7128, -74.0060, 'New York, USA']
            ]);

            var options = {
                showTooltip: true,
                showInfoWindow: true
            };

            var map = new google.visualization.Map(document.getElementById('chart_div'));
            map.draw(data, options);
        }
    </script>
</head>
<body>
<div id="menu" class="user-menu-container">
    <div class="user-menu-inner">
        <#if user.email??>

        <img class="user-avatar" src="/avatars/${user.avatar.id}" alt="avatar">

            <div class="user_menu-name">${user.name}</div>

            <form action="/profile/${user.id}" method="post">
                <input class="user-menu-private-page-text" type="submit" name="profile" value="Profile"/>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            </form>


            <#if user.isAdmin()>
            <a class="user-menu-admin-link" href="/admin">Administration Panel</a>
        </#if>


        <form action="/logout" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input class="user-menu-quit-text" type="submit" value="Log out"/>
        </form>
        <#else>
        <img class="user-avatar" src="/default_avatar.png" alt="avatar">
            <a class="burger_menu_authorize burger_btn-base" href="/login">Sign in</h3></a>
    </#if>

</div>
</div>

<h2>Мапа точок переробки матеріалів</h2>
<div id="chart_div" style="width: 800px; height: 500px;"></div>

<footer>
    <div class="empty-container">

    </div>
    <div class="footer-container">
        <div class="footer-element">
            <a href="/main">
                Home
            </a>
        </div>
        <div class="footer-element">
            <a href="/#carousel_0b16" data-page-id="65053303">
                Contacts
            </a>
        </div>

        <div class="footer-element">
            <a href="/#carousel_840a" data-page-id="65053303">
                Reviews
            </a>
        </div>
        <div class="footer-element">
            <a  href="/#carousel_acb2" data-page-id="65053303">
                Feedback
            </a>
        </div>
    </div>
    <div class="footer-bottom-element">
        <a class="footer-link" href="/">ReUse Hub &#xa9 2025</a>
    </div>
    <div class="empty-container">

    </div>
</footer>

</body>
</html>
