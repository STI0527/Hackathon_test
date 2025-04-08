<!DOCTYPE HTML>
<html>
<head>
    <title>ReUse Hub</title>
    <link rel="stylesheet" href="/style.css">
    <link rel="icon" type="image/png" href="/icon.png">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.1">
</head>

<body>



<div class="body-flex">



    <form action="/api/ai/ask" method="post">
        <input type="text" name="question" placeholder="Ask something...">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
         <button>Send a question</button>
    </form>




    <#if ai_response??>
    <div>${ai_response}</div>
    <#else>
    <div style="background-color: white;">No data about the response of an AI</div>
</#if>





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


<script>
document.getElementById("toggleMenu").addEventListener("click", function () {
    const menu = document.getElementById("menu");
    menu.classList.toggle("active");
});

</script>
