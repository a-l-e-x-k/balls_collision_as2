/**
 * ...
 * @author Alex K
 */
class Ball
{
	private var _id:Number;
	private var _x:Number;
	private var _y:Number;
	
	private var _radius:Number;
	private var _speedX:Number;
	private var _speedY:Number;
	
	private var _mass:Number;
	private var _ballView:MovieClip;
	
	/**
	 * @param	id
	 * @param	startX
	 * @param	startY
	 * @param	radius
	 * @param	speed
	 * @param	angle
	 */
	public function Ball(id:Number, startX:Number, startY:Number, radius:Number, speed:Number, angle:Number) 
	{
		_ballView = _root.createEmptyMovieClip("ball" + id, id); //just putting all the ball-views in the root.To hell with containers, fields, layers and such (it'd be out of the scope of the task)! 
		_id = id;
		_x = startX;
		_y = startY;
		_radius = radius;
		_speedX = Math.cos(angle * Math.PI / 180) * speed;
		_speedY = Math.sin(angle * Math.PI / 180) * speed;
		_mass = Math.PI * _radius * _radius;
		drawCircle(_ballView, 0, 0, Number(_radius)); //cast to Number - woodoo magic. Otherwise it is a string
		updatePosition();
	}
	
	/**
	 * Slightly adjusted snippet from the web - belongs somewhere in Utilities class
	 * Please be aware that sometimes (in AS2) for reasons of peculiar nature you have to type-cast the arguments
	 * @param	mc
	 * @param	x
	 * @param	y
	 * @param	r
	 */
	private function drawCircle(mc:MovieClip, x:Number, y:Number, r:Number):Void 
	{
		mc.clear();
		mc.beginFill(0xFFFF00);
		mc.moveTo(x + r, y);
		mc.curveTo(r+x, Math.tan(Math.PI/8)*r+y, Math.sin(Math.PI/4)*r+x, Math.sin(Math.PI/4)*r+y);
		mc.curveTo(Math.tan(Math.PI/8)*r+x, r+y, x, r+y);
		mc.curveTo(-Math.tan(Math.PI/8)*r+x, r+y, -Math.sin(Math.PI/4)*r+x, Math.sin(Math.PI/4)*r+y);
		mc.curveTo(-r+x, Math.tan(Math.PI/8)*r+y, -r+x, y);
		mc.curveTo(-r+x, -Math.tan(Math.PI/8)*r+y, -Math.sin(Math.PI/4)*r+x, -Math.sin(Math.PI/4)*r+y);
		mc.curveTo(-Math.tan(Math.PI/8)*r+x, -r+y, x, -r+y);
		mc.curveTo(Math.tan(Math.PI/8)*r+x, -r+y, Math.sin(Math.PI/4)*r+x, -Math.sin(Math.PI/4)*r+y);
		mc.curveTo(r+x, -Math.tan(Math.PI/8)*r+y, r+x, y);
		mc.endFill();
	} 
	
	public function updatePosition():Void
	{
		_ballView._x = _x;
		_ballView._y = _y;
	}
	
	public function get x():Number
	{
		return Number(_x);
	}
	
	public function set x(value:Number):Void
	{
		_x = value;
	}
	
	public function get y():Number
	{
		return Number(_y);
	}
	
	public function set y(value:Number):Void
	{
		_y = value;
	}
	
	public function get radius():Number 
	{
		return Number(_radius);
	}
	
	public function get mass():Number 
	{
		return Number(_mass);
	}
	
	public function get speedX():Number 
	{
		return Number(_speedX);
	}
	
	public function set speedX(value:Number):Void 
	{
		_speedX = value;
	}
	
	public function get speedY():Number 
	{
		return Number(_speedY);
	}
	
	public function set speedY(value:Number):Void 
	{
		_speedY = value;
	}
}