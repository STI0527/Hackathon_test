let burgerBtn = document.querySelector(".burger_menu-btn");
let burgerMenu = document.querySelector(".burger_menu");

burgerBtn.addEventListener('click', ()=>{
    burgerBtn.classList.toggle("burger_image-close");
    burgerMenu.classList.toggle("burger_menu-open");



})

function toggleForm() {
        const form = document.getElementById("productForm");
        form.style.display = (form.style.display === "none" || form.style.display === "") ? "block" : "none";
    }


