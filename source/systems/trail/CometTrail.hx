package systems.trail;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import openfl.display.GraphicsPathWinding;
import systems.trail.CometTrail.Trail;

class CometTrail extends FlxSprite {
	public var trailMap(default, null):TrailMap;
	
	public function new(x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0) {
		super(x, y);
		
		makeGraphic(width == 0 ? FlxG.width : width, height == 0 ? FlxG.height : height, FlxColor.TRANSPARENT);
		trailMap = new TrailMap();
	}
	
	public function removeAll() {
		for (sprite in trailMap.keys()) {
			var nodes = getNodes(sprite);
			for (node in nodes)
				node.point.put();
			trailMap.remove(sprite);
		}
	}
	
	public function add(sprite:FlxSprite, ?trailColor:FlxColor, ?trailSize:Float) {
		if (trailSize == null)
			trailSize = (sprite.width + sprite.height) / 2;
		if (trailColor == null) {
			trailColor = sprite.color;
			trailColor.alphaFloat = 0.5;
		}
		trailMap.set(sprite, { nodes: new Nodes(), color:trailColor, size: trailSize });
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
		
		addNodes();
		calculateTrailsLength();
	}
	
	private function addNodes() {
		var nodes:Nodes;
		var spriteCenter:FlxPoint;
		var newNode:Node;
		
		for (sprite in trailMap.keys()) {
			nodes = getNodes(sprite);
			spriteCenter = sprite.getMidpoint();
			
			if (nodes.length >= Game.settings.TRAIL_NODE_LIMIT) {
				newNode = nodes.shift();
				newNode.point.copyFrom(spriteCenter);
				spriteCenter.put();
			}
			else {
				newNode = createNewNode(spriteCenter);
			}
			nodes.push(newNode);
			newNode = null;
		}
	}
	
	private inline function createNewNode(point:FlxPoint) {
		var node:Node = {
			point: point,
		};
		return node;
	}
	
	private inline function getNodes(sprite:FlxSprite):Nodes {
		return getTrail(sprite).nodes;
	}
	
	public inline function getTrail(sprite:FlxSprite):Trail {
		return trailMap[sprite];
	}
	
	private function calculateTrailsLength() {
		var trail:Trail;
		var nodes:Nodes;
		var segment = FlxVector.get();
		var lastNode:Node = null;
		var thisNode:Node = null;
		
		for (sprite in trailMap.keys()) {
			trail = getTrail(sprite);
			nodes = trail.nodes;
			trail.length = 0;
			
			for (node in nodes) {
				thisNode = node;
				if (lastNode != null && thisNode != null) {
					segment.copyFrom(lastNode.point.copyTo().subtractPoint(thisNode.point));
					trail.length += segment.length;
				}
				lastNode = thisNode;
			}
			
			lastNode = null;
			thisNode = null;
		}
		
		segment.put();
	}
	
	private inline function getNLastPoint(nodes:Nodes, n:Int = 1):FlxPoint {
		return getNLastNode(nodes, n).point;
	}
	
	private inline function getNLastNode(nodes:Nodes, n:Int = 1):Node {
		return nodes[nodes.length - n];
	}
	
	private inline function setSegment(segment:FlxPoint, p2:FlxPoint, p1:FlxPoint):FlxPoint {
		return segment.copyFrom(getSegment(p2, p1));
	}
	
	private inline function getSegment(p2:FlxPoint, p1:FlxPoint):FlxPoint {
		return p2.subtractPoint(p1);
	}
	
	override public function draw():Void {
		clearCanvas();
		calculateTrailsAttribute();
		drawTrail();
		
		super.draw();
	}
	
	private inline function clearCanvas() {
		FlxSpriteUtil.fill(this, FlxColor.TRANSPARENT);
	}
	
	private function calculateTrailsAttribute() {
		var trail:Trail;
		
		for (sprite in trailMap.keys()) {
			trail = trailMap.get(sprite);
			calculateNodesAttribute(trail);
		}
	}
	
