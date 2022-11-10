var playerCount = 0;
var playerId = 0;

$(document).ready(function () {
    window.addEventListener('message', function (event) {
 if (event.data.action == 'setPlayerId') {
            playerId = event.data.id;
        } else if (event.data.action == 'setPlayerCount') {
            playerCount = event.data.count;
        }
    });
});

$(function() {
    moment.locale('da-DK');
    function iniciarHorario() {
      document.getElementById('horario').innerHTML = "<h3>" + moment().format(`DD/MM/YYYY HH:mm:ss`) +  "</h3>";
      document.getElementById('players').innerHTML = "<h3>" + playerCount +  " i Byen - Dit ID: " + playerId + "</h3>";
      t = setTimeout(function() {
        iniciarHorario()
      }, 500);
    }
    iniciarHorario();
});

var slideIndex = 0;
showSlides();

function showSlides() {
    var i;
    var slides = document.getElementsByClassName("logo");

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex > slides.length) {
        slideIndex = 1
    }
    
    slides[slideIndex-1].style.display = "block";  
    //setTimeout(showSlides, 30000); // Change image every 30 seconds
}
  
