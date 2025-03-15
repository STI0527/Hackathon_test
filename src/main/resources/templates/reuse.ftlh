<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Maps Chart</title>
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
<h2>Google Maps with Chart API</h2>
<div id="chart_div" style="width: 800px; height: 500px;"></div>
</body>
</html>
