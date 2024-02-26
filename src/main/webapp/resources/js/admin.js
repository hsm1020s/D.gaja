window.onload = function () {
    var menuItems = document.getElementsByClassName("hasChild");
    for (var i = 0; i < menuItems.length; i++) {
        (function () {
            var menuItem = menuItems[i].getElementsByTagName("a")[0];
            var submenu = menuItem.nextElementSibling;
            menuItem.addEventListener("click", function (event) {
                event.preventDefault();
                event.stopPropagation();
                if (submenu.style.display === "" || submenu.style.display === "none") {
                    submenu.style.display = "block";
                } else {
                    submenu.style.display = "none";
                }
            });
        })();  // 클로저를 즉시 실행
    }
}
