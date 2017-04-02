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

$(document).ready(function() {
  var activeBtn = document.getElementById('btn-active');
  var pendingBtn = document.getElementById('btn-pending');
  var inventoryBtn = document.getElementById('btn-inventory');
  var shippedBtn = document.getElementById('btn-shipped');
  var activeBtnM = document.getElementById('btn-active-m');
  var pendingBtnM = document.getElementById('btn-pending-m');
  var inventoryBtnM = document.getElementById('btn-inventory-m');
  var shippedBtnM = document.getElementById('btn-shipped-m');
  var pendingPG = document.getElementById('pending');
  var activePG = document.getElementById('active');
  var inventoryPG = document.getElementById('inventory');
  var shippedPG = document.getElementById('shipped');
  pendingPG.style['display'] = 'block';
  activePG.style['display'] = 'none';
  inventoryPG.style['display'] = 'none';
  shippedPG.style['display'] = 'none';

 activeBtn.onclick = function() {
     activePG.style['display'] = 'block';
     pendingPG.style['display'] = 'none';
     inventoryPG.style['display'] = 'none';
     shippedPG.style['display'] = 'none';
  };
  pendingBtn.onclick = function() {
     pendingPG.style['display'] = 'block';
     activePG.style['display'] = 'none';
     inventoryPG.style['display'] = 'none';
     shippedPG.style['display'] = 'none';
  };
  inventoryBtn.onclick = function() {
     inventoryPG.style['display'] = 'block';
     activePG.style['display'] = 'none';
     pendingPG.style['display'] = 'none';
     shippedPG.style['display'] = 'none';
  };
  shippedBtn.onclick = function() {
     shippedPG.style['display'] = 'block';
     activePG.style['display'] = 'none';
     inventoryPG.style['display'] = 'none';
     pendingPG.style['display'] = 'none';
  };
 //mobile
 activeBtnM.onclick = function() {
    activePG.style['display'] = 'block';
    pendingPG.style['display'] = 'none';
    inventoryPG.style['display'] = 'none';
    shippedPG.style['display'] = 'none';
 };
 pendingBtnM.onclick = function() {
    pendingPG.style['display'] = 'block';
    activePG.style['display'] = 'none';
    inventoryPG.style['display'] = 'none';
    shippedPG.style['display'] = 'none';
 };
 inventoryBtnM.onclick = function() {
    inventoryPG.style['display'] = 'block';
    activePG.style['display'] = 'none';
    pendingPG.style['display'] = 'none';
    shippedPG.style['display'] = 'none';
 };
 shippedBtnM.onclick = function() {
    shippedPG.style['display'] = 'block';
    activePG.style['display'] = 'none';
    inventoryPG.style['display'] = 'none';
    pendingPG.style['display'] = 'none';
 };
});



$(document).ready(function() {
  var subcat;
  subcat = $('#category-select').html();
  return $('#type-select').change(function() {
    var cat, options;
    cat = jQuery('#type-select').children('option').filter(':selected').text();
    options = $(subcat).filter("optgroup[label='" + cat + "']").html();
    if (options) {
      return $('#category-select').html(options);
    } else {
      return $('#category-select').empty();
    }
  });
});
// shipping hidden charge form
// shipping hidden charge form
$(document).ready(function() {
var checkbox = document.getElementById('checkbox');
var delivery_div = document.getElementById('delivery');
var pickup_div = document.getElementById('pickup');

checkbox.onclick = function() {
   if(this.checked) {
     delivery_div.style['display'] = 'block';
     pickup_div.style['display'] = 'none';
   } else {
     pickup_div.style['display'] = 'block';
     delivery_div.style['display'] = 'none';
   }
};
});
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
