package systems.paddle;

class PaddleSystems {
	public var hoverer(default, null):PaddleHoverer;
	public var expression(default, null):PaddleExpression;
	public var squeezer(default, null):PaddleSqueezer;
	public var movement(default, null):PaddleMovement;
	public var position(default, null):PaddlePositioner;
	public var speed(default, null):PaddleSpeed;
	
	public function new() {
		hoverer = new PaddleHoverer();
		expression = new PaddleExpression();
		squeezer = new PaddleSqueezer();
		movement = new PaddleMovement();
		position = new PaddlePositioner();
		speed = new PaddleSpeed();
	}
	
}