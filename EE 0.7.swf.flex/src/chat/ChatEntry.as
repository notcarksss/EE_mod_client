package chat 
{
    import flash.display.*;
    import flash.text.*;
    
    public class ChatEntry extends flash.display.Sprite
    {
        public function ChatEntry(arg1:String, arg2:String, arg3:Number)
        {
            var loc1:*=null;
            super();
            loc1 = new flash.text.TextField();
            loc1.multiline = true;
            loc1.selectable = true;
            loc1.wordWrap = true;
            loc1.width = 190;
            loc1.height = 500;
            loc1.antiAliasType = flash.text.AntiAliasType.ADVANCED;
            loc1.gridFitType = flash.text.GridFitType.SUBPIXEL;
            loc1.condenseWhite = true;
            //var loc2:*=Player.isAdmin(arg1);
            if (arg3 != 0) 
            {
                loc1.background = true;
                loc1.backgroundColor = arg3;
            }
            var loc3:*=new flash.text.TextFormat("Tahoma", 9, 8947848, false, false, false);
            loc3.indent = -8;
            loc3.blockIndent = 8;
            loc3.align = flash.text.TextFormatAlign.LEFT;
            loc1.defaultTextFormat = loc3;
            var loc4:*=16757760;//(loc2) ? 16757760 : 15658734;
            loc1.text = arg1.toUpperCase() + ": " + arg2;
            loc1.setTextFormat(new flash.text.TextFormat(null, null, loc4), 0, (arg1 + ": ").length);
            loc1.x = 2;
            loc1.y = 1;
            loc1.height = loc1.textHeight + 5;
            addChild(loc1);
            return;
        }

        public override function set width(arg1:Number):void
        {
            return;
        }
    }
}
