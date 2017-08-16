/* global $, Stripe */

//Document ready function.
// turbolinks makes webpage load a lot quicker but it conflicts with the 
// 'jqueryrails' gem
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  //Set Stripe public key.
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
  
  //When user clicks form submit button,
  submitBtn.click(function(event){
      //prevent default submission behavior.
    event.preventDefault();
    submitBtn.val("Processing").prop('disabled',true);
      //Collect the credit card fields.
      var ccNum = $('#card_number').val(),
          cvcNum = $('#card_code').val(),
          expMonth = $('#card_month').val(),
          expYear = $('#card_year').val();
          
      // Use Stripe JS library to check for card errors.
      var error = false;
      
      // validate card number.
      if(!Stripe.card.validateCardNumber(ccNum)){
        error = true;
        alert('The credit card number appears to be invalid');
      }
       // validate CVC number.
      if(!Stripe.card.validateCVC(cvcNum)){
        error = true;
        alert('The CVC number appears to be invalid');
      }
       // validate expiration date.
      if(!Stripe.card.validateExpiry(expMonth, expYear)){
        error = true;
        alert('The expiration date appears to be invalid');
      }
      
      if (error) {
        // If there are card errors, don't send to Stripe and also re-enable the button.
        submitBtn.prop('disabled', false).val("Sign Up");
      }else{
        //Send the card info to Stripe.
        Stripe.createToken({
        // writing objects in javascript
          number: ccNum,
          cvc: cvcNum,
          exp_month: expMonth,
          exp_year: expYear   
        },stripeResponseHandler);
      }
      return false;
  });
  //Stripe will return a card token.
  function stripeResponseHandler(status,response){
    
    //Get the token from the response.
    var token = response.id;
    
    //Inject the card token in a hidden field (into form).
    theForm.append($('<input type="hidden" name="user[stripe_card_token]">').val(taken));
    
    //Submit form to our Rails App.
    theForm.get(0).submit();
  }
});

