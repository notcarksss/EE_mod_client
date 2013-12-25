package chat 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    
    public class TabTextField extends flash.display.Sprite
    {
        public function TabTextField()
        {
            super();
            this.field = new flash.text.TextField();
            this.addChild(this.field);
            this.field.useRichTextClipboard = false;
            this.field.type = flash.text.TextFieldType.INPUT;
            this.field.multiline = false;
            this.field.maxChars = 80;
            var loc1:*=new flash.text.TextFormat();
            loc1.font = "Arial";
            loc1.color = 0;
            loc1.size = 12;
            this.field.defaultTextFormat = loc1;
            this.componentHeight = this.field.height;
            this.realign();
            this.field.width = 20;
            this.field.height = this.field.textHeight + 5;
            this.field.addEventListener(flash.events.FocusEvent.KEY_FOCUS_CHANGE, this.handleTabRequest);
            this.field.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.handleKeyDown);
            this.field.addEventListener(flash.events.KeyboardEvent.KEY_UP, this.handleKeyUp);
            this.field.text = "";
            this.matches = null;
            return;
        }

        private function get checkWords():Object
        {
            return !(this.gw == null) ? this.gw() : {};
        }

        public function SetWordFunction(arg1:Function):void
        {
            this.gw = arg1;
            return;
        }

        public override function set width(arg1:Number):void
        {
            this.field.width = arg1;
            return;
        }

        public override function set height(arg1:Number):void
        {
            this.componentHeight = arg1;
            this.realign();
            return;
        }

        public function set text(arg1:String):void
        {
            this.field.text = arg1;
            return;
        }

        public function get text():String
        {
            return this.field.text;
        }

        private function realign():void
        {
            this.field.y = (this.componentHeight - this.field.height) / 2;
            return;
        }

        private function handleTabRequest(arg1:flash.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            arg1.preventDefault();
            if (!this.matches) 
            {
                loc1 = this.field.text;
                loc2 = this.getCaretWord();
                if (loc2.text != "") 
                {
                    this.matches = this.getWordlist(loc2.text);
                    this.matches.sortOn("weight", Array.NUMERIC | Array.DESCENDING);
                    this.before = loc1.substring(0, loc2.start);
                    this.after = loc1.substring(loc2.end);
                }
            }
            if (this.matches && this.matches.length > 0) 
            {
                loc3 = this.after.replace(new RegExp("\\W", "g"), "");
                loc4 = loc3 != "" ? this.after : this.before != "" ? " " + this.after : ": " + this.after;
                this.field.text = this.before + this.matches[0].word + loc4;
                loc5 = this.matches[0].word.length + this.before.length + loc4.length;
                if (this.matches.length > 1) 
                {
                    this.field.setSelection(this.field.selectionBeginIndex, loc5);
                }
                else 
                {
                    loc6 = loc5;
                    this.field.setSelection(loc6, loc6);
                }
                this.matches.push(this.matches.shift());
            }
            return;
        }

        private function handleKeyDown(arg1:flash.events.KeyboardEvent):void
        {
            var loc1:*=arg1.keyCode;
        }

        private function doMatch():void
        {
            var loc1:*=null;
            if (!(this.matches == null) && this.matches.length > 0 && !(this.field.selectionBeginIndex == this.field.selectionEndIndex)) 
            {
                loc1 = this.field.text;
                this.field.type = flash.text.TextFieldType.DYNAMIC;
                this.resetText = true;
            }
            this.matches = null;
            return;
        }

        private function handleKeyUp(arg1:flash.events.KeyboardEvent):void
        {
            if (this.resetText) 
            {
                this.field.type = flash.text.TextFieldType.INPUT;
                this.field.setSelection(this.field.selectionEndIndex + 1, this.field.selectionEndIndex + 1);
            }
            this.resetText = false;
            return;
        }

        private function getWordlist(arg1:String):Array
        {
            var loc2:*=null;
            var loc1:*=[];
            var loc3:*=0;
            var loc4:*=this.checkWords;
            for (loc2 in loc4) 
            {
                if (loc2.toLowerCase().indexOf(arg1.toLowerCase()) != 0) 
                {
                    continue;
                }
                loc1.push({"word":loc2, "weight":this.checkWords[loc2]});
            }
            return loc1;
        }

        private function getCaretWord():Object
        {
            var loc1:*=this.field.text;
            var loc2:*=this.field.caretIndex;
            var loc3:*=this.field.caretIndex;
            var loc4:*={};
            loc4[" "] = true;
            loc4["\n"] = true;
            loc4["\t"] = true;
            loc4[String.fromCharCode(13)] = true;
            while (loc2 - 1 >= 0 && !loc4[loc1.charAt(loc2 - 1)]) 
            {
                --loc2;
            }
            while (loc3 < loc1.length && !loc4[loc1.charAt(loc3)]) 
            {
                ++loc3;
            }
            return {"end":loc3, "start":loc2, "text":loc1.substring(loc2, loc3)};
        }

        public var field:flash.text.TextField;

        private var matches:Array;

        private var before:String="";

        private var after:String="";

        private var resetText:Boolean=false;

        private var componentHeight:Number;

        private var gw:Function=null;
    }
}
