$(document).ready(function() {
    $('.dropdown-button').dropdown({
        hover: false
    });

    $('#user-signout').on('click', function(event) {
        event.preventDefault();
        $.ajax({
            type: 'DELETE',
            url: '/sess',
            success: function() {
                window.location.href = '/sess';
            },
            error: function() {
                toast('Something Wrong.', 4000);
            }
        });
    });

    $('#user-signin').submit(function(event) {
        event.preventDefault();
        $.ajax({
            type: 'POST',
            url: '/sess',
            data: $(this).serialize(),
            success: function() {
                if (document.referrer != ''){
                    window.location.href = document.referrer;
                } else {
                    window.location.href = '/';
                }
            },
            error: function() {
                toast('Incorrect Account or Password', 4000);
            }
        });
    });

    $('#user-signup').submit(function(event) {
        event.preventDefault();
        $.ajax({
            type: 'POST',
            url: '/users',
            data: $(this).serialize(),
            success: function() {
                window.location.href = '/sess';
            },
            error: function(response) {
                var json = eval('('+response.responseText+')');
                if(json.uid != null) {
                    toast('Account: ' + json.uid, 4000);
                }            
                if(json.nick != null) {
                    toast('Nickname: ' + json.nick, 4000);
                }
                if(json.pwd != null) {
                    toast('Password: ' + json.pwd, 4000);
                }
                if(json.pwdConfirm != null) {
                    toast('Confirm Password: ' + json.pwdConfirm, 4000);
                }
                if(json.mail != null) {
                    toast('Email: ' + json.mail, 4000);
                }
            }
        });
    });
});