package SWFStats 
{
    import flash.events.*;
    import flash.external.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public final class Log extends Object
    {
        public function Log()
        {
            super();
            return;
        }

        public static function View(arg1:int=0, arg2:String="", arg3:String=""):void
        {
            SWFID = arg1;
            GUID = arg2;
            Enabled = true;
            if (SWFID == 0 || GUID == "") 
            {
                Enabled = false;
                return;
            }
            if (!(arg3.indexOf("http://") == 0) && !(flash.system.Security.sandboxType == "localWithNetwork") && !(flash.system.Security.sandboxType == "localTrusted")) 
            {
                Enabled = false;
                return;
            }
            SourceUrl = GetUrl(arg3);
            if (SourceUrl == null || SourceUrl == "") 
            {
                Enabled = false;
                return;
            }
            flash.system.Security.allowDomain("http://tracker.swfstats.com/");
            flash.system.Security.allowInsecureDomain("http://tracker.swfstats.com/");
            flash.system.Security.loadPolicyFile("http://tracker.swfstats.com/crossdomain.xml");
            flash.system.Security.allowDomain("http://utils.swfstats.com/");
            flash.system.Security.allowInsecureDomain("http://utils.swfstats.com/");
            flash.system.Security.loadPolicyFile("http://utils.swfstats.com/crossdomain.xml");
            var loc1:*=GetCookie("views");
            ++loc1;
            SaveCookie("views", loc1);
            Send("View", "views=" + loc1);
            PingF.addEventListener(flash.events.TimerEvent.TIMER, PingServer);
            PingF.start();
            return;
        }

        public static function Play():void
        {
            if (!Enabled) 
            {
                return;
            }
            var loc1:*;
            Plays++;
            Send("Play", "plays=" + Plays);
            return;
        }

        public static function Goal(arg1:int, arg2:String):void
        {
            return;
        }

        private static function PingServer(... rest):void
        {
            if (!Enabled) 
            {
                return;
            }
            var loc1:*;
            Pings++;
            Send("Ping", (FirstPing ? "&firstping=yes" : "") + "&pings=" + Pings);
            if (FirstPing) 
            {
                PingF.stop();
                PingR.addEventListener(flash.events.TimerEvent.TIMER, PingServer);
                PingR.start();
                FirstPing = false;
            }
            return;
        }

        public static function CustomMetric(arg1:String, arg2:String=null):void
        {
            if (!Enabled) 
            {
                return;
            }
            if (arg2 == null) 
            {
                arg2 = "";
            }
            Send("CustomMetric", "name=" + escape(arg1) + "&group=" + escape(arg2));
            return;
        }

        public static function LevelCounterMetric(arg1:String, arg2:*):void
        {
            if (!Enabled) 
            {
                return;
            }
            Send("LevelMetric", "name=" + escape(arg1) + "&level=" + arg2);
            return;
        }

        public static function LevelRangedMetric(arg1:String, arg2:*, arg3:int):void
        {
            if (!Enabled) 
            {
                return;
            }
            Send("LevelMetricRanged", "name=" + escape(arg1) + "&level=" + arg2 + "&value=" + arg3);
            return;
        }

        public static function LevelAverageMetric(arg1:String, arg2:*, arg3:int):void
        {
            if (!Enabled) 
            {
                return;
            }
            Send("LevelMetricAverage", "name=" + escape(arg1) + "&level=" + arg2 + "&value=" + arg3);
            return;
        }

        private static function Send(arg1:String, arg2:String):void
        {
            var loc1:*=new flash.net.URLLoader();
            loc1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, ErrorHandler);
            loc1.addEventListener(flash.events.HTTPStatusEvent.HTTP_STATUS, StatusChange);
            loc1.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, ErrorHandler);
            loc1.load(new flash.net.URLRequest("http://tracker.swfstats.com/Games/" + arg1 + ".html?guid=" + GUID + "&swfid=" + SWFID + "&" + arg2 + "&url=" + SourceUrl + "&" + Random));
            return;
        }

        private static function ErrorHandler(... rest):void
        {
            Enabled = false;
            return;
        }

        private static function StatusChange(... rest):void
        {
            return;
        }

        private static function GetCookie(arg1:String):int
        {
            var loc1:*=flash.net.SharedObject.getLocal("swfstats");
            if (loc1.data[arg1] == undefined) 
            {
                return 0;
            }
            return int(loc1.data[arg1]);
        }

        private static function SaveCookie(arg1:String, arg2:int):void
        {
            var loc1:*=flash.net.SharedObject.getLocal("swfstats");
            loc1.data[arg1] = arg2.toString();
            loc1.flush();
            return;
        }

        private static function GetUrl(arg1:String):String
        {
            var defaulturl:String;
            var url:String;

            var loc1:*;
            url = null;
            defaulturl = arg1;
            if (flash.external.ExternalInterface.available) 
            {
                try 
                {
                    url = String(flash.external.ExternalInterface.call("window.location.href.toString"));
                }
                catch (s:Error)
                {
                    url = defaulturl;
                }
            }
            else if (defaulturl.indexOf("http://") == 0) 
            {
                url = defaulturl;
            }
            if (url == null || url == "" || url == "null") 
            {
                if (flash.system.Security.sandboxType == "localWithNetwork" || flash.system.Security.sandboxType == "localTrusted") 
                {
                    url = "http://local-testing/";
                }
                else 
                {
                    url = null;
                }
            }
            return url;
        }

        
        {
            Enabled = false;
            SWFID = 0;
            GUID = "";
            FirstPing = true;
            Pings = 0;
            Plays = 0;
            HighestGoal = 0;
        }

        private static const Random:Number=Math.random();

        private static const PingF:flash.utils.Timer=new flash.utils.Timer(60000);

        private static const PingR:flash.utils.Timer=new flash.utils.Timer(30000);

        private static var Enabled:Boolean=false;

        public static var SWFID:int=0;

        public static var GUID:String="";

        public static var SourceUrl:String;

        private static var FirstPing:Boolean=true;

        private static var Pings:int=0;

        private static var Plays:int=0;

        private static var HighestGoal:int=0;
    }
}
