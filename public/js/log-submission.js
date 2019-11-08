
logoWrapper = document.querySelector('.header__nav-img-wrapper')
logoHover = document.querySelector('.logo-hover')
logoStatic = document.querySelector('.logo-static')

$(logoWrapper).mouseenter(function() {
    $(logoStatic).animate({opacity: 0}, 100)
    $(logoHover).animate({opacity: 1}, 100)
})

$(logoWrapper).mouseleave(function() {
    $(logoStatic).animate({opacity: 1}, 100)
    $(logoHover).animate({opacity: 0}, 100)
})



function bgMove() {
    $(window).mousemove(function(event) {
        $('.backdrop').animate({
            'left': (event.pageX * 10/$( window ).width() * 3 + 30 + '%')
        }, 0);
        return $('.backdrop').animate({
            'top': (event.pageY * 10/$( window ).height() * 3 + 30 + '%')
        }, 0);
    });

}
bgMove()


var logOverlay = document.querySelector('.log-overlay-bg')
var closeWrapper = document.querySelector('.close-wrapper')
var logBtn = document.querySelector('.log-btn')
var body = document.querySelector('body')
var deleteConfirm = document.querySelector('.delete-confirm')
var logs = document.querySelector('.logs')

$(deleteConfirm).css("display", "inline").hide()
$(logOverlay).css("display", "flex").hide()

function openLogSubmission() {

    $(logOverlay).fadeIn("slow")
    $(body).addClass('overflow-hidden')
    $(logs).addClass('opacity-01')
    $(closeWrapper).fadeIn("slow")

}

function closeLogSubmission() {

    $(logOverlay).fadeOut("slow")
    $(body).removeClass('overflow-hidden')
    $(logs).removeClass('opacity-01')
    $(closeWrapper).fadeOut("slow")

}

logBtn.addEventListener('click', openLogSubmission)
closeWrapper.addEventListener('click', closeLogSubmission)





