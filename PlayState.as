package
{
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		private var snake:FlxGroup;  // Group containing snake parst
		private var head:FlxSprite;  // The head of the snake
		private var fruits:FlxGroup; // Group contining fruits
		private var direction:uint;  // Direction the snake is going

		public var updateRate:Number = 2;
		private var timer:Number = 1;

		override public function create():void
		{
			FlxG.watch(this, "updateRate");
			//initialize the groups
			snake = new FlxGroup();
			fruits = new FlxGroup();

			//create snake parts:
			for (var i:uint; i <= 10; ++i)
			{
				var part:FlxSprite = new FlxSprite().makeGraphic(8,8, 0xffffffff);
				part.kill();
				snake.add(part);
			}
			//create some fruits
			for (i = 0; i <= 10; ++i)
			{
				var fruit:FlxSprite = new FlxSprite().makeGraphic(8,8, 0xFFFF0000);
				fruit.kill();
				fruits.add(fruit);
			}

			// set the head of the snake
			head = snake.getFirstDead() as FlxSprite;
			// put the head in the center of the screen
			head.reset(FlxG.width/2, FlxG.height/2);

			add(snake);
			add(fruits);

			direction = 0; //initialize the direction to RIGHT
		}

		override public function update():void
		{
			// Controls
			if (FlxG.keys.justPressed("UP") && direction != 1 ) direction = 3;
			if (FlxG.keys.justPressed("DOWN") && direction != 3) direction = 1;
			if (FlxG.keys.justPressed("RIGHT") && direction != 2) direction = 0;
			if (FlxG.keys.justPressed("LEFT") && direction != 0) direction = 2;

			timer -= FlxG.elapsed * updateRate; //update the timer

			if(timer <= 0)
			{
				var nHead:FlxSprite = snake.getFirstDead() as FlxSprite; // Get the next head part
				if (!nHead)
				{
					// If there's no dead parts, get a random part from the snake
					nHead = snake.getRandom() as FlxSprite; 
				}
				switch(direction)
				{
					case 0: nHead.reset(head.x + 9, head.y); break; // Go Right
					case 1: nHead.reset(head.x, head.y + 9); break; // Go Down
					case 2: nHead.reset(head.x - 9, head.y); break; // Go Left
					case 3: nHead.reset(head.x, head.y - 9); break; // Go Up
					default: break;
				}
				//check if head is out of screen
				if (nHead.x >= FlxG.width) nHead.x = 0;
				if (nHead.x < 0) nHead.x = FlxG.width -1;
				if (nHead.y >= FlxG.height) nHead.y = 0;
				if (nHead.y < 0) nHead.y = FlxG.height -1;

				head = nHead; // Change the head to next Head
				timer = 1; // Reset the timer

				if (FlxG.random() * 100 > 85) // Add some fruits sometimes
				{
					var f:FlxSprite = fruits.getFirstDead()as FlxSprite;
					f.reset(FlxG.random() * FlxG.width, FlxG.random() * FlxG.height);
				}
			}
			

			if (FlxG.overlap(head, snake)) //Check collisions with the snake body
				FlxG.switchState(new PlayState);
			FlxG.overlap(head, fruits, onFruitGet) // check collision with fruits

			super.update();

		}
		
		private function onFruitGet(head:FlxSprite, fruit:FlxSprite):void
		{
			// increase the update rate
			updateRate += 0.5;
			// Add some snake parts to the snake
			for (var i:uint; i <= 5; ++i)
			{
				var part:FlxSprite = new FlxSprite().makeGraphic(8,8, 0xffffffff);
				part.kill();
				snake.add(part);
			}

			fruit.kill();
		}
	}
}
