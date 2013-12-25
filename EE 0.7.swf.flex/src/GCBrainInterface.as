package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import gc.utils.*;
    
    public class GCBrainInterface extends Object
    {
        public function GCBrainInterface(arg1:flash.display.Stage)
        {
            super();
            _stage = arg1;
            _container = new flash.display.Sprite();
            _container.addEventListener(flash.events.Event.ENTER_FRAME, onFrameEntered);
            _stage.addChild(_container);
            flash.system.Security.allowDomain("*");
            flash.system.Security.allowInsecureDomain("*");
            trace("[GC-API] Games Chart v." + GamesChart.VERSION);
            _lcID = Math.random() * 10000;
            loadBrain();
            startLC();
            return;
        }

        public function begin(arg1:String):void
        {
            sendNotification(GCNotificationTypes.BEGIN_LOAD, {"gameIDHash":arg1, "apiType":apiType, "apiVersion":GamesChart.VERSION, "swfURL":getURL()});
            return;
        }

        public function onGCEvent(arg1:String, arg2:Object):void
        {
            if (GamesChart.onGCEvent != null) 
            {
                GamesChart.onGCEvent.apply(null, [arg1, arg2]);
            }
            return;
        }

        private function getURL():String
        {
            var pageURL:String;

            var loc1:*;
            pageURL = null;
            try 
            {
                pageURL = String(flash.external.ExternalInterface.call("window.location.href.toString"));
                if (pageURL == "null") 
                {
                    return _container.stage.loaderInfo.url;
                }
                return pageURL;
            }
            catch (e:Error)
            {
            };
            return _container.stage.loaderInfo.url;
        }

        private function onFrameEntered(arg1:flash.events.Event):void
        {
            if (!_stage.contains(_container)) 
            {
                _stage.addChild(_container);
            }
            else if (_stage.getChildIndex(_container) != _stage.numChildren - 1) 
            {
                _stage.setChildIndex(_container, _stage.numChildren - 1);
            }
            return;
        }

        private function onFinishedLoading(arg1:flash.events.Event):void
        {
            _brainLoaded = true;
            trace("[GC-API] Brain Loaded!");
            return;
        }

        public function sendNotification(arg1:String, arg2:Object, arg3:String=""):void
        {
            if (_conn.connected) 
            {
                _conn.send("sendNotification", arg1, arg2, arg3);
            }
            else 
            {
                _notificationBuffer.push({"name":arg1, "body":arg2, "type":arg3});
            }
            return;
        }

        private function loadBrain():void
        {
            _brainLoaded = false;
            _brainLoader = new flash.display.Loader();
            _brainLoader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onFinishedLoading);
            _brainLoader.load(new flash.net.URLRequest(BRAIN_URL + "?r=" + _lcID));
            _container.addChild(_brainLoader);
            trace("[GC-API] Loading Brain.. ");
            return;
        }

        private function startLC():void
        {
            _notificationBuffer = [];
            _conn = new gc.utils.GCSWFConnection("_GamesChartLC" + _lcID, this, GamesChart.VERSION);
            _conn.addEventListener(gc.utils.GCSWFConnection.CONNECTED, onLCConnected);
            return;
        }

        private function onLCConnected(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            trace("[GC-API] API Connected to Brain!");
            while (_notificationBuffer.length > 0) 
            {
                loc1 = _notificationBuffer.pop();
                sendNotification(loc1.name, loc1.body, loc1.type);
            }
            return;
        }

        
        {
            BRAIN_URL = "http://gameschart.com/flash_client/getBrain.php";
            apiType = "AS3-API";
        }

        private var _lcID:int;

        private var _container:flash.display.Sprite;

        private var _notificationBuffer:Array;

        private var _conn:gc.utils.GCSWFConnection;

        private var _brainLoader:flash.display.Loader;

        private var _brainLoaded:Boolean;

        private var _stage:flash.display.Stage;

        public static var apiType:String="AS3-API";

        private static var BRAIN_URL:String="http://gameschart.com/flash_client/getBrain.php";
    }
}
