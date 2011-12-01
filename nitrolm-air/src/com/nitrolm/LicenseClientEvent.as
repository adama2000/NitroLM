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

package com.nitrolm
{
	import flash.events.Event;

	/**
	 * The LicenseClientEvent is used to send response codes and data from the NitroLM server.
	 * The best practice for using events is to remove your event handler inside the method handling
	 * the event.
	 */
	public class LicenseClientEvent extends Event
	{
		/**
		 * Handle this response type for all requests except for change password and modifying the usage counter.
		 */
		public static var LICENSE_RESPONSE:String = "licenseResponse";
		
		private var _req_type:int=-1;
		private var _response:int=-1;
		private var _data:* = null;
		
		/**
		 * @param type the event type
		 * @param req_type the original request type that generated this response
		 * @param response the response code
		 * @param bubbles
		 * @param cancelable
		 */
		public function LicenseClientEvent(type:String, req_type:int, response:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_response = response;
			_req_type = req_type;
		}
		
		/**
		 * The response code.
		 * @see NLMConstants
		 */
		public function get response():int
		{
			return _response;
		}
		
		/**
		 * Any data retrieved in the NitroLM call will be stored here.
		 * @return various data types depending on the request
		 */
		public function get data():*
		{
			return _data;
		}
		
		/**
		 * @private
		 */
		public function set data(value:*):void
		{
			_data = value;
		}
		
		/**
		 * The original request type that generated this response event
		 */
		public function get req_type():int
		{
			return _req_type;
		}
		
		override public function clone():Event
		{
			var lce:LicenseClientEvent = new LicenseClientEvent(type, req_type, response, bubbles, cancelable);
			lce.data = data;
			
			return lce;
		}
	}
}