package 
{
    import flash.display.*;
    
    public class GamesChart extends Object
    {
        public function GamesChart()
        {
            super();
            return;
        }

        public static function openCharts():void
        {
            if (_interface == null) 
            {
                trace(_errors.noInterface);
                return;
            }
            _interface.sendNotification(GCNotificationTypes.SHOW_CHART_LISTS, {});
            return;
        }

        public static function hideTab():void
        {
            if (_interface == null) 
            {
                trace(_errors.noInterface);
                return;
            }
            _interface.sendNotification(GCNotificationTypes.HIDE_TAB, {});
            return;
        }

        public static function showTab(arg1:Number, arg2:Number):void
        {
            if (_interface == null) 
            {
                trace(_errors.noInterface);
                return;
            }
            _interface.sendNotification(GCNotificationTypes.SHOW_TAB, {"xPos":arg1, "yPos":arg2});
            return;
        }

        public static function setup(arg1:flash.display.Stage, arg2:String):void
        {
            if (_interface != null) 
            {
                trace(_errors.alreadyDefinedInterface);
            }
            else 
            {
                if (arg1 == null) 
                {
                    trace(_errors.noContainerMC);
                    return;
                }
                if (arg2 == null || arg2 == "") 
                {
                    trace(_errors.noGameIDHash);
                    return;
                }
                _interface = new GCBrainInterface(arg1);
                _interface.begin(arg2);
            }
            return;
        }

        
        {
            VERSION = "0.2.0";
            onGCEvent = null;
            _errors = {"noInterface":"[GC-API] ERROR! Please call gc.setup() first. See: http://wiki.gameschart.com/index.php/Static_Functions", "alreadyDefinedInterface":"[GC-API] ERROR! Can only call setup once! See: http://wiki.gameschart.com/index.php/Static_Functions", "noContainerMC":"[GC-API] ERROR! You must supply a container to hold GamesChart! See: http://wiki.gameschart.com/index.php/Static_Functions#Setup", "noGameIDHash":"[GC-API] ERROR! You must supply the game ID key associated with this game! http://wiki.gameschart.com/index.php/Static_Functions#Setup"};
        }

        public static var onGCEvent:Function=null;

        private static var _errors:Object;

        private static var _interface:GCBrainInterface;

        public static var VERSION:String="0.2.0";
    }
}
