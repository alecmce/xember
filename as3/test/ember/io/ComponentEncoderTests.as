package ember.io
{
	import mocks.MockComponent;
	import mocks.MockPointComponent;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;

	import flash.geom.Point;

	
	public class ComponentEncoderTests
	{
		private var encoder:ComponentEncoder;
		
		[Before]
		public function before():void
		{
			var factory:ComponentConfigFactory = new ComponentConfigFactory();
			encoder = new ComponentEncoder(factory);
		}
		
		[After]
		public function after():void
		{
			encoder = null;
		}
		
		[Test]
		public function encodes_equivalent_components_equivalently():void
		{
			var a:MockComponent = new MockComponent();
			a.n = 5;
			
			var b:MockComponent = new MockComponent();
			b.n = 5;
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isTrue());
		}
		
		[Test]
		public function encodes_differentiable_components_unequivalently():void
		{
			var a:MockComponent = new MockComponent();
			a.n = 5;
			
			var b:MockComponent = new MockComponent();
			b.n = 6;
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isFalse());
		}
		
		[Test]
		public function decode_reverses_encode():void
		{
			var component:MockComponent = new MockComponent();
			component.n = 7;
			
			var object:Object = encoder.encode(component);
			var roundtrip:MockComponent = encoder.decode(object) as MockComponent;
		
			assertThat(roundtrip.n, equalTo(7));
		}
		
		[Test]
		public function encodes_similar_points_similarly():void
		{
			var a:MockPointComponent = new MockPointComponent();
			a.point = new Point(4, 5);
			
			var b:MockPointComponent = new MockPointComponent();
			b.point = new Point(4, 5);
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isTrue());
		}
		
		[Test]
		public function encodes_different_points_differently():void
		{
			var a:MockPointComponent = new MockPointComponent();
			a.point = new Point(3, 5);
			
			var b:MockPointComponent = new MockPointComponent();
			b.point = new Point(4, 5);
			
			assertThat(CompareVOs.objectsAreEquivalent(encoder.encode(a), encoder.encode(b)), isFalse());
		}
		
		[Test]
		public function roundtrips_point_encoding_correctly():void
		{
			var component:MockPointComponent = new MockPointComponent();
			component.point = new Point(3, 5);
			
			var object:Object = encoder.encode(component);
			var roundtrip:MockPointComponent = encoder.decode(object) as MockPointComponent;
		
			assertThat(component.point.equals(roundtrip.point), isTrue());
		}
		
	}
	
}
