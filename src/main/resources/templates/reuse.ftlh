<html>
<head>
    <title>Document</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
        google.charts.load("current,{
        "packages":["map"],
        "mapsApiKey": "AIzaSyCSqwdmdwdSvp2EwsAvmP9wbhsXkbAAjt0"});
        google.charts.setOnLoadCallback(drawChart);

        function drawCart(){
            var data = google.visualization.arrayToDataTable([

            ]);
            var options = {
            showTooltip = true,
            showInfoWindow = true
            };
            var map = new google.visualization.Map(document.getElementById('chart_div'));

            map.draw(data, options);
        };
    </script>
</head>
<body>

</body>
</html>