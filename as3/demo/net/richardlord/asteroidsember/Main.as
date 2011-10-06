package net.richardlord.asteroidsember
{
	import flash.display.Sprite;

	import net.richardlord.asteroidsember.game.AsteroidsContext;

	[SWF(width='600', height='450', frameRate='60', backgroundColor='#000000')]

	public class Main extends Sprite
	{
		private var asteroids:AsteroidsContext;

		public function Main()
		{
			asteroids = new AsteroidsContext(this);
		}
	}
}
