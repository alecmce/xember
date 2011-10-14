package net.richardlord.asteroidsember.systems
{
	import ember.core.Game;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.components.Display;
	import net.richardlord.asteroidsember.components.Position;
	import net.richardlord.asteroidsember.nodes.RenderNode;
	import net.richardlord.asteroidsember.signals.Render;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public class RenderSystem
	{
		[Inject]
		public var contextView:DisplayObjectContainer;

		[Inject]
		public var game:Game;

		[Inject]
		public var tick:Render;

		private var family:Nodes;

		public function onRegister():void
		{
			family = game.getNodes(RenderNode);
			tick.add(render);
		}

		public function render():void
		{
			var node:RenderNode;
			var position:Position;
			var display:Display;
			var displayObject:DisplayObject;

			for (node = family.head as RenderNode; node; node = node.next)
			{
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;

				if ( !displayObject.parent )
				{
					contextView.addChild(displayObject);
				}
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation * 180 / Math.PI;
			}
		}

		public function dispose():void
		{
			tick.remove(render);
		}
	}
}
