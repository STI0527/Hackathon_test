let burgerBtn = document.querySelector(".burger_menu-btn");
let burgerMenu = document.querySelector(".burger_menu");

burgerBtn.addEventListener('click', ()=>{
    burgerBtn.classList.toggle("burger_image-close");
    burgerMenu.classList.toggle("burger_menu-open");
})