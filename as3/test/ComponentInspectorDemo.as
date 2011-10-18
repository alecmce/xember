package
{
	import ember.inspector.ComponentInspector;
	import ember.inspector.ComponentInspectorFactory;
	import ember.io.ComponentConfigFactory;

	import mocks.MockAllNativeTypesComponent;

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="800", height="600")]
	public class ComponentInspectorDemo extends Sprite
	{
		private var component:MockAllNativeTypesComponent;
		private var a:ComponentInspector;
		private var b:ComponentInspector;
		
		private var timer:Timer;
		
		public function ComponentInspectorDemo()
		{
			component = new MockAllNativeTypesComponent();
			component.int_value = -1;
			component.uint_value = 3;
			component.Number_value = 5.123;
			component.String_value = "hello world";
			component.Boolean_value = true;
			component.point = new Point(30, 30);
			
			var configs:ComponentConfigFactory = new ComponentConfigFactory();
			var factory:ComponentInspectorFactory = new ComponentInspectorFactory(configs);
			
			a = factory.getInspector(component);
			a.self.x = 20;
			a.self.y = 20;
			addChild(a.self);
			
			b = factory.getInspector(component);
			b.self.x = 320;
			b.self.y = 20;
			addChild(b.self);
			
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}

		private function onTimer(event:TimerEvent):void
		{
			a.update();
			b.update();
		}

	}
}
