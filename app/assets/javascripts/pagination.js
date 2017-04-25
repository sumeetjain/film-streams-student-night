var table_bodies = null;
var page_parents = null;

window.addEventListener('load', function(){
	page_parents = document.getElementsByClassName("pagination");
	table_bodies = document.getElementsByClassName("paginate_body");

	// initially hide all but first 10 trs for tables
	for (var i = 0; i < table_bodies.length; i++) {
		show_ten_table_rows(table_bodies[i], 10);
	}

	// for all trs, make that / 10 tabs
	for (var i = 0; i < page_parents.length; i++) {
		generate_page_tabs(page_parents[i], 1);
		listen_to_tabs(page_parents[i]);
	}

});


// for a table body, show 10 table rows depending on max num given
function show_ten_table_rows(table_body,max){
		rows = table_body.getElementsByTagName("tr");

		for (var j = 0; j < rows.length; j++) {
			if (j >= max-10 && j <= max-1){
				rows[j].style.display = "table-row";
			} else {
				rows[j].style.display = "none";
			}			
		}
};

// For each table parent, sets inner text to empty
//
// page_parent - initially an empty <ul>
//
// displays num tabs based on min
function generate_page_tabs(page_parent,min){
		page_parent.innerHTML = "";
		make_nums(page_parent,min);
};

// Finds table body for pager, calcs number of pagers based on children /10
//
// Creates new <a> and parent <li>
//
// Appends this to the end of the pager.
function make_nums(page_parent,min){
	table_body = page_parent.previousElementSibling.children[1];
	nums = table_body.childElementCount / 10;

	for (var i = min; i <= min+9; i++){
	  var li = document.createElement('li');
	  li.className += "jtab";
	  var a = document.createElement('a');
	  a.textContent = i;
	  li.appendChild(a);
	  page_parent.appendChild(li);	
	}
}

// for the current clicked paginator, gets num, adjacent table, and rows
//
// shows the proper rows for that paginator
//
// adjusts the tabs properly
function listen_to_tabs(page_parent){
	var tabs = page_parent.getElementsByClassName("jtab");
  for (var i = 0; i < tabs.length; i++){
  	tabs[i].addEventListener("click", function(){

			clicked_num = parseInt(this.innerText);
			table_body = this.parentElement.previousElementSibling.childNodes[3];
			num_tabs = Math.ceil(table_body.getElementsByTagName('tr').length / 10);
			show_ten_table_rows(table_body,clicked_num*10);


			mid = set_mid(clicked_num,num_tabs);
			generate_page_tabs(page_parent,mid);
			listen_to_tabs(page_parent);
  	});
	}
}


// in order to display correct tabs at high and low numbers
// if number is too low for tabs, return floor
// if number is too high, ceiling minus 9
// TODO fix this, it doesnt let us go back.  need a way to caputre childre number
function set_mid(clicked_num, num_tabs){

	if (clicked_num < 6){
		return 1;
	} else if (clicked_num <= num_tabs-9){
		return clicked_num - 5;
	} else if (clicked_num > num_tabs - 9){
		return num_tabs - 9;
	}	
}

function set_active_tab(tab){
	//this just seems ugly
}


//If a number is greater than 6, generate 4 numbers above, and 5 below
// 1-6 => min 1
// 7 => min 2




