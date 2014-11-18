package  
{
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.cml.elements.Container;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author dmreagan
	 */
	public class CircleTextElement extends Container 
	{
		private var _textX:Number = 960;
		private var _textY:Number = 540;
		private var _radius:Number = 175;
		private var _coverage:Number = 1;
		private var _startAngle:Number = 100;
		private var _stopAngle:Number = 100;
		private var _text:String = "Text";
		private var _color:uint = 0xFFFFFF;
		private var _fontSize:Number = 50;
		private var _font:String = "OpenSansBold";
		private var _angle:Number = 180;
		
		
		
		
		
		/**
		 * Constructor
		 */
		public function CircleTextElement() 
		{
			super();
		}
		
		override public function init():void 
		{
			super.init();
			
			createCircleText();
		}
		
		/**
		 * 
		 */
		private function createCircleText():void 
		{
			var letters:Array = _text.split("");
      var step:Number = _angle / (letters.length - 1);
      step = step * Math.PI / 180;
                        
      for (var s:int = 0; s < letters.length; s++)
      {
        var letter:Text = createText(letters[s].toString());
        letter.x = _radius * Math.cos(step * s);
        letter.y = _radius * Math.sin(step * s);
        letter.rotation = (step * s) * 180 / Math.PI + 90;
        this.addChild(letter);
      }
		}
		
		
		
		
		
		/**
		 * 
		 * @param	value
		 * @return
		 */
		private function createText(value:String):Text
    {
      var letter:Text = new Text();
			letter.color = _color;
			letter.fontSize = _fontSize;
			letter.font = _font;
			letter.text = value;
			letter.selectable = false;
			
			return letter;
    }
		
		
		/**
		 * Getters and setters
		 */
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
		}
		
		public function get color():uint 
		{
			return _color;
		}
		
		public function set color(value:uint):void 
		{
			_color = value;
		}
		
		public function get fontSize():Number 
		{
			return _fontSize;
		}
		
		public function set fontSize(value:Number):void 
		{
			_fontSize = value;
		}
		
		public function get font():String 
		{
			return _font;
		}
		
		public function set font(value:String):void 
		{
			_font = value;
		}
		
		public function get angle():Number 
		{
			return _angle;
		}
		
		public function set angle(value:Number):void 
		{
			_angle = value;
		}
		
	}

}