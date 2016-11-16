package systems.trail;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxPath;
import flixel.util.FlxSpriteUtil;

typedef NodeDataMap = Map<FlxPoint, NodeData>;
typedef NodeData = {
	?radius:Float,
	?angle:Float,
}

class CometTrail extends FlxBasic {
	public static var HALF_PI = Math.PI * 0.5;
	
	public var canvas:FlxSprite;
	
	public var sprite(default, null):FlxSprite;
	public var path(default, null):FlxPath;
	public var length(default, null):Float;
	
	public var headSize:Float;
	public var color:FlxColor;
	public var nodeLimit:Int = 25;
	
	private var _nodeDataMap:NodeDataMap = new NodeDataMap();
	private var _spriteCenter:FlxPoint = FlxPoint.get();
	private var _addNodeNow:Bool = false;
	
	public function new(sprite:FlxSprite, canvas:FlxSprite, ?headSize:Float, ?color:FlxColor) {
		super();
		
		this.canvas = canvas;
		this.sprite = sprite;
		this.headSize = headSize == null ? (sprite.width + sprite.height) / 2 : headSize;
		
		path = new FlxPath();
		
		if (color == null) {
			color = Game.color.white;
			color.alphaFloat = 0.5;
		}
		this.color = color;
	}
	
	public inline function addNodeNow() {
		_addNodeNow = true;
	}
	
	override public function destroy():Void {
		super.destroy();
		canvas = null;
		sprite = null;
		path = FlxDestroyUtil.destroy(path);
		_nodeDataMap = null;
		_spriteCenter.put();
	}
	
	override public function draw():Void {
		super.draw();
		
		sprite.getMidpoint(_spriteCenter);
		
		if (_addNodeNow) {
			_addNodeNow = false;
			addNewNode();
		}
		else updateTailNode();
		
		if (path.nodes.length < 2) return;
		calculateLength();
		calculateRadiusAndAngle();
		if (canvas != null)
			drawTrail();
	}
	
	private function addNewNode() {
		var newNode:FlxPoint;
		
		if (path.nodes.length >= nodeLimit)
			newNode = path.nodes.shift();
		else newNode = FlxPoint.get();
		newNode.copyFrom(_spriteCenter);
		
		path.addPoint(newNode, true);
	}
	
	private function updateTailNode() {
		if (path.nodes.length <= 1) return;
		
		path.tail().copyFrom(_spriteCenter);
	}
	
	private function calculateLength() {
		var nodeCopy = FlxPoint.get();
		var segment = FlxPoint.get();
		length = 0;
		
		for (i in 0...path.nodes.length) {
			var thisNode = path.nodes[i];
			var nextNode = path.nodes[i + 1];
			if (thisNode != null && nextNode != null) {
				segment.copyFrom(thisNode.copyTo(nodeCopy).subtractPoint(nextNode));
				length += FlxMath.vectorLength(segment.x, segment.y);
			}
			else break;
		}
		
		nodeCopy.put();
		segment.put();
	}
	
	private function calculateRadiusAndAngle() {
		var nodeCopy = FlxPoint.get();
		var prevSegment = FlxPoint.get();
		var nextSegment = FlxPoint.get();
		var currentLength:Float = 0;
		var angle:Null<Float> = null;
		
		for (i in 0...path.nodes.length) {
			var prevNode = path.nodes[i - 1];
			var thisNode = path.nodes[i];
			var nextNode = path.nodes[i + 1];
			
			if (prevNode != null) {
				prevSegment.copyFrom(thisNode.copyTo(nodeCopy).subtractPoint(prevNode));
				currentLength += prevSegment.distanceTo(FlxPoint.weak());
			}
			if (nextNode != null)
				nextSegment.copyFrom(nextNode.copyTo(nodeCopy).subtractPoint(thisNode));
			
			var radius = headSize * currentLength / length * 0.5;
			angle = calculateAngle(prevSegment, nextSegment, angle);
			
			_nodeDataMap.set(thisNode, {
				radius: radius,
				angle: angle
			});
		}
	}
	
	private function calculateAngle(prevSegment:FlxPoint, ?nextSegment:FlxPoint, ?lastAngle:Float):Float {
		var angle = Math.atan2(prevSegment.y, prevSegment.x) + HALF_PI;
		
		if (nextSegment != null) {
			angle += Math.atan2(nextSegment.y, nextSegment.x) + HALF_PI;
			angle *= 0.5;
		}
		
		angle *= FlxAngle.TO_DEG;
		
		if (lastAngle != null) {
			var angleDifference = Math.abs(FlxAngle.wrapAngle(lastAngle - angle));
			if (angleDifference > 90)
				angle += 180;
		}
		
		return FlxAngle.wrapAngle(angle);
	}
	
	private function drawTrail() {
		var outline = getOutline();
		drawToCanvas(outline);
		FlxDestroyUtil.putArray(outline);
	}
	
	private function getOutline():Array<FlxPoint> {
		var toOutline = FlxPoint.get();
		
		var outline1:Array<FlxPoint> = new Array<FlxPoint>();
		var outline2:Array<FlxPoint> = new Array<FlxPoint>();
		
		for (n in path.nodes) {
			if (n == path.head()) continue;
			var node:FlxPoint = n;
			
			var nodeData:NodeData = _nodeDataMap.get(node);
			FlxAngle.getCartesianCoords(nodeData.radius, nodeData.angle, toOutline);
			
			var outlineNode1 = node.copyTo().addPoint(toOutline);
			var outlineNode2 = node.copyTo().subtractPoint(toOutline);
			
			outline1.push(outlineNode1);
			outline2.push(outlineNode2);
		}
		
		toOutline.put();
		
		outline1.reverse();
		outline1.push(path.head().copyTo());
		outline1 = outline1.concat(outline2);
		
		return outline1;
	}
	
	private function drawToCanvas(outline:Array<FlxPoint>) {
		FlxSpriteUtil.beginDraw(color);
		FlxSpriteUtil.flashGfx.drawPath(getDrawCommands(outline.length), getOutlineNodeXYArray(outline), "nonZero");
		FlxSpriteUtil.endDraw(canvas);
	}
	
	private inline function getDrawCommands(length:Int) {
		var commands = [ for (i in 1...length) 2 ];
		commands.unshift(1);
		return commands;
	}
	
	private inline function getOutlineNodeXYArray(outline:Array<FlxPoint>) {
		return [ for (node in outline) for (i in 0...2) i == 0 ? node.x : node.y ];
	}
}