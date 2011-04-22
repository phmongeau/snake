package
{
	public class SnakePart extends FlxSprite
	{
		private var timer:Number;
		public function SnakePart(x:Number, y:Number):void
		{
			super(x,y);
			makeGraphic(8,8,0xffffffff);
		}
	}
}
