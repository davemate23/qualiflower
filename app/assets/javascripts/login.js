$.ajaxSetup({
    headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
});


$(document).ready(function() {


    $('#login-modal #new_user')
        .bind('ajax:success', function(evt, data, status, xhr) {
            console.log('success');
            $('#login-model').modal('hide');
            window.location = '/'

        })
        .bind("ajax:error", function(evt, xhr, status, error) {
            console.log(xhr.responseText);
            $("#addError").html("<strong>Error: </strong> "+xhr.responseText);
            $("."+xhr.fieldset).addClass("error");
            $("#addError").fadeIn(300);
            $("."+xhr.fieldset+":first input:first").focus();
        });

    $('#registration-modal .new_user')
        .bind('ajax:success', function(evt, data, status, xhr) {
            //function called on status: 200 (for ex.)
            console.log('success');
            $('#registration-model .new_user').modal('hide');
            window.location = '/'

        })
        .bind("ajax:error", function(evt, xhr, status, error) {
            //function called on status: 401 or 500 (for ex.)
            console.log(xhr.responseText );
            var errors = JSON.parse(xhr.responseText).errors;

            var errors1 ="Errors : <br>";
            $.each( errors, function( key, value ) {
                errors1 += key.substr(0,1).toUpperCase() + key.substr(1)+"   :  "+value+"<br>";

            });
            $("#registration-modal #addError").html(errors1);
            $("."+xhr.fieldset).addClass("error");
            $("#registration-modal #addError").fadeIn(300);
            $("."+xhr.fieldset+":first input:first").focus();
        });


});

