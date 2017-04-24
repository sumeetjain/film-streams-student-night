window.addEventListener('load', function(){
	table_pagers = document.getElementsByClassName("pagination");

	paginate_tables(table_pagers);
});

function paginate_tables(table_pagers){
	for (var i = 0; i <= table_pagers.length-1; i++) {
		table_pagers[i].innerHTML = make_nums(table_pagers[i]);
	}
}

function make_nums(table_sibling){
	table = table_sibling.previousElementSibling.children[1];
	nums = table.childElementCount / 10;
	debugger;

	for (var i = 0; i <= nums-1; i++){
	  var li = document.createElement('li');
	  var a = document.createElement('a');
	  a.textContent = i;
	  a.href = "\'#\'"
	  li.appendChild(a);
	  table.appendChild(li);		
	}
};

"<li> <a href=\'#\'>1</a> </li>"




// need to generate these for as many 10 pages
//<li> <a href="#">i</a> </li>


// this is the number of rows on the table
pager.previousElementSibling.children[1].childElementCount
// need to get the element