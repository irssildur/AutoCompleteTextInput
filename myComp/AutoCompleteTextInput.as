package myComp
{
	
	import flash.events.KeyboardEvent;
	
	import mx.collections.*;
	
	import spark.components.TextInput;
	
	
	public class AutoCompleteTextInput extends TextInput
	{
		
		private var __innerArrayCollection:ArrayCollection;
		private var __parameterName:String;
		
		
		public function AutoCompleteTextInput()
		{
			super();
			
			__parameterName = "";	
			
			this.addEventListener(KeyboardEvent.KEY_UP, changeHandler);
			
		}
		
		public function set innerArrayCollection(value:ArrayCollection):void
		{
			
			__innerArrayCollection = value;
		}
		
		public function set parameterName(value:String):void
		{
			
			__parameterName = value;
			
		}
			
		protected function searchFilter(item:Object):Boolean
		{
		
			var searchString:String = this.text.toLowerCase();
			var itemName:String;
			
			if (__parameterName != "")
			{
				itemName = (item[__parameterName] as String).toLowerCase();
			}
			else
			{
				itemName = (item as String).toLowerCase();
			}
			
			//return itemName.indexOf(searchString) > -1;
			return itemName.lastIndexOf(searchString, searchString.length-1) > -1;
		}
		
		
		
		protected function search():void
		{
			var inputCharNum:int = this.text.length;
			
			
			
			__innerArrayCollection.filterFunction = searchFilter;
			__innerArrayCollection.refresh();
			
			
			if (__innerArrayCollection.length>0)
			{
			
				if (__parameterName != "")
				{
					this.text = __innerArrayCollection[0][__parameterName];
					
				}
				else
				{
					this.text = __innerArrayCollection[0];
				}
				this.selectRange(inputCharNum,this.text.length);
			}
			
			
			
			//return __innerArrayCollection[0];
		}
		
		
		protected function changeHandler(event:KeyboardEvent):void
		{
			
			// backspace || delete
			if(event.charCode != 8 && event.charCode != 127)
			{
				search();
			}
			
			
		}
	}
}