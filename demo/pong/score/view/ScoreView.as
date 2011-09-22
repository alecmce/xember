package pong.score.view
{
	import fonts.helvetica;

	import flash.display.Sprite;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ScoreView extends Sprite
	{
		private var _rightText:TextField;
		private var _leftText:TextField;

		private var _left:uint;
		private var _right:uint;
		
		public function ScoreView()
		{
			Font.registerFont(helvetica);
			
			addChild(_leftText = generateLeftTextField());
			addChild(_rightText = generateRightTextField());
			
			_leftText.text = "0";
			_rightText.text = "0";
		}
		
		public function get left():uint
		{
			return _left;
		}

		public function set left(left:uint):void
		{
			_left = left;
			_leftText.text = left.toString();
		}

		public function get right():uint
		{
			return _right;
		}

		public function set right(right:uint):void
		{
			_right = right;
			_rightText.text = right.toString();
		}
		
		private function generateLeftTextField():TextField
		{
			var format:TextFormat = new TextFormat();
			format.font = "Helvetica";
			format.size = 300;
			format.align = TextFormatAlign.RIGHT;
			format.color = 0xFF1E90FF;

			var tf:TextField = new TextField();
			tf.y = 50;
			tf.width = 380;
			tf.height = 500;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.defaultTextFormat = format;
			tf.setTextFormat(format);
			
			return tf;
		}
		
		private function generateRightTextField():TextField
		{
			var format:TextFormat = new TextFormat();
			format.font = "Helvetica";
			format.size = 300;
			format.align = TextFormatAlign.LEFT;
			format.color = 0xFFFF0000;

			var tf:TextField = new TextField();
			tf.x = 420;
			tf.y = 50;
			tf.width = 380;
			tf.height = 500;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.defaultTextFormat = format;
			tf.setTextFormat(format);
			
			return tf;
		}
		
	}
}
