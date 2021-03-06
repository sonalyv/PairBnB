// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap-sprockets

$(document).ready(function(){
  $(window).load(function(){
    
  var search_input = document.getElementById("search")
  
  if (search_input){
    search_input.addEventListener("keyup", function(event){
      autocomplete(event)
    })
  }
  
  window.globalXHR = new XMLHttpRequest()
  
  function autocomplete(event) {
    //retrieve input
    var input = event.target
  
    //get datalist element for results
    var list = document.getElementById("list")
  
    //set minimum num of chars
    var min_chars = 0
  
    if (input.value.length > min_chars) {
      //abort pending requests
      //ensure that our XHR object is not working on any pending request before we tell it to do new work
      window.globalXHR.abort()
  
      // Callback to be applied once the XMLHttpRequest() internal state has been changed after
      // sending a request
      // We check to see whether the request is done and that the return status of the request is ok
      window.globalXHR.onreadystatechange = function(){
        if (this.readyState == 4 && this.status == 200) {
          
          console.log(this.responseText)
  
          //convert json response to an object
          var response = JSON.parse(this.responseText)
  
          //clear previous results
          list.innerHTML = ""
  
          response.forEach(function(element){
            //create new option element
            var option = document.createElement("option")
            option.value = element
  
            //append option to list
            list.appendChild(option)
          })
        }
      }
  
      // authentication is required whenever our client wishes to make a request to our server
      // this is to prevent csrf attacks on our servers
      // more info can be found at the link below
      // https://www.checkmarx.com/2016/01/22/ultimate-guide-understanding-preventing-csrf/
      var auth_token = document.querySelector("[name='csrf-token']").content
      window.globalXHR.open("POST", "/search?query=" + input.value, true)
      //allow js to make request to rails server
      window.globalXHR.setRequestHeader("X-CSRF-TOKEN", auth_token)
      window.globalXHR.send()
      }
    }
  })
})