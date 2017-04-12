$(document).ready(function() {
  var priceDwnBtn = document.getElementById('sort-down-price');
  var priceUpBtn = document.getElementById('sort-up-price');
  var priceDwnBtn = document.getElementById('sort-down-price');
  var priceUpBtn= document.getElementById('sort-up-price');
  var heighDwnBtn = document.getElementById('sort-down-height');
  var heighUpBtn = document.getElementById('sort-up-height');

priceDwnBtn.onclick = function() {
  if (priceDwnBtn.style.display == 'inline') {
      priceDwnBtn.style['display'] = 'none';
      priceUpBtn.style['display'] = 'inline';
      localStorage.setItem('showUp', true);  //set flag
      localStorage.removeItem('showDown');  //remove key
    }
  };

    priceUpBtn.onclick = function() {
      if (priceUpBtn.style.display == 'inline') {
      priceDwnBtn.style['display'] = 'inline';
      priceUpBtn.style['display'] = 'none';
      localStorage.setItem('showDown', true);  //remove key
      localStorage.removeItem('showUp');  //remove key
  }
};
});


window.onload = function() {
document.getElementById('sort-down-price').style.display = "inline";
document.getElementById('sort-up-price').style.display = "none";
localStorage.setItem('showUp', true);  //remove key
localStorage.removeItem('showDown');  //remove key
};

function showUp() {
 console.log('showUp')
document.getElementById('sort-up-price').style.display = "inline";
document.getElementById('sort-down-price').style.display = "none";
}

function hideUp() {
  localStorage.removeItem('showUp');  //remove key
}

function showDown() {
console.log('showDown')
document.getElementById('sort-down-price').style.display = "inline";
document.getElementById('sort-up-price').style.display = "none";

}
function hideDown() {
localStorage.removeItem('showDown');  //remove key
}

if (localStorage.getItem('showDown')) {  //see if flag is set (returns undefined if not set)
  showDown();   //if set show table
} else if (localStorage.getItem('showUp')) {
showUp();

};
//
