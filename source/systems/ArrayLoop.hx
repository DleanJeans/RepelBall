package systems;

class ArrayLoop<T> {
	public var array(default, null):Array<T>;
	public var i(default, null):Int = 0;
	
	public function new(?array:Array<T>) {
		setArray(array);
	}
	
	public inline function setArray(array:Array<T>) {
		this.array = array;
		i = 0;
	}
	
	public function setToIndexOf(object:T):Int {
		var index = array.indexOf(object);
		if (index != -1)
			i = index;
		return i;
	}
	
	public inline function first():T {
		return array[firstIndex()];
	}
	
	public inline function end():T {
		return array[endIndex()];
	}
	
	public inline function next():T {
		return array[nextIndex()];
	}
	
	public inline function prev():T {
		return array[prevIndex()];
	}
	
	public inline function current():T {
		return array[i];
	}
	
	public function nextIndex():Int {
		i++;
		if (i >= array.length)
			i = 0;
		return i;
	}
	
	public function prevIndex():Int {
		i--;
		if (i < 0)
			i = array.length - 1;
		return i;
	}
	
	public inline function firstIndex():Int {
		return i = 0;
	}
	
	public inline function endIndex():Int {
		return i = array.length - 1;
	}
	
}