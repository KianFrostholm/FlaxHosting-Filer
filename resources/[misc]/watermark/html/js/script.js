var playerCount = 0;
var playerId = 0;

$(document).ready(function () {
    window.addEventListener('message', function (event) {
        if (event.data.action == 'blindopen') {
            $('#blindfold').show();
        } else if (event.data.action == 'blindclose') {
            $('#blindfold').hide();
        } else if (event.data.action == 'open') {
            var type = event.data.type;
            var userData = event.data.array['user'][0];
            var licenseData = event.data.array['licenses'];
            var sex = userData.sex;

            if (type == 'driver' || type == null) {
                $('img').show();
                $('#name').css('color', '#282828');

                if (sex.toLowerCase() == 'mand' || sex.toLowerCase() == 'm') {
                    $('#id-card').children('img').attr('src', 'assets/images/male.png');
                    $('#sex').text('mand');
                } else if (sex.toLowerCase() == 'andet') {
                    $('#id-card').children('img').attr('src', 'assets/images/andet.png');
                    $('#sex').text('andet');
                } else {
                    $('#id-card').children('img').attr('src', 'assets/images/female.png');
                    $('#sex').text('kvinde');
                }

                $('#name').text(userData.firstname + ' ' + userData.lastname);
                $('#dob').text(userData.dateofbirth);
                $('#height').text(userData.height);
                $('#signature').text(userData.firstname + ' ' + userData.lastname);
				$('#licenses').html('');
                if (licenseData != null) {
                    Object.keys(licenseData).forEach(function (key) {
                        var type = licenseData[key].type;

                        if (type == 'drive_bike') {
                            type = 'motorcykel';
                        } else if (type == 'drive_truck') {
                            type = 'lastbil';
                        } else if (type == 'drive') {
                            type = 'bil';
                        }

                        if (type == 'motorcykel' || type == 'lastbil' || type == 'bil') {
                            $('#licenses').append('<p>' + type + '</p>');
                        }
                    });
                }

                $('#id-card').css('background', 'url(assets/images/license.png)');
            }
            $('#id-card').show();
        } else if (event.data.action == 'setPlayerId') {
            playerId = event.data.id;
        } else if (event.data.action == 'setPlayerCount') {
            playerCount = event.data.count;
        } else if (event.data.action == 'close') {
            $('#name').text('');
            $('#dob').text('');
            $('#height').text('');
            $('#signature').text('');
            $('#sex').text('');
            $('#id-card').hide();
            $('#licenses').html('');
        }
    });
});

$(function() {
    moment.locale('da-DK');
    function iniciarHorario() {
      document.getElementById('horario').innerHTML = "<h3>" + moment().format(`DD/MM/YYYY HH:mm:ss`) +  "</h3>";
      document.getElementById('players').innerHTML = "<h3>" + playerCount +  " i Byen";
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
  
