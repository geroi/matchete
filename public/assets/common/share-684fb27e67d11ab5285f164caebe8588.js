$(document).ready(function(){
  $('#share_vk').html(VK.Share.button(false,{type: "custom", text: "<span class='glyphicon glyphicon-heart'></span><span> Поделиться</span>"}));
});
// (function(d, s, id) {
//     var js, fjs = d.getElementsByTagName(s)[0];
//     if (d.getElementById(id)) return;
//     js = d.createElement(s); js.id = id;
//     js.src = "//connect.facebook.net/ru_RU/sdk.js#xfbml=1&version=v2.6&appId=1107741202631557"
//     fjs.parentNode.insertBefore(js, fjs);
//   }(document, 'script', 'facebook-jssdk'));
