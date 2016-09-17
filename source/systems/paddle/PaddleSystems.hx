package systems.paddle;

class PaddleSystems {
	public var hoverer(default, null):PaddleHoverer;
	public var expression(default, null):PaddleExpression;
	public var squeezer(default, null):PaddleSqueezer;
	
	public function new() {
		hoverer = new PaddleHoverer();
		expression = new PaddleExpression();
		squeezer = new PaddleSqueezer();
	}
	
}