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
package com.nitrolm.comp
{
	import com.nitrolm.LicenseClient;
	import com.nitrolm.LicenseClientEvent;
	import com.nitrolm.NLMConstants;
	import com.nitrolm.comp.skins.LoginSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	import mx.collections.ArrayList;
	import mx.states.State;
	
	import spark.components.Button;
	import spark.components.CheckBox;
	import spark.components.DropDownList;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import spark.components.TextInput;
	import spark.events.IndexChangeEvent;
	import spark.events.TextOperationEvent;

	[SkinState("login")]
	[SkinState("forgotpassword")]
	[SkinState("changepassword")]
	[SkinState("demo")]
	[SkinState("register")]

	[Event(name="licenseResponse", type="com.nitrolm.LicenseClientEvent")]
	
	/**
	 * A Skinnable login component.  It helps in handling logins, new user registration, password resets, and password changes.
	 */
	public class Login extends SkinnableContainer
	{
		
		[SkinPart(required=true)]
		public var emailTextInput:TextInput;
		
		[SkinPart(required=true)]
		public var passwordTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var corpIdTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var forgotPasswordCheckBox:CheckBox;
		
		[SkinPart(required=false)]
		public var licenseTypeDropDownList:DropDownList;
		
		[SkinPart(required=false)]
		public var registerButton:Button;
		
		[SkinPart(required=true)]
		public var submitButton:Button;
		
		[SkinPart(required=false)]
		public var statusLabel:Label;
		
		public var productCode:String = null;
		
		public var productVersion:String = null;
		
		public var email:String = "";
		
		public var corpId:String = "";
		
		/**
		 * Set the market source to "LIC-"+licensee_name
		 */
		public var marketSource:String = "LIC-???????";
		
		/**
		 * Override with the name of your application
		 */
		public var registrationSource:String = "Nitro-LM Login Component";
		
		public var mailType:int = NLMConstants.CONFIRM_MAIL_LINKONLY;
		
		private var licenseTypes:ArrayList = new ArrayList(["Floating","Checkout","Demo"]);
		
		public var checkoutDays:int = 5;
		
		public var demoDays:int = 5;
		
		[Bindable]
		public var statusText:String;
		
		private var lastState:String;
		
		//register
		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show first name on user registration screen
		 */
		public var firstNameRequired:Boolean = true;
		
		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show last name on user registration screen
		 */
		public var lastNameRequired:Boolean = true;

		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show phone on user registration screen
		 */
		public var phoneRequired:Boolean = true;

		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show address on user registration screen
		 */
		public var addressRequired:Boolean = true;

		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show city on user registration screen
		 */
		public var cityRequired:Boolean = true;

		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show state on user registration screen
		 */
		public var stateRequired:Boolean = true;
		
		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show zip on user registration screen
		 */
		public var zipRequired:Boolean = true;
		
		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show country on user registration screen
		 */
		public var countryRequired:Boolean = true;
		
		[Bindable]
		[Inspectable(category="General", defaultValue="true")]
		/**
		 * show user company on user registration screen.  A text input for the company a user works for.
		 */
		public var userCompanyRequired:Boolean = true;
		
		[Bindable]
		[Inspectable(category="General", defaultValue="false")]
		/**
		 * if true, upon registration, user will have to provide a corporate id.  The user's email will be validated against pool restrictions under this corpid to ensure the user will be allowed to get a license.
		 */  
		public var corpIdRequired:Boolean = false;
		
		[SkinPart(required=false)]
		public var passwordConfirmTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var firstNameTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var lastNameTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var phoneTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var address1TextInput:TextInput;
		
		[SkinPart(required=false)]
		public var address2TextInput:TextInput;

		[SkinPart(required=false)]
		public var cityTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var stateTextInput:TextInput;

		[SkinPart(required=false)]
		public var zipTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var countryTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var userCompanyTextInput:TextInput;
		
		//changepassword
		[SkinPart(required=false)]
		public var oldPasswordTextInput:TextInput;
		
		[SkinPart(required=false)]
		public var changePasswordButton:Button;

		public function Login()
		{
			super();
			
			states = new Array();
			
			for each (var name:String in ['login', 'forgotpassword', 'changepassword', 'demo', 'register']) {
				var state:State = new State();
				state.name = name;
				states.push(state);
			}
			
			currentState = "login";
			
			setStyle("skinClass", LoginSkin);
			
			//see if we have any stored e-mails or corporate ids to auto-set for the user
			var so:SharedObject = SharedObject.getLocal("nitrolm", "/");
			if(so.data.hasOwnProperty("email"))
				email = so.data.email;
			if(so.data.hasOwnProperty("corpid"))
				corpId = so.data.corpid;
		}
		
		override protected function getCurrentSkinState():String
		{
			return currentState;
		} 
		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance);
			
			if(emailTextInput == instance)
			{
				emailTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
				emailTextInput.text = email;
				if(email.length == 0)
				{
					callLater(emailTextInput.setFocus);
				}
			}
			else if(passwordTextInput == instance)
			{
				passwordTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
				if(email.length > 0)
				{
					callLater(passwordTextInput.setFocus);
				}
			}
			else if(corpIdTextInput == instance)
			{
				corpIdTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
				corpIdTextInput.text = corpId;
			}
			else if(licenseTypeDropDownList == instance)
			{
				licenseTypeDropDownList.dataProvider = licenseTypes;
				licenseTypeDropDownList.addEventListener(IndexChangeEvent.CHANGE, handleLicenseTypeChange);
			}
			else if(forgotPasswordCheckBox == instance)
			{
				forgotPasswordCheckBox.addEventListener(Event.CHANGE, handleForgotPasswordChange);
			}
			else if(registerButton == instance)
			{
				registerButton.addEventListener(MouseEvent.CLICK, handleRegisterClick);
			}
			else if(passwordConfirmTextInput == instance)
			{
				passwordConfirmTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(firstNameTextInput == instance)
			{
				firstNameTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(lastNameTextInput == instance)
			{
				lastNameTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(phoneTextInput == instance)
			{
				phoneTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(address1TextInput == instance)
			{
				address1TextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(cityTextInput == instance)
			{
				cityTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(stateTextInput == instance)
			{
				stateTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(zipTextInput == instance)
			{
				zipTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(countryTextInput == instance)
			{
				countryTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(userCompanyTextInput == instance)
			{
				userCompanyTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(oldPasswordTextInput == instance)
			{
				oldPasswordTextInput.addEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(changePasswordButton == instance)
			{
				changePasswordButton.addEventListener(MouseEvent.CLICK, handleChangePasswordClick);
			}
			else if(submitButton == instance)
			{
				submitButton.addEventListener(MouseEvent.CLICK, handleSubmitClick);
				defaultButton = submitButton;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);

			if(emailTextInput == instance)
			{
				emailTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(passwordTextInput == instance)
			{
				passwordTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(corpIdTextInput == instance)
			{
				corpIdTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(licenseTypeDropDownList == instance)
			{
				licenseTypeDropDownList.removeEventListener(IndexChangeEvent.CHANGE, handleLicenseTypeChange);
			}
			else if(forgotPasswordCheckBox == instance)
			{
				forgotPasswordCheckBox.removeEventListener(Event.CHANGE, handleForgotPasswordChange);
			}
			else if(registerButton == instance)
			{
				registerButton.removeEventListener(MouseEvent.CLICK, handleRegisterClick);
			}
			else if(passwordConfirmTextInput == instance)
			{
				passwordConfirmTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(firstNameTextInput == instance)
			{
				firstNameTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(lastNameTextInput == instance)
			{
				lastNameTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(phoneTextInput == instance)
			{
				phoneTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(address1TextInput == instance)
			{
				address1TextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(cityTextInput == instance)
			{
				cityTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(stateTextInput == instance)
			{
				stateTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(zipTextInput == instance)
			{
				zipTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(countryTextInput == instance)
			{
				countryTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(userCompanyTextInput == instance)
			{
				userCompanyTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(oldPasswordTextInput == instance)
			{
				oldPasswordTextInput.removeEventListener(TextOperationEvent.CHANGE, handleTextChange);
			}
			else if(submitButton == instance)
			{
				submitButton.removeEventListener(MouseEvent.CLICK, handleSubmitClick);
			}
		}

		/**
		 * Check a regex for a valid email.
		 * no email regex is perfect, but it's good enough for most cases.
		 */
		public static function isValidEmail(email:String):Boolean 
		{ 
			var emailExpression:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+.)+[A-Z]{2,4}$/i;
			return emailExpression.test(email);
		}
		
		/**
		 * handle various changes to text inputs to determine whether to enable the submit button
		 */
		protected function handleTextChange(event:TextOperationEvent):void
		{
			if(currentState == "login")
			{
				if(emailTextInput != null && Login.isValidEmail(emailTextInput.text) &&
				   passwordTextInput != null && passwordTextInput.text.length > 0 && 
				   ((corpIdTextInput != null && corpIdTextInput.text.length > 0)||(corpId!=null && corpId.length>0)))
				{
					submitButton.enabled = true;
				}
				else
				{
					submitButton.enabled = false;
				}
			}
			else if(currentState == "demo")
			{
				if(emailTextInput != null && Login.isValidEmail(emailTextInput.text) &&
				   passwordTextInput != null && passwordTextInput.text.length > 0)
				{
					submitButton.enabled = true;
				}
				else
				{
					submitButton.enabled = false;
				}
			}
			else if(currentState == "forgotpassword")
			{
				if(emailTextInput != null && Login.isValidEmail(emailTextInput.text))
				{
					submitButton.enabled = true;
				}
				else
				{
					submitButton.enabled = false;
				}
			}
			else if(currentState == "changepassword")
			{
				if(emailTextInput != null && Login.isValidEmail(emailTextInput.text) &&
					passwordTextInput != null && passwordTextInput.text.length > 0 &&
					passwordConfirmTextInput != null && passwordConfirmTextInput.text == passwordTextInput.text &&
					oldPasswordTextInput != null && oldPasswordTextInput.text.length > 0)
				{
					submitButton.enabled = true;
				}
				else
				{
					submitButton.enabled = false;
				}
			}
			else if(currentState == "register")
			{
				if(emailTextInput != null && Login.isValidEmail(emailTextInput.text) &&
				   passwordTextInput != null && passwordTextInput.text.length > 0 &&
				   passwordConfirmTextInput != null && passwordConfirmTextInput.text == passwordTextInput.text &&
				   (!firstNameRequired || (firstNameTextInput != null && firstNameTextInput.text.length > 0)) &&
				   (!lastNameRequired || (lastNameTextInput != null && lastNameTextInput.text.length > 0)) &&
				   (!phoneRequired || (phoneTextInput != null && phoneTextInput.text.length > 0)) &&
				   (!addressRequired || (address1TextInput != null && address1TextInput.text.length > 0)) &&
				   (!cityRequired || (cityTextInput != null && cityTextInput.text.length > 0)) &&
				   (!stateRequired || (stateTextInput != null && stateTextInput.text.length > 0)) &&
				   (!zipRequired || (zipTextInput != null && zipTextInput.text.length > 0)) &&
				   (!countryRequired || (countryTextInput != null && countryTextInput.text.length > 0)) &&
				   (!userCompanyRequired || (userCompanyTextInput != null && userCompanyTextInput.text.length > 0)) &&
				   (!corpIdRequired || (corpIdTextInput != null && corpIdTextInput.text.length > 0))
				  )
				{
					submitButton.enabled = true;
				}
				else
				{
					submitButton.enabled = false;
				}
			}
		}
		
		protected function handleForgotPasswordChange(event:Event):void
		{
			if(forgotPasswordCheckBox.selected)
			{
				currentState = "forgotpassword";
			}
			else
			{
				currentState = "login";
			}
			
			handleTextChange(null);
			invalidateSkinState();
		}
		
		protected function handleLicenseTypeChange(event:IndexChangeEvent):void
		{
			if(licenseTypeDropDownList.selectedItem == "Demo")
			{
				currentState = "demo";
			}
			else
			{
				currentState = "login"
			}

			handleTextChange(null);
			invalidateSkinState();
		}
		
		protected function handleRegisterClick(event:MouseEvent):void
		{
			if(currentState == "register")
			{
				currentState = lastState;
				statusText = "";
			}
			else
			{
				lastState = currentState;
				currentState = "register";
			}
			handleTextChange(null);
			invalidateSkinState();
		}
		
		protected function handleChangePasswordClick(event:MouseEvent):void
		{
			if(currentState == "changepassword")
			{
				currentState = lastState;
				statusText = "";
			}
			else
			{
				lastState = currentState;
				currentState = "changepassword";
			}
			handleTextChange(null);
			invalidateSkinState();
		}

		protected function handleSubmitClick(event:MouseEvent):void
		{
			cursorManager.setBusyCursor();
			statusText = "";
			var licenseClient:LicenseClient = new LicenseClient();
			
			if(currentState == "login")
			{
				if(licenseTypeDropDownList.selectedItem == "Floating")
				{
					licenseClient.addEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
					licenseClient.getLicense(emailTextInput.text, passwordTextInput.text, corpIdTextInput == null ? corpId : corpIdTextInput.text, productCode, productVersion, NLMConstants.LOCK_FLOATING, 0, marketSource);
					passwordTextInput.text = "";
				}
				else
				{
					licenseClient.addEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
					licenseClient.getLicense(emailTextInput.text, passwordTextInput.text, corpIdTextInput == null ? corpId : corpIdTextInput.text, productCode, productVersion, NLMConstants.LOCK_FIXED, checkoutDays, marketSource);
					passwordTextInput.text = "";
				}
			}
			else if(currentState == "demo")
			{
				licenseClient.addEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
				licenseClient.getLicense(emailTextInput.text, passwordTextInput.text, null, productCode, productVersion, NLMConstants.LOCK_DEMO, demoDays, marketSource);
				passwordTextInput.text = "";
			}
			else if(currentState == "forgotpassword")
			{
				licenseClient.addEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
				licenseClient.resetPassword(emailTextInput.text, marketSource);
			}
			else if(currentState == "changepassword")
			{
				licenseClient.addEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
				licenseClient.changePassword(emailTextInput.text, oldPasswordTextInput.text, passwordTextInput.text, passwordConfirmTextInput.text);
				oldPasswordTextInput.text = "";
				passwordTextInput.text = "";
				passwordConfirmTextInput.text = "";
			}
			else if(currentState == "register")
			{
				licenseClient.addEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
				licenseClient.createUser(emailTextInput.text, 
										 passwordTextInput.text, 
										 firstNameRequired ? firstNameTextInput.text : "-----", 
										 lastNameRequired ? lastNameTextInput.text : "-----", 
										 phoneRequired ? phoneTextInput.text : "-----",
										 addressRequired ? address1TextInput.text : "-----",
										 addressRequired && address2TextInput != null ? address2TextInput.text : "",
										 cityRequired ? cityTextInput.text : "-----",
										 stateRequired ? stateTextInput.text : "--",
										 zipRequired ? zipTextInput.text : "-----",
										 countryRequired ? countryTextInput.text : "-----",
										 userCompanyRequired ? userCompanyTextInput.text : "-----",
										 marketSource,
										 corpIdRequired ? corpIdTextInput.text : null,
										 productVersion,
										 registrationSource,
										 mailType,
										 null);
				passwordTextInput.text = "";
				passwordConfirmTextInput.text = "";
			}
			
		}
		
		protected function handleLicenseResponse(event:LicenseClientEvent):void
		{
			cursorManager.removeBusyCursor();
			var licenseClient:LicenseClient = event.target as LicenseClient;
			
			licenseClient.removeEventListener(LicenseClientEvent.LICENSE_RESPONSE, handleLicenseResponse);
			
			if(event.req_type == NLMConstants.REQUEST_GETLICENSE && event.response == NLMConstants.RESPONSE_OK)
			{
				statusText = "";
				var so:SharedObject = SharedObject.getLocal("nitrolm", "/");
				so.data.email = emailTextInput.text;
				if(currentState == "login")
				{
					so.data.corpid = corpIdTextInput.text;
				}
				so.flush();
			}
			else
			{
				statusText = NLMConstants.requestToString(event.req_type)+" Response: " + NLMConstants.responseToString(event.response);
			}
			dispatchEvent(event);
		}
	}
}