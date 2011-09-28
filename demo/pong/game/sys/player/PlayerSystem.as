package pong.game.sys.player
{
	import Box2D.Common.Math.b2Vec2;

	import ember.EntitySystem;
	import ember.Nodes;

	import pong.game.Tick;
	import pong.game.attr.PlayerComponent;

	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class PlayerSystem
	{
		[Inject]
		public var view:DisplayObjectContainer;
		
		[Inject]
		public var system:EntitySystem;
		
		[Inject]
		public var tick:Tick;
		
		private var stage:Stage;
		
		private var isLeft:Boolean;
		private var isUp:Boolean;
		private var isRight:Boolean;
		private var isDown:Boolean;
		
		private var velocity:b2Vec2;
		
		private var _nodes:Nodes;
		
		public function onRegister():void
		{
			tick.add(iterate);
			
			stage = view.stage;
			stage.focus = stage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			velocity = new b2Vec2();
			
			_nodes = system.getNodes(PlayerNode);
		}

		public function onRemove():void
		{
			tick.remove(iterate);

			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyDown(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			
			if (code == 37)
				isLeft = true;
			else if (code == 38)
				isUp = true;
			else if (code == 39)
				isRight = true;
			else if (code == 40)
				isDown = true;
		}

		private function onKeyUp(event:KeyboardEvent):void
		{
			var code:uint = event.keyCode;
			
			if (code == 37)
				isLeft = false;
			else if (code == 38)
				isUp = false;
			else if (code == 39)
				isRight = false;
			else if (code == 40)
				isDown = false;
		}
		
		private function iterate():void
		{
			for (var node:PlayerNode = _nodes.head; node; node = node.next)
			{
				var player:PlayerComponent = node.player;
				
				velocity.x = 0;
				velocity.y = 0;
				
				if (isLeft)
					velocity.x -= player.dx;
					
				if (isRight)
					velocity.x += player.dx;
				
				if (isUp)
					velocity.y -= player.dy;
				
				if (isDown)
					velocity.y += player.dy;
				
				node.physical.body.SetLinearVelocity(velocity);
			}
		}
		
	}
}
