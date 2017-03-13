// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require jquery.geocomplete
$(function() {
$("#geo-input").geocomplete();
country: "US"
});
// $(document).ready(function() {
//   var subcat;
//   subcat = $('#category-select').html();
//   return $('#type-select').change(function() {
//     var cat, options;
//     cat = jQuery('#type-select').children('option').filter(':selected').text();
//     options = $(subcat).filter("optgroup[label='" + cat + "']").html();
//     if (options) {
//       return $('#category-select').html(options);
//     } else {
//       return $('#category-select').empty();
//     }
//   });
// });
(function() {
  $(document).on('click', '.toggle-window', function(e) {
    e.preventDefault();
    var panel = $(this).parent().parent();
    var messages_list = panel.find('.messages-list');

    panel.find('.panel-body').toggle();
    panel.attr('class', 'panel panel-default');

    if (panel.find('.panel-body').is(':visible')) {
      var height = messages_list[0].scrollHeight;
      messages_list.scrollTop(height);
    }
  });
})();

var handler = StripeCheckout.configure({
    key: 'pk_test_2xN4CjS8O6TCrDyTN3AhOo0b',
    image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
    token: function (token) {
        $("#stripeToken").val(token.id);
        $("#stripeEmail").val(token.email);
        $("#amount").val($("#amount").val() * 100);
        $("#myForm").submit();
    }
});
