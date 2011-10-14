package net.richardlord.asteroidsember.systems
{
	import ember.core.Game;
	import ember.core.Nodes;

	import net.richardlord.asteroidsember.game.EntityCreator;
	import net.richardlord.asteroidsember.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroidsember.nodes.BulletCollisionNode;
	import net.richardlord.asteroidsember.nodes.SpaceshipCollisionNode;
	import net.richardlord.asteroidsember.signals.ResolveCollisions;

	import flash.geom.Point;

	public class CollisionSystem
	{
		[Inject]
		public var game:Game;

		[Inject]
		public var entityCreator:EntityCreator;

		[Inject]
		public var tick:ResolveCollisions;

		private var spaceships:Nodes;
		private var asteroids:Nodes;
		private var userBullets:Nodes;

		public function onRegister():void
		{
			spaceships = game.getNodes(SpaceshipCollisionNode);
			asteroids = game.getNodes(AsteroidCollisionNode);
			userBullets = game.getNodes(BulletCollisionNode);

			tick.add(update);
		}

		private function update(time:Number):void
		{
			var bullet:BulletCollisionNode;
			var asteroid:AsteroidCollisionNode;
			var spaceship:SpaceshipCollisionNode;

			for (bullet = userBullets.head as BulletCollisionNode; bullet; bullet = bullet.next)
			{
				for (asteroid = asteroids.head as AsteroidCollisionNode; asteroid; asteroid = asteroid.next)
				{
					if ( Point.distance(asteroid.position.position, bullet.position.position) <= asteroid.position.collisionRadius )
					{
						entityCreator.destroyEntity(bullet.entity);
						if ( asteroid.position.collisionRadius > 10 )
						{
							entityCreator.createAsteroid(asteroid.position.collisionRadius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5);
							entityCreator.createAsteroid(asteroid.position.collisionRadius - 10, asteroid.position.position.x + Math.random() * 10 - 5, asteroid.position.position.y + Math.random() * 10 - 5);
						}
						entityCreator.destroyEntity(asteroid.entity);
						break;
					}
				}
			}

			for (spaceship = spaceships.head as SpaceshipCollisionNode; spaceship; spaceship = spaceship.next)
			{
				for (asteroid = asteroids.head as AsteroidCollisionNode; asteroid; asteroid = asteroid.next)
				{
					var distance:Number = Point.distance(asteroid.position.position, spaceship.position.position);
					var sumRadii:Number = asteroid.position.collisionRadius + spaceship.position.collisionRadius;
					
					if ( distance <= sumRadii )
					{
						entityCreator.destroyEntity(spaceship.entity);
						break;
					}
				}
			}
		}

		public function dispose():void
		{
			tick.remove(update);
		}
	}
}
