$(document).ready(function() {
  
  var progressBar1 = document.getElementById("pb1");
  var progressBarLabel1 = document.getElementById("pb-lab-1");
  var observer = new MutationObserver(function(mutations) {
    progressBar1.setAttribute("data-value", progressBar1.style.width);
    progressBarLabel1.textContent = progressBar1.getAttribute("data-value");
  });
  observer.observe(progressBar1, { attributes: true, attributeFilter: ['style'] });
  
  var progressBar2 = document.getElementById("pb2");
  var progressBarLabel2 = document.getElementById("pb-lab-2");
  var observer = new MutationObserver(function(mutations) {
    var value = progressBar2.style.width;
    if (progressBar2.classList.contains('divide-by-20')) {
      value = parseFloat(value) / 20; // divide by 20
      value = value.toFixed(2); // round to 2 decimal places
    }
    progressBar2.setAttribute("data-value", value);
    progressBarLabel2.textContent = value;
  });
  observer.observe(progressBar2, { attributes: true, attributeFilter: ['style'] });
  
  var progressBar3 = document.getElementById("pb3");
  var progressBarLabel3 = document.getElementById("pb-lab-3");
  var observer = new MutationObserver(function(mutations) {
    var value = progressBar3.style.width;
    if (progressBar3.classList.contains('divide-by-10')) {
      value = parseFloat(value) / 10; // divide by 10
      value = value.toFixed(2); // round to 2 decimal places
    }
    progressBar3.setAttribute("data-value", value);
    progressBarLabel3.textContent = value;
  });
  observer.observe(progressBar3, { attributes: true, attributeFilter: ['style'] });

  var progressBar4 = document.getElementById("pb4");
  var progressBarLabel4 = document.getElementById("pb-lab-4");
  var observer = new MutationObserver(function(mutations) {
    progressBar4.setAttribute("data-value", progressBar4.style.width);
    progressBarLabel4.textContent = progressBar4.getAttribute("data-value");
  });
  observer.observe(progressBar4, { attributes: true, attributeFilter: ['style'] });
  
  var progressBar5 = document.getElementById("pb5");
  var progressBarLabel5 = document.getElementById("pb-lab-5");
  var observer = new MutationObserver(function(mutations) {
    var value = progressBar5.style.width;
    if (progressBar5.classList.contains('divide-by-20')) {
      value = parseFloat(value) / 20; // divide by 20
      value = value.toFixed(2); // round to 2 decimal places
    }
    progressBar5.setAttribute("data-value", value);
    progressBarLabel5.textContent = value;
  });
  observer.observe(progressBar5, { attributes: true, attributeFilter: ['style'] });
  
  var progressBar6 = document.getElementById("pb6");
  var progressBarLabel6 = document.getElementById("pb-lab-6");
  var observer = new MutationObserver(function(mutations) {
    var value = progressBar6.style.width;
    if (progressBar6.classList.contains('divide-by-10')) {
      value = parseFloat(value) / 10; // divide by 10
      value = value.toFixed(2); // round to 2 decimal places
    }
    progressBar6.setAttribute("data-value", value);
    progressBarLabel6.textContent = value;
  });
  observer.observe(progressBar6, { attributes: true, attributeFilter: ['style'] });
  
  var progressBar7 = document.getElementById("pb7");
  var progressBarLabel7 = document.getElementById("pb-lab-7");
  var observer = new MutationObserver(function(mutations) {
    progressBar7.setAttribute("data-value", progressBar7.style.width);
    progressBarLabel7.textContent = progressBar7.getAttribute("data-value");
  });
  observer.observe(progressBar7, { attributes: true, attributeFilter: ['style'] });
    
  var progressBar8 = document.getElementById("pb8");
  var progressBarLabel8 = document.getElementById("pb-lab-8");
  var observer = new MutationObserver(function(mutations) {
    var value = progressBar8.style.width;
    if (progressBar8.classList.contains('divide-by-20')) {
      value = parseFloat(value) / 20; // divide by 20
      value = value.toFixed(2); // round to 2 decimal places
    }
    progressBar8.setAttribute("data-value", value);
    progressBarLabel8.textContent = value;
  });
  observer.observe(progressBar8, { attributes: true, attributeFilter: ['style'] });
  
  var progressBar9 = document.getElementById("pb9");
  var progressBarLabel9 = document.getElementById("pb-lab-9");
  var observer = new MutationObserver(function(mutations) {
    var value = progressBar9.style.width;
    if (progressBar9.classList.contains('divide-by-10')) {
      value = parseFloat(value) / 10; // divide by 10
      value = value.toFixed(2); // round to 2 decimal places
    }
    progressBar9.setAttribute("data-value", value);
    progressBarLabel9.textContent = value;
  });
  observer.observe(progressBar9, { attributes: true, attributeFilter: ['style'] });
  
});