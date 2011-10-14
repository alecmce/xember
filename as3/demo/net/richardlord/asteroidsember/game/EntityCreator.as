package net.richardlord.asteroidsember.game
{
	import ember.core.Game;
	import ember.core.Entity;

	import net.richardlord.asteroidsember.components.*;
	import net.richardlord.asteroidsember.graphics.AsteroidView;
	import net.richardlord.asteroidsember.graphics.BulletView;
	import net.richardlord.asteroidsember.graphics.SpaceshipView;

	import flash.ui.Keyboard;

	public class EntityCreator
	{
		[Inject]
		public var game:Game;

		public function destroyEntity(entity:Entity):void
		{
			var display:Display = entity.getComponent(Display) as Display;
			display.displayObject.parent.removeChild(display.displayObject);
			game.removeEntity(entity);
		}

		public function createAsteroid(radius:Number, x:Number, y:Number):Entity
		{
			var asteroid:Entity = game.createEntity();

			asteroid.addComponent(new Asteroid());

			var position:Position = new Position();
			position.position.x = x;
			position.position.y = y;
			position.collisionRadius = radius;
			asteroid.addComponent(position);

			var motion:Motion = new Motion();
			motion.angularVelocity = Math.random() * 2 - 1;
			motion.velocity.x = ( Math.random() - 0.5 ) * 4 * ( 50 - radius );
			motion.velocity.y = ( Math.random() - 0.5 ) * 4 * ( 50 - radius );
			asteroid.addComponent(motion);

			var display:Display = new Display();
			display.displayObject = new AsteroidView(radius);
			asteroid.addComponent(display);

			return asteroid;
		}

		public function createSpaceship():Entity
		{
			var spaceship:Entity = game.createEntity();

			spaceship.addComponent(new Spaceship());

			var position:Position = new Position();
			position.position.x = 300;
			position.position.y = 225;
			position.collisionRadius = 6;
			spaceship.addComponent(position);

			var motion:Motion = new Motion();
			motion.damping = 15;
			spaceship.addComponent(motion);

			var motionControls:MotionControls = new MotionControls();
			motionControls.left = Keyboard.LEFT;
			motionControls.right = Keyboard.RIGHT;
			motionControls.accelerate = Keyboard.UP;
			motionControls.accelerationRate = 100;
			motionControls.rotationRate = 3;
			spaceship.addComponent(motionControls);

			var gun:Gun = new Gun();
			gun.minimumShotInterval = 0.3;
			gun.offsetFromParent.x = 8;
			gun.offsetFromParent.y = 0;
			gun.bulletLifetime = 2;
			spaceship.addComponent(gun);

			var gunControls:GunControls = new GunControls();
			gunControls.trigger = Keyboard.SPACE;
			spaceship.addComponent(gunControls);

			var display:Display = new Display();
			display.displayObject = new SpaceshipView();
			spaceship.addComponent(display);

			return spaceship;
		}
  
		public function createUserBullet(gun:Gun, parentPosition:Position):Entity
		{
			var bullet:Entity = game.createEntity();

			var userBullet:Bullet = new Bullet();
			userBullet.lifeRemaining = gun.bulletLifetime;
			bullet.addComponent(userBullet);

			var cos:Number = Math.cos(parentPosition.rotation);
			var sin:Number = Math.sin(parentPosition.rotation);

			var bulletPosition:Position = new Position();
			bulletPosition.position.x = cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x;
			bulletPosition.position.y = sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y;
			bullet.addComponent(bulletPosition);

			var motion:Motion = new Motion();
			motion.velocity.x = cos * 150;
			motion.velocity.y = sin * 150;
			bullet.addComponent(motion);

			var display:Display = new Display();
			display.displayObject = new BulletView();
			bullet.addComponent(display);

			return bullet;
		}
	}
}
