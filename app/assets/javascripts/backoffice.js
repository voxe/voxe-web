//= require jquery
//= require jquery_ujs
//= require select2
//= require bootstrap-carousel
//= require bootstrap-transition
//= require jquery.simplyCountable
//= require_tree ./backoffice/propositions
//= require_tree ./backoffice/lib
//= require_tree ./backoffice

$(window).ready(function(){

	pullPictureProfile();

    $("#candidacy_candidate_profile_picture").change(function() {
        $('#picture-profile').addClass('hide');
        $('#picture-changed').removeClass('hide');
    });
});

$(window).resize(function(){

	pullPictureProfile();

});

function pullPictureProfile() {
	var size = $(window).width();

	if (size < 992) {
		$('.img-col').removeClass('pull-right');
		$('#candidacy_candidate_profile_picture, #picture-changed').css("margin-left", "180px");
		$('#picture-profile').css("margin-left", '20px');
	} else {
		$('.img-col').addClass('pull-right');
		$('#picture-profile, #candidacy_candidate_profile_picture, #picture-changed').css("margin-left", "0px");
	}
}