	private function calculateNodesAttribute(trail:Trail) {
		var nodes:Nodes = trail.nodes;
		
		var currentLength:Float = 0;
		
		var thisNode:Node;
		var prevNode:Node;
		var nextNode:Node;
		
		var nextSegment:FlxPoint = null;
		var prevSegment:FlxPoint = null;
		
		var lastAngle:Null<Float> = null;
		
		for (i in 0...nodes.length) {
			if (i == 0) continue;
			
			thisNode = nodes[i];
			prevNode = nodes[i - 1];
			nextNode = nodes[i + 1];
			
			if (prevNode != null) {
				prevSegment = thisNode.point.copyTo().subtractPoint(prevNode.point);
				currentLength += prevSegment.distanceTo(FlxPoint.weak());
			}
			if (nextNode != null)
				nextSegment = nextNode.point.copyTo().subtractPoint(thisNode.point);
			
			thisNode.radius = trail.size / 2 * currentLength / trail.length;
			thisNode.angle = calculateNodeAngle(prevSegment, nextSegment, lastAngle);
			
			lastAngle = thisNode.angle;
			
			prevSegment = null;
			nextSegment = null;
		}
	}
	
	private function calculateNodeAngle(prevSegment:FlxPoint, ?nextSegment:FlxPoint, ?lastNodeAngle:Float):Float {
		var angle = Math.atan2(prevSegment.y, prevSegment.x) + Math.PI / 2;
		if (nextSegment != null) {
			angle += Math.atan2(nextSegment.y, nextSegment.x) + Math.PI / 2;
			angle /= 2;
		}
		angle *= FlxAngle.TO_DEG;
		angle = FlxMath.roundDecimal(angle, 2);
		angle = FlxAngle.wrapAngle(angle);
		
		if (lastNodeAngle != null && Math.abs(FlxAngle.wrapAngle(lastNodeAngle - angle)) > 90)
			angle = FlxAngle.wrapAngle(angle + 180);
		
		return angle;
	}
	
	private function drawTrail() {
		var trail:Trail;
		var nodes:Nodes;
		
		var outlinePoints = new Array<FlxPoint>();
		var outline2 = new Array<FlxPoint>();
		var outline1 = new Array<FlxPoint>();
		
		var thisNode:Node;
		var toRadius:FlxPoint;
		
		var outlineNode1:FlxPoint;
		var outlineNode2:FlxPoint;
		
		for (sprite in trailMap.keys()) {
			trail = getTrail(sprite);
			nodes = trail.nodes;
			
			if (nodes.length == 0) return;
			
			var lastNode = nodes.shift();
			for (node in nodes) {
				thisNode = node;
				toRadius = FlxVelocity.velocityFromAngle(thisNode.angle, thisNode.radius);
				
				outlineNode1 = thisNode.point.copyTo().addPoint(toRadius);
				outlineNode2 = thisNode.point.copyTo().subtractPoint(toRadius);
				
				outline1.push(outlineNode1);
				outline2.push(outlineNode2);
			}
			
			outline1.reverse();
			outlinePoints = outlinePoints.concat(outline1);
			outlinePoints.push(lastNode.point);
			outlinePoints = outlinePoints.concat(outline2);
			
			nodes.unshift(lastNode);
			var firstPoint = lastNode.point.copyTo();
			
			drawTrailNonZero(trail.color, outlinePoints);
			
			while (outlinePoints.length > 0)
				outlinePoints.pop().put();
			outline2.splice(0, outline2.length);
			outline1.splice(0, outline1.length);
			
			nodes[0].point = firstPoint;
		}
	}
	
	private function drawTrailNonZero(color:FlxColor, outlinePoints:Array<FlxPoint>) {
		FlxSpriteUtil.beginDraw(color);
			FlxSpriteUtil.flashGfx.drawPath(
			[ for (i in 0...outlinePoints.length) i == 0 ? 1 : 2 ],
			[ for (node in outlinePoints) for (i in 0...2) i == 0 ? node.x : node.y],
			GraphicsPathWinding.NON_ZERO);
			FlxSpriteUtil.endDraw(this);
	}
	
}

typedef TrailMap = Map<FlxSprite, Trail>;

typedef Trail = {
	nodes:Nodes,
	size:Float,
	color:FlxColor,
	?length:Float
}

typedef Nodes = Array<Node>;

typedef Node = {
	point:FlxPoint,
	?angle:Float,
	?radius:Float
}