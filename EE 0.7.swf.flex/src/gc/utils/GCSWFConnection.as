package gc.utils 
{
    import flash.events.*;
    import flash.net.*;
    
    public class GCSWFConnection extends flash.events.EventDispatcher
    {
        public function GCSWFConnection(arg1:String, arg2:Object, arg3:String="unknown")
        {
            var version:String="unknown";
            var connectionID:String;
            var client:Object;

            var loc1:*;
            connectionID = arg1;
            client = arg2;
            version = arg3;
            super();
            _connected = false;
            _host = true;
            _queuedMessages = [];
            _close = false;
            _client = client;
            _version = version;
            _baseID = connectionID.split(":").join("");
            _lc = new flash.net.LocalConnection();
            _lc.allowDomain("*");
            _lc.allowInsecureDomain("*");
            _lc.client = this;
            _lc.addEventListener(flash.events.StatusEvent.STATUS, onStatus);
            try 
            {
                _lc.connect(_baseID + "_HOST");
            }
            catch (e:ArgumentError)
            {
                _host = false;
            }
            _myID = _baseID + (_host ? "_HOST" : "_CLIENT");
            _extID = _baseID + (_host ? "_CLIENT" : "_HOST");
            if (!_host) 
            {
                try 
                {
                    _lc.connect(_myID);
                }
                catch (e:ArgumentError)
                {
                    trace("[" + _logName + "] [GCSWFConnection] ERROR! Failed to connect");
                }
                _lc.send(_extID, "GC_utils_GCSWFConnection_init", _version);
                trace("[" + _logName + "] [GCSWFConnection] Connected as client..");
            }
            else 
            {
                trace("[" + _logName + "] [GCSWFConnection] Connected as host..");
            }
            return;
        }

        protected function bridgeConnected():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=0;
            while (loc1 < _queuedMessages.length) 
            {
                loc2 = _queuedMessages[loc1].methodName;
                loc3 = _queuedMessages[loc1].methodArgs;
                loc4 = [loc2];
                if (loc3) 
                {
                    loc4 = loc4.concat(loc3);
                }
                send.apply(null, loc4);
                ++loc1;
            }
            _queuedMessages = [];
            if (_close) 
            {
                close();
            }
            return;
        }

        public function GC_utils_GCSWFConnection_init(arg1:String):void
        {
            trace("[" + _logName + "] [GCSWFConnection] Reccieved Init");
            if (_host) 
            {
                _lc.send(_extID, "GC_utils_GCSWFConnection_init", _version);
            }
            _connected = true;
            clientVersion = arg1;
            bridgeConnected();
            dispatchEvent(new flash.events.Event(CONNECTED));
            return;
        }

        public function send(arg1:String, ... rest):void
        {
            if (_connected) 
            {
                rest.unshift(arg1);
                rest.unshift("GC_utils_GCSWFConnection_receive");
                rest.unshift(_extID);
                _lc.send.apply(_lc, rest);
            }
            else 
            {
                _queuedMessages.push({"methodName":arg1, "methodArgs":rest});
            }
            return;
        }

        public function get connected():Boolean
        {
            return _connected;
        }

        public function get id():String
        {
            return _baseID;
        }

        private function onStatus(arg1:flash.events.StatusEvent):void
        {
            if (arg1.level != "error") 
            {
            };
            return;
        }

        public function GC_utils_GCSWFConnection_receive(arg1:String, ... rest):void
        {
            var methodName:String;
            var args:Array;

            var loc1:*;
            methodName = arg1;
            args = rest;
            try 
            {
                _client[methodName].apply(_client, args);
            }
            catch (e:*)
            {
            };
            return;
        }

        public function close():void
        {
            var loc1:*;
            trace("[" + _logName + "] [GCSWFConnection] Connection Closing");
            if (_queuedMessages.length != 0) 
            {
                _close = true;
                return;
            }
            try 
            {
                _lc.close();
            }
            catch (e:*)
            {
            };
            _lc = null;
            _connected = false;
            return;
        }

        public static const CONNECTED:String="CONNECTED";

        protected var _host:Boolean;

        protected var _connected:Boolean;

        protected var _baseID:String;

        public var clientVersion:String;

        protected var _callbackObjects:Array;

        protected var _lc:flash.net.LocalConnection;

        protected var _version:String;

        protected var _myID:String;

        protected var _client:Object;

        protected var _logName:String="GC-API";

        protected var _close:Boolean;

        protected var _extID:String;

        protected var _queuedMessages:Array;
    }
}
