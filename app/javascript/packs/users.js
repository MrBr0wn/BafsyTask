$(document).ready(function() {

    // confirming gender of user
    $("#confirm_gender").click(function () {
        $('#confirm_gender').on('ajax:success', function (event) {
            let detail = event.detail;
            if (detail[1] == "OK") {
                $("#status_gender").html("Пол (подтвержден)");
                $(this).remove();
                console.log("OK");
            } else {
                $("#status_gender").html("Пол (определён автоматически)");
                console.log("Bad");
            }
        });
    });

    // updating gender of user
    $("#update_gender").click(function () {
        $('#update_gender').on('ajax:success', function(event){
            let detail = event.detail;
            let gender = JSON.parse(detail[2].responseText);
            if (detail[1] == "OK") {
                $("#status_gender").html(gender["status"]);
                $("#gender").html(gender["gender"]);
                console.log(gender);
            } else {
                console.log("Error updating.");
            }
        });
    });
});
