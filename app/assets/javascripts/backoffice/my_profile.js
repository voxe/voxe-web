$(document).ready(function() {

    var today = new Date();

    $( function() {
        $( "#candidacy_candidate_profile_birthday" ).datepicker({
            dateFormat: "dd/mm/yy",
            changeYear: true,
            yearRange: "-100:+0"
        });
    } );

jQuery.extend(jQuery.validator.messages, {
    required: "Champs obligatoire.",
    url: "Veuillez entrez une URL valide"
});

$("#new_candidacy_candidate_profile").validate({
        ignore: [],
        messages: {
            "candidacy_candidate_profile[password]" : "Champs obligatoire, 6 caractères minimum",
            "candidacy_candidate_profile[name]" : "Champs obligatoire",
            "candidacy_candidate_profile[email]" : "Entrer une adresse mail valide",
            "candidacy_candidate_profile[phone]" : "Entrer un numéro de téléphone valide"
        },
        submitHandler: function(form) {
            mixpanel.track("Submit candidate public profile");
            form.submit();
        }
    });

$("#new_proposition").validate({
        ignore: [],
        messages: {
            "proposition[text]" : "Champs obligatoire, Sélectionner au moins 1 sous-thème",
            "proposition[tag_ids][]" : "Champs obligatoire, 300 caractères maximum"
        },
        submitHandler: function(form) {
            mixpanel.track("Submit candidate public profile");
            form.submit();
        }
    });



});