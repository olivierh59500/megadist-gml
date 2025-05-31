function scr_get_sum(){
	var arr = argument0;
	var index = argument1;
	var decal = argument2;

	var n = array_length(arr);
	if (n == 0) return decal;

	var max_val = arr[n - 1];
	var f = floor(index / n);
	var m = index mod n;
	return decal + f * max_val + arr[m];
}