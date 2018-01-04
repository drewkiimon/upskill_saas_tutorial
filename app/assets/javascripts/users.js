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
        event.preventDefault();
        
        // Disable buttons for multiple clicks, and change text
        submitButton.val("Processing...").prop('disabled', true);
    
        // Collect the credit card fields
        var ccNum = $('#card_number').val(), 
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        // Use Stripe.js library to check for card errors
        var error = false;
        
        // Validate card number
        if (!Stripe.card.validateCardNumber(ccNum)){
            error = true;
            alert('The credit card number appears to be invalid');
        }
        
        // Validate cvc
        if (!Stripe.card.validateCVC(cvcNum)){
            error = true;
            alert('The CVC number appears to be invalid');
        }
        
        // Validate expiration date
        if (!Stripe.card.validateExpiry(expMonth, expYear)){
            error = true;
            alert('The expiration date appears to be invalid');
        }
        
        if (error){
            // If there are card errors, don't send to stripe
            submitButton.prop('disabled', false).val("Sign Up");
        }
        else{
            // Send the card information to stripe
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);
        }
        
        // Exit out of the function
        return false;
    });
    
    // Stripe will return a card token
    
    function stripeResponseHandler(status, response) {
        // Get the token from the response
        var token = response.id;
        
        // Inject the card token into a hidden field.
        theForm.append($('<input type="hidden" name="user[stripe_card_token]">').val(token));
    
        // Submit form to our Rails app 
        theForm.get(0).submit();
    }
    
    
})
