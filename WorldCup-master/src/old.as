package 
{
	import com.gestureworks.cml.components.ImageViewer;
	import com.gestureworks.cml.core.CMLAir;
	import com.gestureworks.cml.core.CMLObjectList;
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.elements.Background;
	import com.gestureworks.cml.elements.Button;
	import com.gestureworks.cml.elements.Container;
	import com.gestureworks.cml.elements.Image;
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.interfaces.IList;
	import com.gestureworks.cml.layouts.RandomLayout;
	import com.gestureworks.cml.utils.ChildList;
	import com.gestureworks.cml.utils.LinkedMap;
	import com.gestureworks.core.CML;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.events.GWTouchEvent;
	import com.gestureworks.utils.CMLLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.sampler.NewObjectSample;
	import flash.utils.ByteArray;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import images.GWSplash;
	import flash.desktop.NativeApplication;

	import CircleTextElement; CircleTextElement;

	// load AIR classes
	CMLAir;
	/**
	 * ...
	 * @author dmreagan
	 */
	public class Main extends GestureWorks 
	{
		private var _telnetClient:Telnet;
		private var _numLayingOut:int = 0; // global variable to track number of collections presently in layout tween
		private var _organizing:Boolean = false;
		private var sheet:CML = new CML();
		public var img:Image = new Image();
		public var loader:Loader = new Loader();
		public var oldid:int = 1;
		public var flag:int = 1;
		public var count:int = 0;
		/**
		 * Parse the CML and GML files
		 */
		public function Main():void 
		{
			super();
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);			

			gml = "library/gml/gestures.gml";
			cml = "library/cml/main.cml";
		}

		/**
		 * 
		 * 
		 * Initialization Functions 
		 * 
		 */

		 /**
		 * gestureworksInit
		 */
		override protected function gestureworksInit():void {
			trace("gestureWorksInit()");
		}

		/**
		 * Initialize items not specified in CML
		 * @param	e
		 */
		private function cmlInit(e:Event):void {
				trace("cmlInit()");
				var auxDisplay:String = CMLParser.cmlData.attribute("auxDisplay");
			if (flag == 1)
			{
			if (auxDisplay == "sos" || auxDisplay == "sosEmulator")
			{
				telnetInit();
				trace("call teleet Init");
				sphereButtonsInit();
				trace("call sphere Init");
				flag = 2;
			}
			}
			else {
				if (auxDisplay == "sos" || auxDisplay == "sosEmulator")
			{
				sphereButtonsInit();
				trace("call sphere Init");
			}
			}
			
			//buttonsInit();
		}

		/**
		 * Initialize the tcp connection
		 */
		private function telnetInit():void
		{
			//addEventListener("tcpConnectionError", tcpConnectionErrorHandler);
			trace("telnetInit()");
			var telnetServer:String;
			var telnetPort:int;

			if ((telnetServer = CMLParser.cmlData.attribute("server")) && (telnetPort = int(CMLParser.cmlData.attribute("port"))))
			{
				_telnetClient = new Telnet(telnetServer, telnetPort);
				trace("telnetInit() 1");
			}
			else
			{
				trace("Error reading telnetServer and/or telnetPort from CML!");
				errorPopup("Error reading telnetServer and/or telnetPort from CML!");
			}
		}

		/**
		 * Add event listeners for the sphere buttons
		 */
		public var i:int = 0;
		private function sphereButtonsInit():void
		{
			trace("SphereInit()");
			var sphereButtons:LinkedMap = CMLObjectList.instance.getCSSClass("btn_sphere");
			for each (var button:Button in sphereButtons)
			{
				button.addEventListener(StateEvent.CHANGE, sphereButtonHandler);
			}
		}

		/**
		 * 
		 * 
		 * Event Handler Functions 
		 * 
		 */

		/**
		 * When a sphere button is pressed, tell the sphere to play the corresponding dataset
		 * @param	event
		 */
		private function sphereButtonHandler(event:StateEvent):void
		{
			var id:String = event.target.id;
			var ba:ByteArray = new ByteArray();
			if (count > 11)
			{
				NativeApplication.nativeApplication.exit();
			}
			count = count + 1;
			if (id == "21")
			{
				var newid:String;
		    if (oldid == 20)
			{
				 newid= String(1);	
			}
			else
			{
			oldid = oldid + 1;
			newid = String(oldid);
			}
			var auxDisplay:String = CMLParser.cmlData.attribute("auxDisplay");
			trace (auxDisplay);

			if (auxDisplay == "sos")
			{
				var playlist:String = CMLParser.cmlData.attribute("playlist");

				// make sure autorun is disabled
				ba.writeMultiByte("set_auto_presentation_mode 0\n", "UTF-8");
				_telnetClient.writeBytesToSocket(ba);
				ba.clear();

				// make sure the correct playlist is active
				ba.writeMultiByte("open_playlist " + playlist + "\n", "UTF-8");
				_telnetClient.writeBytesToSocket(ba);
				ba.clear();

				// play the clip
				ba.writeMultiByte("play " + newid + "\n", "UTF-8");

				trace(id);
			}
			else if (auxDisplay == "sosEmulator")
			{
				ba.writeMultiByte(newid, "UTF-8"); // emulator requires id alone
			}


			_telnetClient.writeBytesToSocket(ba);
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);	
			cml = "library/cml/" + newid + ".cml";
			}
			
			else if (id == "22")
			{
				var newid:String;
		    if (oldid == 1)
			{
				 newid= String(20);	
			}
			else
			{
			oldid = oldid - 1;
			newid = String(oldid);
			}
			var auxDisplay:String = CMLParser.cmlData.attribute("auxDisplay");
			trace (auxDisplay);

			if (auxDisplay == "sos")
			{
				var playlist:String = CMLParser.cmlData.attribute("playlist");

				// make sure autorun is disabled
				ba.writeMultiByte("set_auto_presentation_mode 0\n", "UTF-8");
				_telnetClient.writeBytesToSocket(ba);
				ba.clear();

				// make sure the correct playlist is active
				ba.writeMultiByte("open_playlist " + playlist + "\n", "UTF-8");
				_telnetClient.writeBytesToSocket(ba);
				ba.clear();

				// play the clip
				ba.writeMultiByte("play " + newid + "\n", "UTF-8");

				trace(id);
			}
			else if (auxDisplay == "sosEmulator")
			{
				ba.writeMultiByte(newid, "UTF-8"); // emulator requires id alone
			}


			_telnetClient.writeBytesToSocket(ba);
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);	
			cml = "library/cml/" + newid + ".cml";
			}
			
			else
			{
			var auxDisplay:String = CMLParser.cmlData.attribute("auxDisplay");
			trace (auxDisplay);
            var newid:String=id;
			if (auxDisplay == "sos")
			{
				var playlist:String = CMLParser.cmlData.attribute("playlist");

				// make sure autorun is disabled
				ba.writeMultiByte("set_auto_presentation_mode 0\n", "UTF-8");
				_telnetClient.writeBytesToSocket(ba);
				ba.clear();

				// make sure the correct playlist is active
				ba.writeMultiByte("open_playlist " + playlist + "\n", "UTF-8");
				_telnetClient.writeBytesToSocket(ba);
				ba.clear();

				// play the clip
				ba.writeMultiByte("play " + newid + "\n", "UTF-8");

				trace(id);
			}
			else if (auxDisplay == "sosEmulator")
			{
				ba.writeMultiByte(newid, "UTF-8"); // emulator requires id alone
			}


			_telnetClient.writeBytesToSocket(ba);
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);	
			cml = "library/cml/" + newid + ".cml";	
			}
			oldid = int(newid);

			// TODO
			// show info panel?

			// display some kind of on-sphere message?

			// change button appearance?

		}
		
		
		private function loaderCompleteHandler(event:Event):void 
		{
			trace("load complete");
			//img.visible = false;
			
		}
		/**
		 * Show error popup with description.
		 * @param	message
		 */
		private function errorPopup(message:String):void 
		{
			var error:Container = CMLObjectList.instance.getId("error");
			var errorDescription:Text = CMLObjectList.instance.getId("error_description");

			errorDescription.text += message;
			sendToTop(error);
			error.visible = true;
		}



		/**
		 * 
		 * 
		 * Utility Functions 
		 * 
		 */

		/**
		 * Send the object to the top of its container
		 * @param	object
		 */
		private function sendToTop(object:*):void
		{
			object.parent.setChildIndex(object, object.parent.numChildren - 1);
		}

		/**
		 * Send the object to the bottom of its container
		 * @param	object
		 */
		private function sendToBottom(object:*):void
		{
			object.parent.setChildIndex(object, 0);
		}

		/**
		 * Sets the registration point of a display object to a point other than (0,0)
		 * modified from http://theflashconnection.com/content/how-to-change-registration-point-as3
		 * @param	obj
		 * @param	newX
		 * @param	newY
		 */
		private function setRegPoint(obj:DisplayObjectContainer, newX:Number, newY:Number):void 
		{
			//get the bounds of the object and the location 
			//of the current registration point in relation
			//to the upper left corner of the graphical content
			//note: this is a PSEUDO currentRegX and currentRegY, as the 
			//registration point of a display object is ALWAYS (0, 0):
			var bounds:Rectangle = obj.getBounds(obj.parent);
			var currentRegX:Number = obj.x - bounds.left;
			var currentRegY:Number = obj.y - bounds.top;
			var scale:Number = obj.scaleX; // assume object is scaled uniformly

			var xOffset:Number = newX - currentRegX;
			var yOffset:Number = newY - currentRegY;
			//shift the object to its new location--
			//this will put it back in the same position
			//where it started (that is, VISUALLY anyway):
			obj.x += xOffset;
			obj.y += yOffset;

			//shift all the children the same amount,
			//but in the opposite direction
			for (var i:int = 0; i < obj.numChildren; i++) 
			{
				//obj.getChildAt(i).x -= xOffset;
				//obj.getChildAt(i).y -= yOffset;
				obj.getChildAt(i).x -= xOffset / scale;
				obj.getChildAt(i).y -= yOffset / scale;
			}
		}

	}

}