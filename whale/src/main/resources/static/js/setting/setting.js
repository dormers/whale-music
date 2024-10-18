// 리사이즈
$(document).ready(() => {resize();});
$(window).resize(() => {resize();});
function resize() {
	var windowHeight = $(window).height();
	$('.setting-body').css({'height': (windowHeight-1)+'px'});
};