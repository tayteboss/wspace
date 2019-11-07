

var deleteUser = document.querySelector('.delete-user');
var deleteUserConfirm = document.querySelector('.delete-confirm');

function deleteStep() {

    $(deleteUser).fadeOut("fast");
    $(deleteUserConfirm).delay(200).fadeIn("slow");

}

deleteUser.addEventListener('click', deleteStep);





