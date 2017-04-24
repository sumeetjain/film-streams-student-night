window.addEventListener('load', function(){
	var page_parents = document.getElementsByClassName("pagination");
	var table_bodies = document.getElementsByClassName("paginate_body");
	// for all trs, make that / 10 tabs
	generate_page_tabs(page_parents);
	// find the tabs
	var tabs = document.getElementsByClassName("t_row");
	debugger;
	// hide all but first 10 trs for tables
	show_ten_table_rows(table_bodies, 0, 9);
});

function show_ten_table_rows(table_bodies,min,max){
	for (var i = 0; i <= table_bodies.length - 1; i++) {
		rows = table_bodies[i].getElementsByTagName("tr");

		for (var j = 0; j < rows.length; j++) {
			if (j >= min && j <= max){
				rows[j].style.display = "table-row";
			} else {
				rows[j].style.display = "none";
			}			
		}
	}
};

function generate_page_tabs(page_parents){
	for (var i = 0; i <= page_parents.length-1; i++) {
		make_nums(page_parents[i],1,10);
	}
};

function make_nums(table_sibling,min,max){
	//set max based on nums here if nums < max
	table = table_sibling.previousElementSibling.children[1];
	nums = table.childElementCount / 10;

	for (var i = min; i <= max; i++){
	  var li = document.createElement('li');
	  var a = document.createElement('a');
	  a.textContent = i;
	  a.href = "\'#\'"
	  li.appendChild(a);
	  table_sibling.appendChild(li);	
	}
};

// add event listeners on pagers.
// if 2 is clicked show 10-20 and set 2 to active. 3 => 20-30 etc
// if 1 is active show 1-10 pagers
// if 6 is active show 2 - 11, 7 => 3 - 12 etc..
// if numbers higher than 5 or less than 5 minus total are selected, this
// will call make nums again.