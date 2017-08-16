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
    
      //Collect the credit card fields.
      var ccNum = $('#card_number').val(),
          cvcNum = $('#card_code').val(),
          expMonth = $('#card_month').val(),
          expYear = $('#card_year').val();
          
      //Send the card info to Stripe.
      Stripe.createToken({
      // writing objects in javascript
        number: ccNum,
        cvc: cvcNum,
        exp-month: expMonth,
        exp-year: expYear   
      },stripeResponseHandler);
  });
  

  //Stripe will return a card token.
  //Inject card token as hidden field into form.
  //Submit form to our Rails App.
});

