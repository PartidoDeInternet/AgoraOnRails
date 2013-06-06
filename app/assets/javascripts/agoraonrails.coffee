jQuery ->
  $('.agoraonrails-account-link').on 'click', ->
    $('#social-network-account').hide();
    $('#forgot-password').hide();
    $('#agoraonrails-account').show();
  $('.social-network-account-link').on 'click', ->
    $('#agoraonrails-account').hide();
    $('#forgot-password').hide();
    $('#social-network-account').show();
  $('.forgot-password-link').on 'click', ->
    $('#agoraonrails-account').hide();
    $('#social-network-account').hide();
    $('#forgot-password').show();
