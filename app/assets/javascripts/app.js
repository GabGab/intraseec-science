// Add proper content-type to all AJAX requests by default
$.ajaxSetup({
  beforeSend: function(xhr) { xhr.setRequestHeader('Accept', 'text/javascript'); }
});

$(document).ready(function() {

  $('[data-toggle-popup]').click(function(){
    switch ($(this).data('toggle-popup')) {
        case "userDenied":
          toggleUserDeniedPopup();
          break;
        case "requiresFan":
          toggleRequiresFanPopup();
          break;
    }
  });
});

$(document).on('facebook:loaded', function() {
  if ($('.like-button').length > 0) {
    FB.Event.subscribe('edge.create',
      function(href, widget) {
        window.top.location = AppSettings.pageTabUrl;
      }
    );
  }

  handlePermissionsLink();
  computePaintingPadding();
});

function handlePermissionsLink() {
  $("[data-require-login]").click(
    function(event){
      var self = $(this);
      event.preventDefault();
      FB.login(function(response) {
        if (response.authResponse) {
          $('#uid-input').val(response.authResponse.userID);
          $('#expire-input').val(response.authResponse.expiresIn);
          $('#access-token-input').val(response.authResponse.accessToken);
          self.closest('form').submit();
        } else {
          toggleUserDeniedPopup();
        }
      });
    }
  );
}

function toggleUserDeniedPopup() {
  $('#user-denied-popup').toggle();
  $('#user-denied-popup-background').toggle();
}

function toggleRequiresFanPopup() {
  $('#requires-fan-popup').toggle();
  $('#requires-fan-popup-background').toggle();
}

function computePaintingPadding() {
  var formHeight = $('form').outerHeight(true);
  var painting = $('.painting');
  painting.css('padding-bottom', formHeight - (painting.height() - 33));
}