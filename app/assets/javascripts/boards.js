$(document).ready(function() {
var checkbox = document.getElementById('checkbox');
var delivery_div = document.getElementById('delivery');
var pickup_div = document.getElementById('pickup');
delivery_div.style['display'] = 'block';

checkbox.onclick = function() {
   if(this.checked) {
     pickup_div.style['display'] = 'block';
     delivery_div.style['display'] = 'none';

   } else {
     delivery_div.style['display'] = 'block';
     pickup_div.style['display'] = 'none';
   }
};

});
