package blitter 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    
    public class BlText extends blitter.BlObject
    {
        public function BlText(arg1:int, arg2:Number, arg3:Number=16777215, arg4:String="left")
        {
            this.systemFont = blitter.BlText_systemFont;
            this.tf = new flash.text.TextField();
            this.tf.embedFonts = true;
            this.tf.selectable = false;
            this.tf.sharpness = 100;
            this.tf.multiline = true;
            this.tf.wordWrap = true;
            this.tf.width = arg2;
            this.tff = new flash.text.TextFormat("system", arg1, arg3, null, null, null, null, null, arg4);
            this.tf.defaultTextFormat = this.tff;
            this.tf.text = "qi´";
            this.bmd = new flash.display.BitmapData(arg2, this.tf.textHeight + 10, true, 0);
            this.tf.text = "";
            super();
            return;
        }

        public function set text(arg1:String):void
        {
            this.tf.text = arg1;
            blitter.Bl.stage.quality = flash.display.StageQuality.LOW;
            this._text = arg1;
            this.bmd.fillRect(this.bmd.rect, 0);
            this.bmd.draw(this.tf);
            blitter.Bl.stage.quality = flash.display.StageQuality.BEST;
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public override function draw(arg1:flash.display.BitmapData, arg2:Number, arg3:Number):void
        {
            arg1.copyPixels(this.bmd, this.bmd.rect, new flash.geom.Point(arg2 + x, arg3 + y));
            return;
        }
		
		public function clone():flash.display.BitmapData
		{
			return this.bmd.clone();
		}

        private var systemFont:Class;

        protected var _text:String="";

        protected var bmd:flash.display.BitmapData;

        protected var tf:flash.text.TextField;

        protected var tff:flash.text.TextFormat;
    }
}
