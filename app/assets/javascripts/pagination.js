window.addEventListener('load', function(){
	var page_parents = document.getElementsByClassName("pagination");
	var table_bodies = document.getElementsByClassName("paginate_body");
	// for all trs, make that / 10 tabs
	generate_page_tabs(page_parents,1,10);
	// hide all but first 10 trs for tables
	show_ten_table_rows(table_bodies, 0);
});

function show_ten_table_rows(table_bodies,min){
	for (var i = 0; i <= table_bodies.length - 1; i++) {
		rows = table_bodies[i].getElementsByTagName("tr");

		for (var j = 0; j < rows.length; j++) {
			if (j >= min && j <= min+9){
				rows[j].style.display = "table-row";
			} else {
				rows[j].style.display = "none";
			}			
		}
	}
};

// For each table parent, generates tabs
//
// page_parents - initially a list of empty <ul>
function generate_page_tabs(page_parents,min,max){
	for (var i = 0; i <= page_parents.length-1; i++) {
		make_nums(page_parents[i],min,max);
	}
};

// Creates <li> for each 10 <tr>s in <tbody>
//
// Inserts numbers as <a> correspondingly
//
// 
function make_nums(table_sibling,min,max){
	//set max based on nums here if nums < max
	table = table_sibling.previousElementSibling.children[1];
	nums = table.childElementCount / 10;

	for (var i = min; i <= max; i++){
	  var li = document.createElement('li');
	  li.className += "jtab";
	  var a = document.createElement('a');
	  a.textContent = i;
	  a.href = "\'#\'"
	  li.appendChild(a);
	  table_sibling.appendChild(li);	
	}

	// listen to the current tabs, for each tab
	var tabs = document.getElementsByClassName("jtab");

  for (var i = 0; i < tabs.length; i++){
    	tabs[i].addEventListener("click", function(){
				num = parseInt(this.innerText);
				show_ten_table_rows(table_bodies,num);
				generate_page_tabs(page_parents,1,10);
    	});
  }
}; 

// if 2 is clicked show 10-20 and set 2 to active. 3 => 20-30 etc
// if 1 is active show 1-10 pagers
// if 6 is active show 2 - 11, 7 => 3 - 12 etc..
// if numbers higher than 5 or less than 5 minus total are selected, this
// will call make nums again.