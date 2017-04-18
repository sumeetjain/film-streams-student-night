window.addEventListener('turbolinks:load', function(){
  document.getElementById("new_movie").addEventListener("click", new_movie);
  add_movies_listener();
});

// Adds eventListeners to all the comment delete images.
function add_movies_listener(){
	var movie_list = document.getElementsByClassName("remove_movie");
    for (var x = 0; x <= movie_list.length -1; x++){
    	movie_list[x].addEventListener("click", remove_movie);
  }
}

// Inserts a table row element into the movies table body.
function new_movie(e){
	var first_row = document.getElementsByClassName("list_movies")[0];
	var event_id = document.getElementById("e_id").value;
	first_row.insertAdjacentHTML('afterbegin', new_row_info(event_id));
	add_movies_listener();
}

// Creates a new comment row.
// 
// Returns a String.
function new_row_info(event_id){
	var rowid =  Date.now();
	return  "<tr class='movie_row'>"+
					"<td><input class='movie_name form-control' type='text' placeholder='Movie Name' id='movie_" + rowid + "_title' name='movie[" + rowid + "][title]' value=''></td>"+
					"<td><input class='form-control' type='time' scope='row' placeholder='Time' id='movie_" + rowid + "_time' name='movie[" + rowid + "][time]' value=''></td>"+
 		  		"<td class='nopadding'><input class='collapse delete_row' type='text' name='row_" + rowid + "[delete]' value='0'>"+
					"<span class='glyphicon glyphicon-remove text-danger remove_movie' role='button'></span>" +
					"<input class='movie_class collapse' id='movie_" + rowid + "_name' name='movie[" + rowid + "][event_id]' value='" +  event_id + "'></td>" +
			    "</tr>"	  
}


// Changes the name of an movie to "delete" and collapses parent to make it invisible.
function remove_movie(e){
	this.parentNode.parentNode.getElementsByClassName("delete_row")[0].value = '1';
	this.parentNode.parentNode.className += " collapse";	
}

