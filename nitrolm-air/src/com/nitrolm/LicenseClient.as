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
	import com.nitrolm.data.Map;
	
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	
	/**
	 * LicenseClient is the main class used for communicating to Nitro-LM Servers
	 */
	public class LicenseClient extends EventDispatcher
	{
		[Event(name="license_response", type="com.nitrolm.LicenseClientEvent")]
		
		public static var context:ExtensionContext;
		
		/**
		 * Create a new LicenseClient instance
		 * 
		 * @param debug If enabled, the native library will write a file called nitrolm_debug.out
		 */
		public function LicenseClient(debug:Boolean = false)
		{
			if(!context)
			{
				context = ExtensionContext.createExtensionContext("com.nitrolm.NitroLM", "");
			}
			
			if(context && debug)
			{
				context.call("enableDebug_air");
			}
		}
		
		/**
		 * Call this method before closing your AIR application to dispose of the native ExtensionContext
		 * 
		 * @see ExtensionContext#dispose()
		 */
		public function dispose():void
		{
			if(context)
			{
				context.dispose();
			}
		}
		
		/**
		 * @private
		 */
		private function handleStatusEvent(event:StatusEvent):void
		{
			context.removeEventListener(StatusEvent.STATUS, handleStatusEvent);
			var req_type:int = new int(event.code);
			var response:int = new int(event.level);
			var lce:LicenseClientEvent = new LicenseClientEvent(LicenseClientEvent.LICENSE_RESPONSE, req_type, response);
			
			switch(req_type)
			{
				case NLMConstants.REQUEST_GETAPPLOGIN:
					if(response == NLMConstants.RESPONSE_OK)
					{
						lce.data = context.call("getAppLogin_data");
					}
				break;
				
				case NLMConstants.REQUEST_GETPRODUCTS:
					if(response == NLMConstants.RESPONSE_OK)
					{
						lce.data = context.call("getCustomerProducts_data");
					}
				break;

				case NLMConstants.REQUEST_MESSAGES:
					if(response == NLMConstants.RESPONSE_OK)
					{
						lce.data = context.call("getMessages_data");
					}
				break;

				case NLMConstants.REQUEST_SESSIONDATA:
					if(response == NLMConstants.RESPONSE_OK)
					{
						lce.data = context.call("getSessionData_data");
					}
				break;

				case NLMConstants.REQUEST_GETUSERVAR:
					if(response == NLMConstants.RESPONSE_OK)
					{
						lce.data = context.call("getUserVar_data");
					}
				break;

				case NLMConstants.REQUEST_KEY:
					if(response == NLMConstants.RESPONSE_OK)
					{
						lce.data = context.call("requestKey_data");
					}
				break;
			}
			
			dispatchEvent(lce);
		}
		
		/**
		 * This method stores a product key for use in communicating with the NitroLM servers
		 * 
		 * @param productCode the product code
		 * @param key the key to use in communicating with this productCode
		 */ 
		public function putPublicKey(productCode:String, key:ByteArray):int
		{
			var ret:int = context.call("putPublicKey_air", productCode, key) as int;

			return ret;
		}
		
		/**
		 * A manual license type is useful when a user is operating offline
		 * most of the time.  A user can request a manual license, and paste the response string into
		 * a form at nitrolm.com-&gt;Install/Support-&gt;Manual License Request.
		 * The response from the tool at the Manual License Website can then be applied using this method. 
		 * 
		 * @param outputData The string returned as output from the Manual License Request website.
		 * 
		 * @see #getManualLicense()
		 */
		public function applyManualLicense(outputData:String):int
		{
			var ret:int = context.call("applyManualLicense_air", outputData) as int;
			
			return ret;
		}
		
		/**
		 * This method checks to see if ProductKeys contains a valid key for this product
		 * in order to communicate with the NitroLM server.
		 * 
		 * @param productCode The product code to check
		 * @return value like (RESPONSE_OK, RESPONSE_NO_KEY, RESPONSE_NO_MACIDS)
		 * 
		 * @see NLMConstants#RESPONSE_OK
		 * @see NLMConstants#RESPONSE_NO_KEY
		 * @see NLMConstants#RESPONSE_NO_MACIDS
		 */
		public function canSendRequest(productCode:String):int
		{
			var ret:int = context.call("canSendRequest_air", productCode) as int;
			
			return ret;
		}
		
		/**
		 * This method changes a user's password and dispatches a <code>LicenseClientEvent</code>
		 * of type <code>LicenseClientEvent.LICENSE_RESPONSE</code>.  Make sure you
		 * add an event listener for this type before calling the method.  Remove your event listener
		 * in the handling method.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * <p><i>
		 * Note:  This method encrypts all data before communicating the password change to the NitroLM
		 *        license server.
		 * </i></p>
		 * 
		 * @param email String value of the user's e-mail address
		 * @param oldpwd String value of the user's old password
		 * @param newpwd String value of the password to change to
		 * @param newpwd2 String value needs to be identical to newpwd
		 * 
		 * @see LicenseClientEvent
		 */
		public function changePassword(email:String, oldpwd:String, newpwd:String, newpwd2:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("changePassword_air", email, oldpwd, newpwd, newpwd2);
		}
		
		/**
		 * This method checks to see whether this user has exceeded warning or maximum levels for number
		 * of product execution runs.
		 * 
		 * @param productCode The product code
		 * @return value like (RESPONSE_OK, RESPONSE_EXCEEDED_WARN_EXEC, RESPONSE_EXCEEDED_MAX_EXEC, RESPONSE_INTERNAL_CLIENT_ERROR)
		 * 
		 * @see #getLicenseInfo()
		 * @see NLMConstants#RESPONSE_OK
		 * @see NLMConstants#RESPONSE_EXCEEDED_WARN_EXEC
		 * @see NLMConstants#RESPONSE_EXCEEDED_MAX_EXEC
		 * @see NLMConstants#RESPONSE_INTERNAL_CLIENT_ERROR
		 */
		public function checkUsageCounter(productCode:String):int
		{
			var ret:int = context.call("checkUsageCounter_air", productCode) as int;
			
			return ret;
		}
		
		/**
		 * This method checks a user account for validity in accessing this product.  It dispatches
		 * a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_CHKUSER</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation. event.data contains a Map containing keys and values.
		 * 
		 * @param email the user's e-mail address
		 * @param checkConfirmed Make sure the user has confirmed their registration
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_CHKUSER
		 * @see com.nitrolm.data.Map
		 */ 
		public function checkUser(email:String, checkConfirmed:Boolean):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("checkUser_air", email, checkConfirmed);
		}
		
		/**
		 * This method creates a new user registration request in NitroLM.  It dispatches a <code>LicenseClientEvent</code> of type
		 * <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of <code>NLMConstants.REQUEST_NEWUSER</code>. 
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param email the user's e-mail address. a confirmation e-mail will be sent to this address
		 * @param password the user's initial password
		 * @param firstName the user's first name
		 * @param lastName the user's last name
		 * @param phone the user's telephone number
		 * @param address1 line 1 of the user's address
		 * @param address2 (optional) set to null if not needed
		 * @param city the user's city
		 * @param state the user's state or province
		 * @param zip the user's zipcode
		 * @param country the user's country of origin
		 * @param user_company the user's company they work for as a standard string name.
		 * @param market_source where the user got/downloaded the product from.  could be a reseller's name.   if used for reseller, should be equal to "RES-"+reseller_name.  By default, you should set this to "LIC-"+your_licensee_name
		 * @param corpId the corporate id for the company that will issue licenses for this user.  The user doesn't "have" to always use this corpId in the future, but it does have to be a valid corpId for user creation to be successful. (null or "" to skip this check)
		 * @param version the version of app that requested this user be created (null, "", or "0" will skip version checking)
		 * @param regSource text string describing which location or application the user is registering through. Added to registration e-mails sent through notifications.
		 * @param mailType Tells the server which type of confirmation e-mail to send.  NLMConstants.CONFIRM_MAIL_BOTH, NLMConstants.CONFIRM_MAIL_LINKONLY, NLMConstants.CONFIRM_MAIL_CODEONLY, or NLMConstants.CONFIRM_MAIL_AUTO.  Most use cases should be LINKONLY
		 * @param extraData any custom user information you want to save.  Stored in the Map as name/value pairs.
		 * 
		 * @see NLMConstants#CONFIRM_MAIL_BOTH
		 * @see NLMConstants#CONFIRM_MAIL_LINKONLY
		 * @see NLMConstants#CONFIRM_MAIL_CODEONLY
		 * @see NLMConstants#CONFIRM_MAIL_AUTO
		 * @see data.Map
		 */
		public function createUser(email:String, password:String, firstName:String, lastName:String, phone:String, address1:String, address2:String, city:String, state:String, zip:String, country:String, user_company:String, market_source:String, corpId:String, version:String, regSource:String, mailType:int, extraData:Map):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("createUser_air", email, password, firstName, lastName, phone, address1, address2, city, state, zip, country, user_company, market_source, corpId, version, regSource, mailType, extraData);
		}
	
		/**
		 * This method disables the license already retrieved for the currently active user.  This method makes no server calls
		 * and only disables the license locally.  Most of the time, you should use <code>releaseLicense()</code>.  It's called
		 * internally to clean up expired licenses.
		 * 
		 * @param productCode the product code
		 * 
		 * @see #releaseLicense()
		 */
		public function disableLicense(productCode:String):int
		{
			var ret:int = context.call("disableLicense_air", productCode) as int;
			
			return ret;
		}
		
		/**
		 * This method is used to trigger an e-mail to the support team for this product.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_SUPPORT</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param productCode the product code
		 * @param version the product version needing support (null, "", or "0" will skip version checking)
		 * @param sender the email address the person sending the support request. (must be a registered user)
		 * @param type the type of support request (NLMConstanants.SUPPORT_SALES, NLMConstants.SUPPORT_TECH, or NLMConstants.SUPPORT_ENHANCE)
		 * @param message the message to send to support
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_SUPPORT
		 * @see NLMConstants#SUPPORT_SALES
		 * @see NLMConstants#SUPPORT_TECH
		 * @see NLMConstants#SUPPORT_ENHANCE
		 */
		public function emailSupport(productCode:String, version:String, sender:String, type:String, message:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("emailSupport_air", productCode, version, sender, type, message);
		}
		
		/**
		 * This method is used to request that a valid-until date for a product in a pool be pushed out X days.
		 * An e-mail will be sent to people on the notification list for PE - Product Extension Requests who will
		 * have the ability to approve/deny the request.  If approved, the valid-until date for the product in the
		 * requesting user's pool will be extended for X days.  The requesting user will be e-mailed letting them
		 * know the decision of the approver for Product Extensions.
		 * 
		 * This method dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_EXTEND_PRODUCT</code>
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param email the user's e-mail who is requesting a product extension
		 * @param corpId the corporate id so the server knows which pool(s) to look for the product to extend
		 * @param productCode the product code that will have its valid-until date extended in the pool.
		 * @param version the product version.  leave blank or null to skip version checking
		 * @param days the number of days to extend the valid-until date for.
		 * 
		 * @see LicenseClientEvent
		 */
		public function extendProduct(email:String, corpId:String, productCode:String, version:String, days:int):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("extendProduct_air", email, corpId, productCode, version, days);
		}
		
		/**
		 * This method validates the user/password/company/product/version combination and generates an appid token string to use later with <code>getLicenseAppid()</code>
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETAPPLOGIN</code>. <code>LicenseClientEvent.data</code> contains the appid string used in <code>getLicenseAppid()</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation. event.data contains a HashMap containing keys and values.
		 *  
		 * @param email the user's e-mail address
		 * @param password the user's password
		 * @param corpId the company's corporate id to get the app login from
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 *
		 * @see #getLicenseAppid() 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETAPPLOGIN
		 */
		public function getAppLogin(email:String, password:String, corpId:String, productCode:String, version:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getAppLogin_air", email, password, corpId, productCode, version);
		}
		
		/**
		 * This method retrieves products owned by a given company that a user has access to.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETPRODUCTS</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.  <code>event.data</code> contains an <code>Array</code> of Objects like {name: product_name, description: product_description}.
		 * 
		 * @param corpId the company's corporate id whose products you want to retrieve
		 * @param email the user whose products you want to retrieve
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETPRODUCTS
		 */
		public function getCustomerProducts(corpId:String, email:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getCustomerProducts_air", corpId, email);
		}
		
		/**
		 * This method retrieves a custom license value. Custom Values are the variable values that are set up in NitroAdmin for pools or products.
		 * 
		 * @param productCode the product code
		 * @param version the version which wrote this custom value (null, "", or "0" will skip version checking)
		 * @param varname the variable name to retrieve
		 * 
		 * @return String - The variable value or null 
		 */
		public function getCustomValue(productCode:String, version:String, varname:String):String
		{
			var ret:String = context.call("getCustomValue_air", productCode, version, varname) as String;
			
			return ret;
		}
		
		/**
		 * This method retrieves all custom license values. Custom Values are the variable values that are set up in NitroAdmin for pools or products.
		 * 
		 * @param productCode the product code
		 * @param the product version (null, "", or "0" will skip version checking)
		 * @param values the Map that will hold the custom license values (must not be null)
		 * @return value like (RESPONSE_OK, RESPONSE_INVALID_LICENSE)
		 * 
		 * @see NLMConstants#RESPONSE_OK
		 * @see NLMConstants#RESPONSE_INVALID_LICENSE
		 */
		public function getCustomValues(productCode:String, version:String, values:Map):int
		{
			var ret:int = context.call("getCustomValues_air", productCode, version, values) as int;
			
			return ret;
		}
		
		/**
		 * This method retrieves the customer list and values (AID, etc.) that are in the license's pool and its children.
		 * The custom values are variables/values defined on the server by the administrator, and are downloaded to the
		 * user's PC when they get or renew a license. Because the values are downloaded, they are available even 
		 * when the user is working offline.
		 * 
		 * @param productCode the product code
		 * @return Array of Map objects each containing 3 entries
		 * <br/><blockquote>
		 * company_code - The internal company code for the customer.  Should not be diplayed to the user.<br/>
		 * company_name - The name of the customer.<br/>
		 * vars - A Map object containing external variables associated with the customer (AID, CVsID, etc.).<br>
		 * </blockquote>
		 */
		public function getExternalValues(productCode:String):Array
		{
			var ret:Array = context.call("getExternalValues_air", productCode) as Array;
			
			return ret;
		}
		
		/**
		 * This method retrieves a license from the NitroLM server.
		 * <br/>It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETLICENSE</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * 
		 * @param email the user's e-mail address
		 * @param password the user's password
		 * @param corpId the company's corporate id code requesting a license.  if null, then retrieve a Demo license (days param is ignored).
		 * @param productCode the product code
		 * @param version the version of this product to retrieve a license for. (null, "", or "0" will skip version checking)
		 * @param type the type of license to retrieve. LOCK_FIXED, LOCK_FLOATING, or LOCK_DEMO.  If the type is none of these, the Default license type for this product is used.
		 * @param days this value must be > 0 to retrieve a demo or fixed license.  It is ignored for floating license types.
		 * @param market_source If used, should be equal to "LIC-"+reseller_name
		 * @param useQueue true if you want to allow users to queue license requests if none are available.
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETLICENSE
		 * @see NLMConstants#LOCK_FIXED
		 * @see NLMConstants#LOCK_FLOATING
		 * @see NLMConstants#LOCK_DEMO
		 */
		public function getLicense(email:String, password:String, corpId:String, productCode:String, version:String, type:String, days:int, market_source:String, useQueue:Boolean=false):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getLicense_air", email, password, corpId, productCode, version, type, days, market_source, useQueue);
		}

		/**
		 * This method is useful for servers with downloadable software.  The server can store an app-id locally so that when the user
		 * fires up the downloaded app, they don't have to re-login.  This has only really be used on the Java client for NitroLM, so
		 * if you have a need to use it here, talk NitroLM support first.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETLICENSE_APPID</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param appid the application identifier
		 * @param productCode the product to get a license for
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @param market_source If used, should be equal to "LIC-"+licensee_name or "RES-"+reseller_name
		 * @param useQueue true if you want to allow users to queue license requests if none are available.
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETLICENSE_APPID
		 */
		public function getLicenseAppid(appid:String, productCode:String, version:String, market_source:String, useQueue:Boolean=false):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getLicenseAppid_air", appid, productCode, version, market_source, useQueue);
		}
		
		/**
		 * This method retrieves the default license type for this product and default number of checkout days(if retrieving a checked out license).
		 * Default values are configured in the NitroLM Admin tool under My Products.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETLICENSE_DEFAULT</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param email the user's e-mail address
		 * @param password the user's password
		 * @param corpId the company's corporate id code for requesting a license.  if null, then retrieve a Demo license
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @param market_source if used, should be equal to "LIC-"+licensee_name or "RES-"+reseller_name
		 * @param useQueue true if you want to allow users to queue license requests if none are available.
		 *
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETLICENSE_DEFAULT
		 */
		public function getLicenseDefault(email:String, password:String, corpId:String, productCode:String, version:String, market_source:String, useQueue:Boolean=false):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getLicenseDefault_air", email, password, corpId, productCode, version, market_source, useQueue);
		}
		
		/**
		 * This method retrieves license info values from the currently active license such as when the license will expire.  This method doesn't communicate with the NitroLM server.
		 * 
		 * @param productCode the product code
		 * @param licenseValues contains the values retrieved from the license. (must not be null)
		 * @return value like (RESPONSE_OK, RESPONSE_INVALID_PRODUCT)
		 */
		public function getLicenseInfo(productCode:String, licenseValues:Map):int
		{
			var ret:int = context.call("getLicenseInfo_air", productCode, licenseValues) as int;
			
			return ret;
		}
		
		/**
		 * This method retrieves a list of products that currently have licenses on this machine.
		 * Note that they might be old or expired licenses
		 * 
		 * @return Array of Objects each having String properties "product" and "description"
		 */
		public function getLicensedProducts():Array
		{
			var ret:Array = context.call("getLicensedProducts_air") as Array;
			
			return ret;
		}
		
		/**
		 * This method generates a key for this machine to use on the Manual License Request website.  A manual license type is useful when a user is operating offline
		 * most of the time.  A user can request a manual license, and later paste the response string into
		 * a form at <a href='https://license.nitromation.com/NitroLicenseServer/SWF/NitroOL.html'>https://license.nitromation.com/NitroLicenseServer/SWF/NitroOL.html</a> when online.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETMANUAL</code>.
		 * 
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @param market_source if used, should be equal to "LIC-"+licensee_name or "RES-"+reseller_name
		 * @return String - the manual license request string to paste into the manual request website when online.
		 * 
		 * @see #applyManualLicense()
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETMANUAL
		 */
		public function getManualLicense(productCode:String, version:String, market_source:String):String
		{
			var ret:String = context.call("getManualLicense_air", productCode, version, market_source) as String;
			
			return ret;
		}
		
		/**
		 * This method retrieves server messages for a given user.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_MESSAGES</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.  event.data contains an Array of Objects having String properties subject and body.
		 * First character of body == space if the message has already been read, * (asterisk) if it's a new unread message
		 * 
		 * @param email the email address to retrieve messages for
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @param days the number of days back to look for messages
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_MESSAGES
		 */
		public function getMessages(email:String, version:String, days:int):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getMessages_air", email, version, days);
		}
		
		/**
		 * This method retrieves session data.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_SESSIONDATA</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation. event.data contains a Map containing keys and values.
		 * event.response will be equal to NLMConstants.RESPONSE_SESS_TIMEOUT if the session has timed out.
		 * 
		 * @param version the version (null, "", or "0" will skip version checking)
		 * @param appid the application identifier
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_SESSIONDATA
		 * @see NLMConstants#RESPONSE_SESS_TIMEOUT
		 */
		public function getSessionData(version:String, appid:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getSessionData_air", version, appid);
		}
		
		/**
		 * This method retrieves a user variable from the server.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_GETUSERVAR</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation. event.data contains a Map containing keys and values.
		 * 
		 * @param productCode the product code
		 * @param varname the user variable name to retrieve
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_GETUSERVAR
		 */
		public function getUserVar(productCode:String, varname:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("getUserVar_air", productCode, varname);
		}
		
		/**
		 * This method checks to see if this machine has any licenses on it for any product.  Use <code>validate</code>
		 * to see if a license is actually valid and not expired or disabled.
		 * 
		 * @return true if licenses exist, false otherwise
		 * 
		 * @see #validate()
		 */
		public function hasLicenses():Boolean
		{
			var ret:Boolean = context.call("hasLicenses_air") as Boolean;
			
			return ret;
		}
		
		/**
		 * This method increments the usage counter for the given product
		 * 
		 * @param productCode the product code
		 */
		public function incUsageCounter(productCode:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("incUsageCounter_air", productCode);
		}
		
		/**
		 * This method writes a log entry on the NitroLM server.  The first time you use a particular report name,
		 * the varnames parameter will specify what variables belong on the report.  After that, you must either pass the same list of varnames
		 * each time you use that particular report name, or you must pass null for the varnames parameter.
		 * If you pass a different list of varnames to an existing report, you will get a NLMConstants.RESPONSE_VARS_MISMATCH error.
		 * This function does not set any variable names, rather just stores the current values.
		 * 
		 * @param productCode the product code
		 * @param report the report name you want to log variables to
		 * @param varnames variable names that you want to store current values of along with this log entry
		 */
		public function logVariables(productCode:String, report:String, varnames:Array):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("logVariables_air", productCode, report, varnames);
		}
		
		/**
		 * @private Don't display this because it's for internal use only
		 */
		public function purgeUser(email:String):int
		{
			var ret:int = context.call("purgeUser_air", email) as int;
			
			return ret;
		}
		
		/**
		 * This method retrieves the usage counter
		 * 
		 * @param productCode the product code
		 * @return the current usage counter value
		 */
		public function readUsageCounter(productCode:String):int
		{
			var ret:int = context.call("readUsageCounter_air", productCode) as int;

			return ret;
		}
		
		/**
		 * This method releases a license so that others can use it
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_RELEASELICENSE</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @param serveronly this parameter can only be set to true for Floating licenses.  Setting serveronly to true for a floating
		 * license will cause the license to be automatically re-acquired the next time you try to use the license.  Until then
		 * other users will be able to use the license.
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_RELEASELICENSE
		 * @see NLMConstants#RESPONSE_RELEASED
		 */
		public function releaseLicense(productCode:String, version:String, serveronly:Boolean = false):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("releaseLicense_air", productCode, version, serveronly);
		}

		/**
		 * This method renews a LOCK_FIXED (checkout) license for an additional number of days.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_RENEWLICENSE</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @param days the value should be 0 for a floating license.  The days value is ignored for demo licenses.
		 * If you specify days>0 on a floating license then the license will be converted to a checked-out license.
		 *
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_RENEWLICENSE
		 */
		public function renewLicense(productCode:String, version:String, days:int):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("renewLicense_air", productCode, version, days);
		}
		
		/**
		 * This method will refresh the user's current license.  A refresh is like a renew, except that it does not extend the valid period of the license.
		 * It can be used to acquire the most current license information from the server, such as updated license variables, libraries, or administrator-updated 
		 * expiration dates.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_REFRESHLICENSE</code>.
		 * @param productCode The product code for the license.
		 * @param version The version of the product for the license.  Used for version checking; pass a blank string or null to omit the version check.
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_REFRESHLICENSE
		 */
		public function refreshLicense(productCode:String, version:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("refreshLicense_air", productCode, version);
		}
		
		/**
		 * This method requests a product decryption key to be downloaded from the NitroLM server.  If you're using EncryptedModuleLoader, EncryptedModuleManager, decryptAndLoad(), or decryptAndLoadRSL(), you don't need to call this method
		 * as it's called internally.
		 * You must have a valid license for the product specified in order to call this method.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_KEY</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation. event.data contains a HashMap with the key "key".
		 * 
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_KEY
		 * @see #decryptAndLoad()
		 * @see #decryptAndLoadRSL()
		 */
		public function requestKey(productCode:String, version:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("requestKey_air", productCode, version);
		}
		
		/**
		 * This method will allow the user to reset their password.  It will cause an email to be sent to the user that contains a link to the reset-password web page.
		 * <p>
		 * The source field has a dual purpose.  It can either 
		 * <ol>
		 * <li> contain freeform text indicating where the user heard of the software, or</li> 
		 * <li> contain a special code to indicate that the user will be associated with a licensee or reseller even before they get a 
		 * license for any product.  The code will be LIC-&lt;company code&gt; for a licensee, or RES-&lt;company code&gt; for a reseller.  (For example, LIC-acme27)</li>
		 * </ol>
		 * Besides associating the user with a particular licensee or reseller, using the special code will also let the server locate the 
		 * custom email templates, if any, that were defined for that licensee/reseller. 
		 * </p>
		 * @param email The user's email address.
		 * @param source The user's or application's market_source.  The application can set its own special market_source value which will override the user's value for this one function.
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_RESET_PASSWORD
		 */
		public function resetPassword(email:String, market_source:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("resetPassword_air", email, market_source);
		}
		
		/**
		 * This method sends a confirmation code that the user received in an e-mail to the NitroLM server in order
		 * to confirm them as a valid user.  This method is only used if NLMConstants.CONFIRM_MAIL_BOTH or CONFIRM_MAIL_CODEONLY was sent to createUser().
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_CONFIRM</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param email the user's e-mail address
		 * @param code the value received in the user's confirmation e-mail.
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_CONFIRM
		 * @see NLMConstants#CONFIRM_MAIL_CODEONLY
		 */
		public function sendConfirm(email:String, code:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("sendConfirm_air", email, code);
		}
		
		/**
		 * This method sends a reseller survey.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_SURVEY</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param reseller the reseller's name
		 * @param data key/value pairs of data that are of interest to the reseller
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_SURVEY
		 */
		public function sendSurvey(reseller:String, data:Map):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("sendSurvey_air", reseller, data);
		}
		
		/**
		 * This method saves a user file on the license server.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_SETUSERFILE</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param productCode the product code
		 * @param filename the file's name
		 * @param filedata file data to store
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_SETUSERFILE
		 */
		public function setUserFile(productCode:String, filename:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("setUserFile_air", productCode, filename);
		}
		
		/**
		 * This method sets a user-specific variable on the license server.
		 * It dispatches a <code>LicenseClientEvent</code> of type <code>LicenseClientEvent.LICENSE_RESPONSE</code> with a req_type of
		 * <code>NLMConstants.REQUEST_SETUSERVAR</code>.
		 * Use NLMConstants.responseToString(event.response) in your event handler to determine the result of this operation.
		 * 
		 * @param productCode the product code
		 * @param varname varname is restricted to names that the admin has predefined in NitroAdmin for the licensee variables.
		 * @param value the value to set
		 * 
		 * @see LicenseClientEvent
		 * @see NLMConstants#REQUEST_SETUSERVAR
		 */
		public function setUserVar(productCode:String, varname:String, value:String):void
		{
			context.addEventListener(StatusEvent.STATUS, handleStatusEvent);
			context.call("setUserVar_air", productCode, varname, value);
		}
		
		/**
		 * This method checks to see if this machine already has a valid license to run this product/version combination.
		 * It also causes a floating license to be auto-renewed.
		 * 
		 * @param productCode the product code
		 * @param version the product version (null, "", or "0" will skip version checking)
		 * @return value like (RESPONSE_OK, RESPONSE_INVALID_PRODUCT, RESPONSE_INVALID_LICENSE, RESPONSE_DISABLED_RENEW, RESPONSE_EXCEEDED_MAX_EXEC, RESPONSE_DISABLED_RENEW_DEMO)
		 */
		public function validate(productCode:String, version:String):int
		{
			var ret:int = context.call("validate_air", productCode, version) as int;
			
			return ret;
		}
		
		/**
		 * Get the current HTTP proxy settings.  Since all communication to the server happens inside native code, we can't rely on AIR's automatic proxy support.
		 * 
		 * @return Map containing the keys host, port, user, password, and nonProxyHosts
		 */
		public function getProxy():Map
		{
			var ret:Map = context.call("getProxy_air") as Map;
			
			return ret;
		}

		/**
		 * Set HTTP proxy settings for communicating to NitroLM.  This only needs to be done one time.  NitroLM saves the proxy information to its local database file.
		 * 
		 * @param host the hostname of the http proxy server (e.g. proxy.company.com)
		 * @param port the port of the http proxy server (e.g. 8080)
		 * @param user the username for the proxy server.  null if the server doesn't require authentication
		 * @param password the password for the proxy server.  null if the server doesn't require authentication.
		 * @param nonProxyHosts comma-separated list of addresses to bypass the proxy server
		 */
		public function setProxy(host:String, port:int=80, user:String=null, pass:String=null, nonProxyHosts:String=null):int
		{
			var ret:int = context.call("setProxyHost_air", host, port, user, pass, nonProxyHosts) as int;
			
			return ret;
		}
		
		/**
		 * Used internally by EncryptedModuleLoader and EncryptedModuleManager to decrypt and load encrypted SWF modules completely in native code
		 */
		public function decryptAndLoad(moduleInfo:Object, applicationDomain:ApplicationDomain, securityDomain:SecurityDomain, swfBytes:ByteArray, initHandler:Function, errorHandler:Function, completeHandler:Function):int
		{
			var ret:int = context.call("decryptAndLoad_air", moduleInfo, applicationDomain, securityDomain, swfBytes, initHandler, errorHandler, completeHandler) as int;
			
			return ret;
		}

		/**
		 * Decrypts and loads RSL swf code completely from native code.  Pass in the encrypted RSL bytes to have the system load its code into the AIR runtime.
		 * 
		 * @param e_bytes encrypted bytes from your RSL swf.
		 * @param applicationDomain the application domain to load the code into
		 * @param loadRSLComplete - callback function handler for when code decryption and loading is done.
		 * 
		 * @return RESPONSE_OK if everything succeeded
		 */
		public function decryptAndLoadRSL(e_bytes:ByteArray, applicationDomain:ApplicationDomain, loadRSLComplete:Function):int
		{
			var ret:int = context.call("decryptAndLoadRSL_air", e_bytes, applicationDomain, loadRSLComplete) as int;
			
			return ret;
		}
	}
	
}