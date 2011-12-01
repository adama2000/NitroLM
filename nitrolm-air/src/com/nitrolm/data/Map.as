/**
 * Copyright (c) 2011 Simplified Logic, Inc. http://nitrolm.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *	
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 *  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 *  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.nitrolm.data
{
	/**
	 * Simple implementation of a HashMap.  Keys are always Strings, values can be any type
	 */
	dynamic public class Map
	{
		public function Map()
		{
		}
		
		/**
		 * Does this Map contain the key?
		 */
		public function contains(key:String):Boolean
		{
			return (key in this);
		}
		
		/**
		 * Put a new key/value pair into the Map
		 */
		public function put(key:String, value:*):void
		{
			this[key] = value;
		}
		
		/**
		 * retrieve a Map value
		 */
		public function get(key:String):Object
		{
			if(contains(key))
				return this[key];
			
			return null;
		}
		
		/**
		 * retrieve an array of all keys
		 */
		public function getKeys():Array
		{
			var keys:Array = new Array();
			for(var key:String in this)
			{
				keys.push(key);	
			}
			
			return keys;
		}
		
		/**
		 * retrieve an array of all values
		 */
		public function getValues():Array
		{
			var values:Array = new Array();
			for each(var value:Object in this)
			{
				values.push(value);
			}
			
			return values;
		}
		
		/**
		 * dump the values inside of this map
		 */
		public function toString(level:int=0):String
		{
			var indent:String = "";
			for(var i:int = 0; i<level;i++)
			{
				indent += "  ";
			}
			var out:String = new String();
			var keys:Array = getKeys();
			out+= indent + "{\n";
			for each(var key:String in keys)
			{
				var value:Object = get(key);
				out+= indent + "  " + key;
				out+=" : ";
				if(value is Map)
				{
					out += "\n" + (value as Map).toString(level+1);
				}
				else if(value is String)
				{
					out += '\'' + value.toString() + '\'';
				}
				else
				{
					out += value.toString();
				}
				out += ",\n";
			}
			out+= indent + "}\n";
			
			return out;
		}
	}
}