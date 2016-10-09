package systems;

@:enum
abstract GetSet(Int) {
	var GET_SET = 1;
	var GET_ONLY = 0;
}

typedef ArrayLoop = TypedArrayLoop<Dynamic>;

class TypedArrayLoop<T:Dynamic> {
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
	
	public function setIndex(index:Int) {
		index = upperBound(index);
		index = lowerBound(index);
		return i = index;
	}
	
	public function add(num:Int, getSet:GetSet = GET_SET):T {
		return array[addIndex(num, getSet)];
	}
	
	public function sub(num:Int, getSet:GetSet = GET_SET):T {
		return array[subIndex(num, getSet)];
	}
	
	public inline function first(getSet:GetSet = GET_SET):T {
		return array[firstIndex(getSet)];
	}
	
	public inline function end(getSet:GetSet = GET_SET):T {
		return array[endIndex(getSet)];
	}
	
	public inline function next(getSet:GetSet = GET_SET):T {
		return array[nextIndex(getSet)];
	}
	
	public inline function prev(getSet:GetSet = GET_SET):T {
		return array[prevIndex(getSet)];
	}
	
	public inline function current():T {
		return array[i];
	}
	
	public function addIndex(num:Int, getSet:GetSet = GET_SET):Int {
		var i = this.i;
		i -= num;
		i = upperBound(i);
		applyIndexIfGetSet(i, getSet);
		return i;
	}
	
	public function subIndex(num:Int, getSet:GetSet = GET_SET):Int {
		var i = this.i;
		i -= num;
		i = upperBound(i);
		applyIndexIfGetSet(i, getSet);
		return i;
	}
	
	public function nextIndex(getSet:GetSet = GET_SET):Int {
		var i = this.i;
		i++;
		i = upperBound(i);
		applyIndexIfGetSet(i, getSet);
		return i;
	}
	
	public function prevIndex(getSet:GetSet = GET_SET):Int {
		var i = this.i;
		i--;
		i = lowerBound(i);
		applyIndexIfGetSet(i, getSet);
		return i;
	}
	
	public inline function firstIndex(getSet:GetSet = GET_SET):Int {
		return getSet == GET_SET ? 0 : i = 0;
	}
	
	public inline function endIndex(getSet:GetSet = GET_SET):Int {
		return getSet == GET_SET ? array.length - 1 : i = array.length - 1;
	}
	
	private inline function lowerBound(index:Int) {
		if (index < 0)
			index = array.length - 1;
		return index;
	}
	
	private inline function upperBound(index:Int) {
		if (index >= array.length)
			index = 0;
		return index;
	}
	
	private inline function applyIndexIfGetSet(index:Int, getSet:GetSet) {
		if (getSet == GET_SET)
			i = index;
	}
	
}