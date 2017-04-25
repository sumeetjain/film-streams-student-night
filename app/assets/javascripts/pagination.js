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

function listen_to_tabs(page_parent){
	var tabs = page_parent.getElementsByClassName("jtab");
  for (var i = 0; i < tabs.length; i++){
  	tabs[i].addEventListener("click", function(){
			num = parseInt(this.innerText);
			table_body = this.parentElement.previousElementSibling.childNodes[3]
			num_rows = table_body.getElementsByTagName('tr').length
			show_ten_table_rows(table_body,num*10);
			min = set_min(num,num_rows);
			generate_page_tabs(page_parent,min);
			listen_to_tabs(page_parent);
  	});
	}
}


// in order to display correct tabs at high and low numbers
// if number is too low for tabs, return floor
// if number is too high, ceiling minus 9
function set_min(min, num_rows){
	if (min < 6){
		return 1;
	} else if (min + 9 > num_rows){
		return num_rows - 9
	} else{
		return min;
	}	
}

function set_active_tab(tab){
	//this just seems ugly
}

// listen to the current tabs, for each tab
	

// when a tab is clicked all tabs regenerate
// when a tab is clicked, event listeners added to all tabs
// set 1 to active by default, set clicked to active
// if 6 is active show 2 - 11, 7 => 3 - 12 etc..
// if numbers higher than 5 or less than 5 minus total are selected, this
// will call make nums again.