

var logOverlay = document.querySelector('.log-overlay-bg')
var closeWrapper = document.querySelector('.close-wrapper')
var logBtn = document.querySelector('.log-btn')

$(logOverlay).css("display", "flex").hide()

function openLogSubmission() {

    $(logOverlay).fadeIn("slow")
    $(closeWrapper).fadeIn("slow")

}

function closeLogSubmission() {

    $(logOverlay).fadeOut("slow")
    $(closeWrapper).fadeOut("slow")

}

logBtn.addEventListener('click', openLogSubmission)
closeWrapper.addEventListener('click', closeLogSubmission)





