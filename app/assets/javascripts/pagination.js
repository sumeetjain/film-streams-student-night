window.addEventListener('load', function(){
	var table_pagers = document.getElementsByClassName("pagination");

	paginate_tables(table_pagers);
});

function paginate_tables(table_pagers){
	for (var i = 0; i <= table_pagers.length-1; i++) {
		make_nums(table_pagers[i],1,10);
	}
};

function make_nums(table_sibling,low,up){
	//set up based on nums here if nums < up
	table = table_sibling.previousElementSibling.children[1];
	nums = table.childElementCount / 10;

	for (var i = low; i <= up; i++){
	  var li = document.createElement('li');
	  var a = document.createElement('a');
	  a.textContent = i;
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
// if numbers higher than 5 or less than 5 minus total are selected, this
// will call make nums again.