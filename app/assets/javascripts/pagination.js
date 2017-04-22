window.addEventListener('load', function(){
	table_pagers = document.getElementsByClassName("pagination");

	paginate_tables(table_pagers);
});

function paginate_tables(table_pagers){
	for (var i = 0; i <= table_pagers.length-1; i++) {
		table_pagers[i].innerHTML = "<li> <a href=\'#\'>1</a> </li>"
	}
}




// need to generate these for as many 10 pages
//<li> <a href="#">i</a> </li>


// this is the number of rows on the table
pager.previousElementSibling.children[1].childElementCount
// need to get the element