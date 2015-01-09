/**
 * ...
 * @author Alex K
 */

class Main 
{
	public static function main(swfRoot:MovieClip):Void 
	{
		var xml:XMLLoader = new XMLLoader("config.xml", onXMLLoaded);
	}
	
	private static function onXMLLoaded(config:XML):Void
	{
		createBalls(config);
		_root.onEnterFrame = BallsManager.update; //add enterframe listener which will handle updates
	}
	
	/**
	 * Parse config file and create balls based on its data
	 * @param	config
	 */
	private static function createBalls(config:XML):Void 
	{
		var ballsCount:Number = config.firstChild.childNodes.length;
		var ballData:Object;
		var i:Number;
		
		for (i = 0; i < ballsCount; i++)
		{
			ballData = config.firstChild.childNodes[i].attributes;
			BallsManager.addBall(new Ball(i, ballData.x, ballData.y, ballData.r, ballData.s, ballData.a));
		}
	}
}