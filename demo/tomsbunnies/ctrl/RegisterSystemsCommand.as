package tomsbunnies.ctrl
{
	import ember.EntitySystem;
	import org.robotlegs.mvcs.Command;
	import tomsbunnies.systems.BounceSystem;
	import tomsbunnies.systems.ProcessManager;
	import tomsbunnies.systems.RenderSystem;
	import tomsbunnies.systems.nodes.RendererNode;
	import tomsbunnies.systems.nodes.SpatialNode;


	
	public class RegisterSystemsCommand extends Command
	{

		private var _system:EntitySystem;

		public function RegisterSystemsCommand(sytem:EntitySystem)
		{
			_system = sytem;
		}
		
		override public function execute():void
		{
			_system.addSystem(RenderSystem, RendererNode);			
			_system.addSystem(BounceSystem, SpatialNode);
			_system.addSystem(ProcessManager);
		}
		
	}
}
