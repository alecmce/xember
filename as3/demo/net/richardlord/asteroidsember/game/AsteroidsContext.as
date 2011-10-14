package net.richardlord.asteroidsember.game
{
	import ember.core.Ember;

	import net.richardlord.asteroidsember.components.GameState;
	import net.richardlord.asteroidsember.signals.Move;
	import net.richardlord.asteroidsember.signals.PreUpdate;
	import net.richardlord.asteroidsember.signals.Render;
	import net.richardlord.asteroidsember.signals.ResolveCollisions;
	import net.richardlord.asteroidsember.signals.Update;
	import net.richardlord.asteroidsember.systems.BulletAgeSystem;
	import net.richardlord.asteroidsember.systems.CollisionSystem;
	import net.richardlord.asteroidsember.systems.GameManager;
	import net.richardlord.asteroidsember.systems.GunControlSystem;
	import net.richardlord.asteroidsember.systems.MotionControlSystem;
	import net.richardlord.asteroidsember.systems.MovementSystem;
	import net.richardlord.asteroidsember.systems.ProcessManager;
	import net.richardlord.asteroidsember.systems.RenderSystem;
	import net.richardlord.utils.KeyPoll;

	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	public class AsteroidsContext extends Context
	{
		
		private var game:Ember;
		
		public function AsteroidsContext(view:DisplayObjectContainer = null)
		{
			super(view);
		}
		
		override public function startup():void
		{
			injector.mapValue(Ember, game = new Ember(injector));
			injector.mapSingleton(EntityCreator);
			injector.mapSingleton(PreUpdate);
			injector.mapSingleton(Update);
			injector.mapSingleton(Move);
			injector.mapSingleton(ResolveCollisions);
			injector.mapSingleton(Render);
			injector.mapValue(KeyPoll, new KeyPoll(contextView.stage));
			
			injector.mapValue(GameState, generateGameState());

			addSystems();
		}

		private function generateGameState():GameState
		{
			var state:GameState = new GameState();
			
			state.level = 0;
			state.lives = 3;
			state.points = 0;
			state.width = contextView.stage.stageWidth;
			state.height = contextView.stage.stageHeight;
			
			return state;
		}
		
		private function addSystems():void
		{
			game.addSystem(GameManager);
			game.addSystem(MotionControlSystem);
			game.addSystem(GunControlSystem);
			game.addSystem(BulletAgeSystem);
			game.addSystem(MovementSystem);
			game.addSystem(CollisionSystem);
			game.addSystem(RenderSystem);
			game.addSystem(ProcessManager);
		}

	}
}
