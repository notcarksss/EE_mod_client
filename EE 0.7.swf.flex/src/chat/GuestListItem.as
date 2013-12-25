package chat 
{
    import blitter.*;
    import flash.display.*;
    import sample.ui.components.*;
    
    public class GuestListItem extends sample.ui.components.Box
    {
        public function GuestListItem()
        {
            this.tf = new blitter.BlText(14, 180, 8947848, "left");//, "visitor");
			this.tf.text = "visitor";
            super();
            margin(NaN, NaN, NaN, 2);
            minSize(200, 10);
            return;
        }

        public function set online(arg1:int):void
        {
            if (this.bm) 
            {
                removeChild(this.bm);
                this.bm.bitmapData.dispose();
                this.bm = null;
            }
            this.tf.text = arg1 + (arg1 != 1 ? " Guests online" : " Guest online");
            //this.bm = new flash.display.Bitmap(this.tf.clone());
            addChild(this.bm);
            minSize(180, 10);
            return;
        }

        private var tf:blitter.BlText;

        private var bm:flash.display.Bitmap;
    }
}
