package blitter 
{
    import flash.display.*;
    import flash.events.*;
    
    public class Bl extends Object
    {
        public function Bl()
        {
            super();
            return;
        }

        public static function init(arg1:flash.display.Stage, arg2:Number, arg3:Number):void
        {
            width = arg2;
            height = arg3;
            stage = arg1;
            stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, handleKeyDown);
            stage.addEventListener(flash.events.KeyboardEvent.KEY_UP, handleKeyUp);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, handleMouseDown);
            stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, handleMouseUp);
            last = new Date().getTime();
            return;
        }

        public static function update():void
        {
            var loc1:*=new Date().getTime();
            offset = loc1 - last;
            last = loc1;
            return;
        }

        public static function get elapsed():Number
        {
            return offset < 100 ? offset : 100;
        }

        public static function get mouseX():Number
        {
            return stage.mouseX;
        }

        public static function get mouseY():Number
        {
            return stage.mouseY;
        }

        public static function get isMouseDown():Boolean
        {
            return mouseDown;
        }

        public static function get isMouseJustPressed():Boolean
        {
            return mouseJustPressed;
        }

        public static function isKeyDown(arg1:int):Boolean
        {
            return keys[arg1] ? true : false;
        }

        public static function isKeyJustPressed(arg1:int):Boolean
        {
            return justPressedKeys[arg1] ? true : false;
        }

        public static function exitFrame():void
        {
            justPressedKeys = {};
            mouseJustPressed = false;
            return;
        }

        protected static function handleMouseDown(arg1:flash.events.MouseEvent):void
        {
            mouseDown = true;
            mouseJustPressed = true;
            return;
        }

        protected static function handleMouseUp(arg1:flash.events.MouseEvent):void
        {
            mouseDown = false;
            return;
        }

        protected static function handleKeyDown(arg1:flash.events.KeyboardEvent):void
        {
            keys[arg1.keyCode] = true;
            justPressedKeys[arg1.keyCode] = true;
            return;
        }

        protected static function handleKeyUp(arg1:flash.events.KeyboardEvent):void
        {
            delete keys[arg1.keyCode];
            return;
        }

        
        {
            last = 0;
            offset = 0;
            keys = {};
            justPressedKeys = {};
            mouseDown = false;
            mouseJustPressed = false;
            data = {};
        }

        private static var last:Number=0;

        private static var offset:Number=0;

        private static var keys:Object;

        private static var justPressedKeys:Object;

        private static var mouseDown:Boolean=false;

        private static var mouseJustPressed:Boolean=false;

        public static var stage:flash.display.Stage;

        public static var data:Object;

        public static var width:Number;

        public static var height:Number;
    }
}
