function new_textbox(){
  var input = document.createElement("input"); // Creates an input tag.
  var location = document.getElementById("our_input");
  input.type = "text";
  input.required = true;
  input.autofocus = true;
  input.name = "new_name[]"; // Use the name in your own scripts for this.

  location.appendChild(input); // Adds input to location
}
function load_box_on_start(){
  for(x=1; x <= 4; x++){
    new_textbox();
  }
}
function delete_last_textbox(){
  var location = document.getElementById("our_input"); //sets location to be id of our_input
  location.removeChild(location.lastChild); // removes child at location, last child of location
}
