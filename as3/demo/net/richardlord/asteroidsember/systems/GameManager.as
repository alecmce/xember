package net.richardlord.asteroidsember.systems
{
	import ember.core.Ember;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.components.GameState;
	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroidsember.nodes.BulletCollisionNode;
	import net.richardlord.asteroidsember.nodes.SpaceshipCollisionNode;
	import net.richardlord.asteroidsember.signals.PreUpdate;

	import flash.geom.Point;

	public class GameManager
	{
		[Inject]
		public var game:Ember;

		[Inject]
		public var entityCreator:EntityCreator;

		[Inject]
		public var gameState:GameState;

		[Inject]
		public var tick:PreUpdate;

		private var spaceships:Nodes;
		private var asteroids:Nodes;
		private var bullets:Nodes;

		public function onRegister():void
		{
			spaceships = game.getNodes(SpaceshipCollisionNode);
			asteroids = game.getNodes(AsteroidCollisionNode);
			bullets = game.getNodes(BulletCollisionNode);
			tick.add(update);
		}

		private function update():void
		{
			if ( spaceships.count == 0 )
			{
				if ( gameState.lives > 0 )
				{
					var newSpaceshipPosition:Point = new Point(gameState.width * 0.5, gameState.height * 0.5);
					var clearToAddSpaceship:Boolean = true;

					for (var asteroid:AsteroidCollisionNode = asteroids.head as AsteroidCollisionNode; asteroid; asteroid = asteroid.next)
					{
						if ( Point.distance(asteroid.position.position, newSpaceshipPosition) <= asteroid.position.collisionRadius + 50 )
						{
							clearToAddSpaceship = false;
							break;
						}
					}
					if ( clearToAddSpaceship )
					{
						entityCreator.createSpaceship();
						gameState.lives--;
					}
				}
				else
				{
					// game over
				}
			}

			if ( asteroids.count == 0 && bullets.count == 0 && !spaceships.count == 0 )
			{
				// next level
				var spaceship:SpaceshipCollisionNode = spaceships.head as SpaceshipCollisionNode;
				gameState.level++;
				var asteroidCount:int = 2 + gameState.level;
				for ( var i:int = 0; i < asteroidCount; ++i )
				{
					// check not on top of spaceship
					do
					{
						var position:Point = new Point(Math.random() * gameState.width, Math.random() * gameState.height);
					}
					while ( Point.distance(position, spaceship.position.position) <= 80 );
					entityCreator.createAsteroid(30, position.x, position.y);
				}
			}
		}

		public function dispose():void
		{
			tick.remove(update);
		}
	}
}
