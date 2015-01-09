import flash.geom.Rectangle;

/**
 * Fully static class, 
 * resembling the exclusive manager - the only entity of such kind in the app
 * ...
 * @author Alex K
 */
class BallsManager
{
	private static var _balls:Array = [];
	
	public static function update():Void
	{
		moveBalls();
		checkForCollisions();
		render();
	}
	
	private static function moveBalls():Void
	{
		var i:Number;
		var ball:Ball;
		var numBalls:Number = _balls.length;
		for (i = 0; i < numBalls; i++)
		{
			ball = _balls[i];
			ball.x += ball.speedX;
			ball.y += ball.speedY;
		}
	}
	
	private static function checkForCollisions():Void
	{
		checkForBallWallCollisions();
		checkForBallBallCollisions();
	}
	
	private static function checkForBallWallCollisions():Void
	{
		var ball:Ball;
		var i:Number;
		var numBalls:Number = _balls.length;
		for (i = 0; i < numBalls; i++)
		{
			ball = _balls[i];

			if ((ball.x - ball.radius <= 0) || (ball.x + ball.radius >= Stage.width))
			{
				ball.speedX *= -1;
				ball.x = (ball.x - ball.radius) < 0 ? ball.radius : ball.x; //if ball went well beyond the border of a stage we have to pull it out
			}
			else if ((ball.y - ball.radius <= 0) || (ball.y + ball.radius >= Stage.height))
			{
				ball.speedY *= -1;
				ball.y = (ball.y - ball.radius) < 0 ? ball.radius : ball.y; //if ball went well beyond the border of a stage we have to pull it out
			}
		}
	}

	private static function checkForBallBallCollisions():Void
	{
		var numBalls:Number = _balls.length;
		var i:Number;
		var j:Number;
		
		/**
		 * Loop through all the balls with going through all balls for each of the balls. Well said?
		 * i & j being simply an index of a ball in the _balls array
		 */
		for (i = 0; i < numBalls; i++)
		{
			for (j = i + 1; j < numBalls; j++)
			{
				if (i == j)
					continue;
				
				if (isColliding(_balls[i], _balls[j]))
				{
					resolveCollision(_balls[i], _balls[j]);
				}
			}
		}
	}
	
	/**
	 * @param	ballA
	 * @param	ballB
	 * @return
	 */
	private static function isColliding(ballA:Ball, ballB:Ball):Boolean
	{
		var distanceX:Number = ballA.x - ballB.x;
		var distanceY:Number = ballA.y - ballB.y;
		var distance:Number = Math.sqrt(distanceX * distanceX + distanceY * distanceY);
		var radiiSum:Number = ballA.radius + ballB.radius;
		return distance <= radiiSum;
	}
	
	/**
	 * Elastic collision algorythm references: http://www.hoomanr.com/Demos/Elastic2/ and http://www.emanueleferonato.com/2007/08/19/managing-ball-vs-ball-collision-with-flash/
	 * @param	ballA
	 * @param	ballB
	 */
	private static function resolveCollision(ballA:Ball, ballB:Ball):Void
	{
		var dx:Number = ballA.x - ballB.x;
		var dy:Number = ballA.y - ballB.y;
		var collisionision_angle:Number = Math.atan2(dy, dx);
		
		var magnitude_1:Number = Math.sqrt(ballA.speedX * ballA.speedX + ballA.speedY * ballA.speedY); 
		var magnitude_2:Number = Math.sqrt(ballB.speedX * ballB.speedX + ballB.speedY * ballB.speedY);
		var direction_1:Number = Math.atan2(ballA.speedY, ballA.speedX);
		var direction_2:Number = Math.atan2(ballB.speedY, ballB.speedX);
		
		var new_xspeed_1:Number = magnitude_1 * Math.cos(direction_1 - collisionision_angle);
		var new_yspeed_1:Number = magnitude_1 * Math.sin(direction_1 - collisionision_angle);
		var new_xspeed_2:Number = magnitude_2 * Math.cos(direction_2 - collisionision_angle);
		var new_yspeed_2:Number = magnitude_2 * Math.sin(direction_2 - collisionision_angle);
		
		var final_xspeed_1:Number = ((ballA.mass - ballB.mass) * new_xspeed_1 + 2 * ballB.mass * new_xspeed_2) / (ballA.mass + ballB.mass);
		var final_xspeed_2:Number = ((ballB.mass - ballA.mass) * new_xspeed_2 + 2 * ballA.mass * new_xspeed_1) / (ballA.mass + ballB.mass);
		var final_yspeed_1:Number = new_yspeed_1;
		var final_yspeed_2:Number = new_yspeed_2;
		
		ballA.speedX = Math.cos(collisionision_angle) * final_xspeed_1 + Math.cos(collisionision_angle + Math.PI / 2) * final_yspeed_1;
		ballA.speedY = Math.sin(collisionision_angle) * final_xspeed_1 + Math.sin(collisionision_angle + Math.PI / 2) * final_yspeed_1;
		ballB.speedX = Math.cos(collisionision_angle) * final_xspeed_2 + Math.cos(collisionision_angle + Math.PI / 2) * final_yspeed_2;
		ballB.speedY = Math.sin(collisionision_angle) * final_xspeed_2 + Math.sin(collisionision_angle + Math.PI / 2) * final_yspeed_2;
	}
	
	/**
	 * This function is asking for foreach. 
	 * Alas, AS2 seems to be not foreach/forin-friendly
	 */
	private static function render():Void
	{
		var i:Number;
		var numBalls:Number = _balls.length;
		for (i = 0; i < numBalls; i++)
		{
			_balls[i].updatePosition();
		}
	}
	
	public static function addBall(ball:Ball):Void
	{
		_balls.push(ball);
	}
}