$(function() {
  window.fbAsyncInit = function() {
    FB.init({
      appId      : AppSettings.appId,
      channelURL : AppSettings.channelUrl,
      status     : true,
      cookie     : true,
      xfbml      : true
    });

    $(document).trigger('facebook:loaded');
  };

  // Load the SDK Asynchronously
  (function(d){
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/fr_FR/all.js";
    ref.parentNode.insertBefore(js, ref);
  }(document));
});
