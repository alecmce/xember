package tomsbunnies.ctrl
{
	import ember.core.Entity;
	import ember.core.EntitySystem;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.core.BitmapAsset;
	import org.robotlegs.mvcs.Command;
	import tomsbunnies.components.GraphicComponent;
	import tomsbunnies.components.SpatialComponent;





	public class CreateBunniesCommand extends Command
	{
		[Embed(source = "../assets/wabbit_alpha.png")]
		public const BunnyAsset:Class;
		
		private var _system:EntitySystem;
		
		private var _bunnyAsset:BitmapAsset;
		
		public function CreateBunniesCommand(system:EntitySystem)
		{
			_system = system;
		}

		override public function execute():void
		{
			_bunnyAsset = new BunnyAsset();
			
			var i:int = 5500;
			while (i--)
				createBunny();
		}

		private function createBunny():void
		{
			var entity:Entity = _system.createEntity();

			var graphics:GraphicComponent = new GraphicComponent();
			graphics.asset = _bunnyAsset.bitmapData;
			graphics.rect = new Rectangle(0, 0, 26, 37);

			var spatial:SpatialComponent = new SpatialComponent();
			spatial.position = new Point(100, 100);
			spatial.velocity = new Point(Math.random() * 10, (Math.random() * 10) - 5);

			entity.addComponent(graphics);
			entity.addComponent(spatial);
		}

	}
}
