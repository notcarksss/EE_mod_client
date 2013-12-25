package chat 
{
    import blitter.*;
    import flash.display.*;
    import sample.ui.components.*;
    
    public class UserlistItem extends sample.ui.components.Box
    {
        public function UserlistItem(arg1:String, arg2:Boolean)
        {
            this.time = new Date().milliseconds;
            super();
            this.canchat = arg2;
            this.username = arg1;
            this.setText(arg1, 0);
            minSize(200, 10);
            return;
        }

        public function set count(arg1:int):void
        {
            this._count = arg1;
            this.setText(this.username, this._count);
            return;
        }

        public function get count():int
        {
            return this._count;
        }

        public override function set width(arg1:Number):void
        {
            return;
        }

        public override function get width():Number
        {
            return 100;
        }

        private function setText(arg1:String, arg2:int):void
        {
            var loc4:*=null;
            var loc5:*=null;
            if (this.bm) 
            {
                removeChild(this.bm);
                this.bm.bitmapData.dispose();
                this.bm = null;
            }
            var loc1:*= 16757760;//Player.isAdmin(arg1) ? 16757760 : 13421772;
            var loc2:*=new blitter.BlText(8, 195, this.canchat ? loc1 : 6710886, "left");//, "visitor");
            loc2.text = arg1;
            var loc3:*=loc2.clone();
            if (arg2 > 1) 
            {
                loc4 = new blitter.BlText(8, 195, 8947848, "right");//, "visitor");
                loc4.text = arg2.toString();
                loc5 = loc4.clone();
                loc3.draw(loc5);
            }
            this.bm = new flash.display.Bitmap(loc3);
            addChild(this.bm);
            return;
        }

        public var username:String;

        public var time:Number;

        private var _count:int=0;

        public var canchat:Boolean=false;

        private var bm:flash.display.Bitmap;
    }
}
