window.addEventListener('load', function(){
	var table_pagers = document.getElementsByClassName("pagination");

	paginate_tables(table_pagers);
});

function paginate_tables(table_pagers){
	for (var i = 0; i <= table_pagers.length-1; i++) {
		make_nums(table_pagers[i]);
	}
};

function make_nums(table_sibling){
	table = table_sibling.previousElementSibling.children[1];
	nums = table.childElementCount / 10;
	for (var i = 0; i <= nums-1; i++){
	  var li = document.createElement('li');
	  var a = document.createElement('a');
	  a.textContent = i+1;
	  a.href = "\'#\'"
	  li.appendChild(a);
	  table_sibling.appendChild(li);		
	}
};

// show only first 10 on table by default. set 1 to active by default
// add event listeners on pagers.
// if 2 is clicked show 10-20 and set 2 to active. 3 => 20-30 etc
// if 1 is active show 1-10 pagers
// if 6 is active show 2 - 11, 7 => 3 - 12 etc..