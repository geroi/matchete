$(document).ready(function(){
	
	console.log('show');
	
	$('#share').html(VK.Share.button(false,{type: "custom", text: "<img src=\"http://vk.com/images/share_32_eng.png\" width=\"32\" height=\"32\" />", eng: 1}));
	$('#share').html(document.write(VK.Share.button(false,{type: "custom", text: "<img src=\"http://vk.com/images/share_32_eng.png\" width=\"32\" height=\"32\" />", eng: 1})));
	document.write(VK.Share.button(false,{type: "custom", text: "<img src=\"http://vk.com/images/share_32_eng.png\" width=\"32\" height=\"32\" />", eng: 1}));

});
