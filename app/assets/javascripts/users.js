/* global $, Stripe */
// Document ready function
$(document).on('turbolinks:load', function(){
    var theForm = $('#pro_form');
    var submitButton = $('#form-signup-btn')
    
    // Set our Stripe Public Key
    // $ to select a certain value
    Stripe.setPublishableKey( $('meta[name= "stripe-key"]').attr('content') );
    
    // When user clicks "form-signup-btn"
    submitButton.click(function(event){
        // prevent default submission behavior
        event.preventDefault()
    
        // Collect the credit card fields
        var ccNum = $('#card_number').val(), 
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        // Send the card information to stripe
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
    });
    // Stripe will return a card token
    // Inject card token as hidden field into form
    // Submit form to our Rails app    
    
})
