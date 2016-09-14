package systems.paddle;

class PaddleSystems {
	public var hoverer(default, null):PaddleHoverer;
	public var expression(default, null):PaddleExpression;
	public var personality(default, null):PaddlePersonality;
	public var squeezer(default, null):PaddleSqueezer;
	
	public function new() {
		hoverer = new PaddleHoverer();
		expression = new PaddleExpression();
		personality = new PaddlePersonality();
		squeezer = new PaddleSqueezer();
	}
	
}