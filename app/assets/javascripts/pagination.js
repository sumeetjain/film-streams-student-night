var table_bodies = null;
var page_parents = null;

window.addEventListener('load', function(){
	page_parents = document.getElementsByClassName("pagination");
	table_bodies = document.getElementsByClassName("paginate_body");
	// for all trs, make that / 10 tabs
	generate_page_tabs(page_parents, 1);
	// hide all but first 10 trs for tables
	show_ten_table_rows(table_bodies, 10);
});

function show_ten_table_rows(table_bodies,max){
	for (var i = 0; i <= table_bodies.length - 1; i++) {
		rows = table_bodies[i].getElementsByTagName("tr");

		for (var j = 0; j < rows.length; j++) {
			if (j >= max-10 && j <= max-1){
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
function generate_page_tabs(page_parents,min){
	for (var i = 0; i <= page_parents.length-1; i++) {
		page_parents[i].innerHTML = "";
		make_nums(page_parents[i],min,min+9);
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
	  li.appendChild(a);
	  table_sibling.appendChild(li);	
	}

	// listen to the current tabs, for each tab
	var tabs = document.getElementsByClassName("jtab");

  for (var i = 0; i < tabs.length; i++){
    	tabs[i].addEventListener("click", function(){
				num = parseInt(this.innerText);
				table_body = this.parentElement.previousElementSibling.childNodes[3]
				show_ten_table_rows(table_body,num*10);
				generate_page_tabs(page_parents,1,10);
    	});
  }
}; 

// set 1 to active by default, set clicked to active
// if 6 is active show 2 - 11, 7 => 3 - 12 etc..
// if numbers higher than 5 or less than 5 minus total are selected, this
// will call make nums again.