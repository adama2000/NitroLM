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
	/**
	 * This class holds constants describing request, response, and custom value types
	 */
	public class NLMConstants
	{
		// requests 
		/**
		 * Get License
		 * @see LicenseClient#getLicense()
		 */
		public static const REQUEST_GETLICENSE:int = 1;
		
		/**
		 * Renew License
		 * @see LicenseClient#renewLicense()
		 */
	    public static const REQUEST_RENEWLICENSE:int = 2;
		
		/**
		 * Release License
		 * @see LicenseClient#releaseLicense()
		 */
	    public static const REQUEST_RELEASELICENSE:int = 3;
		
		/**
		 * Create New User
		 * @see LicenseClient#createUser()
		 */
	    public static const REQUEST_NEWUSER:int = 4;
		
		/**
		 * Check Version
		 */
	    public static const REQUEST_VERCHECK:int = 5;
		
		/**
		 * Check User
		 * @see LicenseClient#checkUser()
		 */
	    public static const REQUEST_CHKUSER:int = 6;
		
		/**
		 * Verify App
		 */
	    public static const REQUEST_VERIFYAPP:int = 7;
		
		/**
		 * Support Request
		 * @see LicenseClient#emailSupport()
		 */
	    public static const REQUEST_SUPPORT:int = 8;
		
		/**
		 * Key Request
		 * @see LicenseClient#requestKey()
		 */
	    public static const REQUEST_KEY:int = 9;
		
		/**
		 * Messages Request
		 * @see LicenseClient#getMessages()
		 */
	    public static const REQUEST_MESSAGES:int = 10;
		
		/**
		 * Set Exec Counter
		 * @see LicenseClient#incUsageCounter()
		 */
	    public static const REQUEST_SETEXECCTR:int = 11;
		
		/**
		 * Set User Variable
		 * @see LicenseClient#setUserVar()
		 */
	    public static const REQUEST_SETUSERVAR:int = 12;
		
		/**
		 * Get User Variable
		 * @see LicenseClient#getCustomValue()
		 */
	    public static const REQUEST_GETUSERVAR:int = 13;
		
		/**
		 * Get Manual License
		 * @see LicenseClient#getManualLicense()
		 */
	    public static const REQUEST_GETMANUAL:int = 14;
		
		/**
		 * Get User Info
		 */
	    public static const REQUEST_GETUSERINFO:int = 15;
		
		/**
		 * Get Products
		 * @see LicenseClient#getLicensedProducts()
		 */
	    public static const REQUEST_GETPRODUCTS:int = 16;
		
		/**
		 * @private
		 */
	    public static const REQUEST_PURGEUSER:int = 17;
		
		/**
		 * Set User File
		 * @see LicenseClient#setUserFile()
		 */
	    public static const REQUEST_SETUSERFILE:int = 18;
		
		/**
		 * Log Variables
		 * @see LicenseClient#logVariables()
		 */
	    public static const REQUEST_LOGVARS:int = 19;
		
		/**
		 * Get App Login
		 * @see LicenseClient#getAppLogin()
		 */
	    public static const REQUEST_GETAPPLOGIN:int = 20;
		
		/**
		 * Session Data
		 * @see LicenseClient#getSessionData()
		 */
	    public static const REQUEST_SESSIONDATA:int = 21;
		
		/**
		 * Get License AppId
		 * @see LicenseClient#getLicenseAppid()
		 */
	    public static const REQUEST_GETLICENSE_APPID:int = 22;
		
		/**
		 * Get License Default
		 * @see LicenseClient#getLicenseDefault()
		 */
	    public static const REQUEST_GETLICENSE_DEFAULT:int = 23;
		
		/**
		 * Change Password
		 * @see LicenseClient#changePassword()
		 */
	    public static const REQUEST_CHANGE_PASSWORD:int = 24;
		
		/**
		 * Send Batch
		 */
	    public static const REQUEST_SENDBATCH:int = 25;
		
		/**
		 * Reset Password
		 * @see LicenseClient#resetPassword()
		 */
	    public static const REQUEST_RESET_PASSWORD:int = 26;
		
		/**
		 * Refresh License
		 * @see LicenseClient#refreshLicense()
		 */
	    public static const REQUEST_REFRESHLICENSE:int = 27;
		
		/**
		 * @private
		 */
	    public static const REQUEST_PRODUCT_KEY_PRIVATE:int = 28;
		
		/**
		 * Extend Product
		 * @see LicenseClient#extendProduct()
		 */
	    public static const REQUEST_EXTEND_PRODUCT:int = 29;
		
		/**
		 * Test Connection
		 */
	    public static const REQUEST_CONNTEST:int = 99;
	    
		//amw
		/**
		 * Confirm a user's email account
		 * @see LicenseClient#sendConfirm()
		 */
	    public static const REQUEST_CONFIRM:int = 990;
		
		/**
		 * Send a survey.  For example, when someone quits without registering, have them answer a few questions to find out why.
		 * @see LicenseClient#sendSurvey()
		 */
		public static const REQUEST_SURVEY:int = 991;
		
		// responses
		/**
		 * Ok
		 */
		public static const RESPONSE_OK:int = 0;
		
		/**
		 * Missing Input
		 */
		public static const RESPONSE_MISSINGINPUT:int = 1;
		
		/**
		 * Client is out of date
		 */
		public static const RESPONSE_CLIENT_OUT_OF_DATE:int = 2;
		
		/**
		 * User confirmation is required - Check your e-mail
		 */
		public static const RESPONSE_CONFIRMATION_REQUIRED:int = 3;
		
		/**
		 * An internal error has occurred on the LM server
		 */
		public static const RESPONSE_INTERNAL_ERROR:int = 4;
		
		/**
		 * No free licenses available
		 */
		public static const RESPONSE_NO_FREE_LICENSES:int = 5;
		
		/**
		 * Invalid or missing License
		 */
		public static const RESPONSE_INVALID_LICENSE:int = 6;
		
		/**
		 * Need a new version of the product
		 */
		public static const RESPONSE_NEED_NEW_VERSION:int = 7;
		
		/**
		 * No key found for product
		 */
	    public static const RESPONSE_NO_KEY:int = 8;
		
		/**
		 * Unable to decrypt data
		 */
	    public static const RESPONSE_NO_DECRYPT:int = 9;
		
		/**
		 * User password is incorrect
		 */
	    public static const RESPONSE_BAD_PASSWORD:int = 10;
		
		/**
		 * New user, need additional info
		 */
	    public static const RESPONSE_NEED_NEW_USER:int = 11;
		
		/**
		 * Unknown company specified
		 */
	    public static const RESPONSE_INVALID_COMPANY:int = 12;
	
//		public static const RESPONSE_INVALID_PRODUCT_LICENSEE:int = 13;
		
		/**
		 * Unknown product specified
		 */
	    public static const RESPONSE_INVALID_PRODUCT:int = 13;
		
		/**
		 * Invalid number of days specified
		 */
	    public static const RESPONSE_INVALID_DAYS:int = 14;
		
		/**
		 * User is unknown
		 */
	    public static const RESPONSE_UNKNOWN_USER:int = 15;
		
		/**
		 * User already exists
		 */
	    public static const RESPONSE_USER_ALREADY_EXISTS:int = 16;
		
		/**
		 * Not allowed to release license
		 */
	    public static const RESPONSE_BAD_RELEASE:int = 17;
		
		/**
		 * License has been released
		 */
	    public static const RESPONSE_RELEASED:int = 18;
		
		/**
		 * License has expired and must be renewed
		 */
	    public static const RESPONSE_EXPIRED:int = 19;
		
		/**
		 * License cannot be renewed
		 */
	    public static const RESPONSE_NO_RENEW:int = 20;
		
		/**
		 * Unknown machine specified
		 */
	    public static const RESPONSE_INVALID_MACHINE:int = 21;
		
		/**
		 * Error occurred trying to send email
		 */
	    public static const RESPONSE_EMAIL_ERROR:int = 22;
		
		/**
		 * Sales confirmation is required - Check your e-mail
		 */
	    public static const RESPONSE_SALESCONFIRM_REQUIRED:int = 23;
		
		/**
		 * New version information included in message
		 */
	    public static const RESPONSE_VERINFO:int = 24;
		
		/**
		 * Demo License has expired and must be renewed
		 */
	    public static const RESPONSE_EXPIRED_DEMO:int = 25;
		
		/**
		 * Could not connect to server
		 */
	    public static const RESPONSE_NO_CONNECT:int = 26;
		
		/**
		 * No MAC address or Network card found
		 */
	    public static const RESPONSE_NO_MACIDS:int = 27;
		
		/**
		 * Application name not found
		 */
	    public static const RESPONSE_INVALID_APP:int = 28;
		
		/**
		 * Application info included in message
		 */
	    public static const RESPONSE_APPINFO:int = 29;
		
		/**
		 * Invalid lock type
		 */
	    public static const RESPONSE_INVALID_LOCKTYPE:int = 30;
		
		/**
		 * Could not execute application
		 */
	    public static const RESPONSE_NOEXEC:int = 31;
		
		/**
		 * Invalid file name
		 */
	    public static const RESPONSE_INVALID_FILE:int = 32;
		
		/**
		 * Invalid arguments to clientexec
		 */
	    public static const RESPONSE_BAD_ARGUMENTS:int = 33;
		
		/**
		 * Output file not found
		 */
	    public static const RESPONSE_NO_OUTFILE:int = 34;
		
		/**
		 * Cannot return data when 'wait' is false
		 */
	    public static const RESPONSE_BAD_PULL:int = 35;
		
		/**
		 * User confirmation has timed out
		 */
	    public static const RESPONSE_CONFIRM_EXPIRED:int = 36;
		
		/**
		 * New passwords do not match
		 */
	    public static const RESPONSE_PWD_MATCH:int = 37;
		
		/**
		 * Invalid support request type
		 */
	    public static const RESPONSE_INVALID_SUPPORT_TYPE:int = 38;
		
		/**
		 * Exceeded maximum execution limit for this license
		 */
	    public static const RESPONSE_EXCEEDED_MAX_EXEC:int = 39;
		
		/**
		 * Invalid request type from client to server
		 */
	    public static const RESPONSE_BAD_REQUEST:int = 40;
		
		/**
		 * Reached the execution warning limit for this license
		 */
	    public static const RESPONSE_EXCEEDED_WARN_EXEC:int = 41;
		
		/**
		 * An internal error has occurred on the LM client
		 */
	    public static const RESPONSE_INTERNAL_CLIENT_ERROR:int = 42;
		
		/**
		 * The company code used has not purchased any licenses for this product
		 */
	    public static const RESPONSE_NO_LICENSES_FOR_CO:int = 43;
		
		/**
		 * There are unread messages
		 */
	    public static const RESPONSE_HASMESSAGES:int = 44;
		
		/**
		 * There are no unread messages
		 */
	    public static const RESPONSE_NOMESSAGES:int = 45;

//		public static const RESPONSE_CANT_SERIALIZE:int = 46;
		
		/**
		 * Cannot validate manual license request
		 */		
	    public static const RESPONSE_BAD_MANUAL_REQ:int = 47;
		
		/**
		 * Cannot get demo; you already have a floating license
		 */
	    public static const RESPONSE_ALREADY_HAVE_FLOAT:int = 48;
		
		/**
		 * Cannot get demo; you already have a checked-out license
		 */
	    public static const RESPONSE_ALREADY_HAVE_LOCKED:int = 49;
		
		/**
		 * Error parsing registration data
		 */
	    public static const RESPONSE_MSGDATA_PARSE:int = 50;
		
		/**
		 * Invalid variable name
		 */
	    public static const RESPONSE_VAR_INVALID:int = 51;
		
		/**
		 * Cannot use reserved variable name
		 */
	    public static const RESPONSE_VAR_RESERVED:int = 52;
		
		/**
		 * Variable is readonly
		 */
	    public static const RESPONSE_VAR_READONLY:int = 53;
		
		/**
		 * This request has already been confirmed.
		 */
	    public static const RESPONSE_INVALID_CONFIRM:int = 54;
		
		/**
		 * You have either already approved/denied, or don't have a valid user id.
		 */
	    public static const RESPONSE_ALREADY_APPROVED:int = 55;
		
		/**
		 * License has expired and must be renewed
		 */
	    public static const RESPONSE_DISABLED_RENEW:int = 56;
		
		/**
		 * You are no longer the owner of this license
		 */
	    public static const RESPONSE_NOT_OWNER:int = 57;
		
		/**
		 * The machine's time clock has been set back
		 */
	    public static const RESPONSE_BAD_CLOCK:int = 58;
		
		/**
		 * Demo License has expired and must be renewed
		 */
	    public static const RESPONSE_DISABLED_RENEW_DEMO:int = 59;
		
		/**
		 * No products found for company
		 */
	    public static const RESPONSE_NO_PRODUCTS:int = 60;
		
		/**
		 * No checkouts allowed on licenses for this company
		 */
	    public static const RESPONSE_NO_CHECKOUTS:int = 61;
		
		/**
		 * Not allowed to purge this user
		 */
	    public static const RESPONSE_INVALID_PURGE:int = 62;
		
		/**
		 * File was empty when it reached the server
		 */
	    public static const RESPONSE_EMPTY_FILE:int = 63;
		
		/**
		 * File does not exist or is not readable
		 */
	    public static const RESPONSE_NO_FILE:int = 64;
		
		/**
		 * File is larger than the maximum allowed size
		 */
	    public static const RESPONSE_FILE_TOO_BIG:int = 65;
		
		/**
		 * For a new report, must pass a list of variables
		 */
	    public static const RESPONSE_NO_VARLIST:int = 66;
		
		/**
		 * Passed variable list does not match what's on the report
		 */
	    public static const RESPONSE_VARS_MISMATCH:int = 67;
		
		/**
		 * Cannot use a checked-out license in a Virtual PC or VMWare
		 */
	    public static const RESPONSE_VMWARE:int = 68;
		
		/**
		 * License was requested for a different machine
		 */
	    public static const RESPONSE_MACH_MISMATCH:int = 69;
		
		/**
		 * Session has timed out
		 */
	    public static const RESPONSE_SESS_TIMEOUT:int = 70;
		
		/**
		 * No company specified
		 */
	    public static const RESPONSE_NO_COMPANY:int = 71;
		
		/**
		 * No more checkouts allowed on licenses for this company; must use a floating license
		 */
	    public static const RESPONSE_NO_MORE_CHECKOUTS:int = 72;
		
		/**
		 * You are not authorized to get licenses for this product from this company
		 */
	    public static const RESPONSE_RESTRICTED:int = 73;
		
		/**
		 * There are no free licenses currently, but your request has been added to the queue and you will receive an email when a license becomes available
		 */
	    public static const RESPONSE_IN_QUEUE:int = 74;
		
		/**
		 * No free licenses available, but you may place a request in queue
		 */
	    public static const RESPONSE_QUEUE_AVAIL:int = 75;
		
		/**
		 * Your request has been added to the queue; you will receive an email when a license becomes available
		 */
	    public static const RESPONSE_CONFIRM_IN_QUEUE:int = 76;
		
		/**
		 * Your machine has been blacklisted.  Please contact Sales.
		 */
	    public static const RESPONSE_BANNED_MACHINE:int = 77;
		
		/**
		 * Your user account has been blacklisted.  Please contact Sales.
		 */
	    public static const RESPONSE_BANNED_USER:int = 78;
		
		/**
		 * The variable is log-only.
		 */
	    public static const RESPONSE_LOGONLY_VAR:int = 79;
		
		/**
		 * Cannot set variables because queue is locked
		 */
	    public static const RESPONSE_CANT_LOCK:int = 80;
		
		/**
		 * Variable log has gotten too large; must renew license before you can continue.
		 */
	    public static const RESPONSE_TOO_MANY_VARS:int = 81;
		
		/**
		 * Cannot write to output file.
		 */
	    public static const RESPONSE_CANT_WRITE_FILE:int = 82;
		
		/**
		 * Variable log sync has completed
		 */
	    public static const RESPONSE_BATCH_DONE:int = 83;
		
		/**
		 * Password-reset email has been sent to you - check your e-mail.
		 */
	    public static const RESPONSE_RESET_SENT:int = 84;
		
		/**
		 * No licenses are available for the requested time period.
		 */
	    public static const RESPONSE_NO_LIC_PERIOD:int = 85;
		
		/**
		 * Licensee has exceeded the number of available demos.
		 */
	    public static const RESPONSE_EXCEEDED_MAX_DEMOS:int = 86;
		
		/**
		 * You are not allowed to get a demo for this product
		 */
	    public static const RESPONSE_NO_NEW_DEMO:int = 87;
		
		/**
		 * The Link Manager URL has not been defined
		 */
	    public static const RESPONSE_MISSING_LINKMGR:int = 88;
		
		/**
		 * The requested product is not in the customer pool
		 */
	    public static const RESPONSE_PROD_NOT_IN_POOL:int = 89;
		
		/**
		 * The requested pool product has not expired
		 */
	    public static const RESPONSE_PROD_STILL_VALID:int = 90;
		
		/**
		 * The product is no longer valid for this company's pools
		 */
	    public static const RESPONSE_PROD_NOT_VALID:int = 91;
		
		/**
		 * The product in this pool has no valid-until date set
		 */
	    public static const RESPONSE_PROD_NO_VALID_UNTIL:int = 92;
		
		/**
		 * The license is a bundle
		 */
	    public static const RESPONSE_LICENSE_IS_BUNDLE:int = 93;
	    
	    
	    // connect test constants
	    public static const CONNECT_OK:int = 500;
	    public static const CONNECT_FAILED:int = 501;
	    public static const CONNECT_NO_PROXY:int = 502;
	    public static const CONNECT_BAD_PROXY_DNS:int = 503;
	    public static const CONNECT_BAD_HOST_DNS:int = 504;
	    public static const CONNECT_CONN_EXCEPT:int = 505;
	    public static const CONNECT_SVR_CLOSED:int = 506;
	    public static const CONNECT_NEED_LOGIN:int = 507;
	    public static const CONNECT_EXCEPT:int = 508;
	    public static const CONNECT_READ:int = 509;
	    public static const CONNECT_WRITE:int = 510;
	    public static const CONNECT_BAD_CHECKFILE:int = 511;
		
	    // data values
	    public static const LOCK_DEMO:String     = "D";
	    public static const LOCK_FLOATING:String = "F";
	    public static const LOCK_FIXED:String    = "L";
	    
	    public static const DEMO_INUSE:String       = "U";
	    public static const DEMO_RENEW:String       = "R";
	    public static const DEMO_APPROVED:String    = "A";
	    public static const DEMO_DISAPPROVED:String = "D";
	    
	    public static const CONFIRM_NEW_USER:String   = "N";
	    public static const CONFIRM_DEMO_RENEW:String = "D";
	    public static const CONFIRM_PASSWORD:String   = "P";
	    public static const CONFIRM_NEW_POOL:String   = "O";
	    public static const CONFIRM_NEW_DEMO:String   = "E";
	    public static const CONFIRM_EXT_PROD:String   = "X";
	    
	    public static const CONFIRM_APPROVE:String    = "a";
	    public static const CONFIRM_DENY:String       = "d";
	    
	    public static const CONFIRM_MAIL_BOTH:int		= 0;
	    public static const CONFIRM_MAIL_LINKONLY:int	= 1;
	    public static const CONFIRM_MAIL_CODEONLY:int	= 2;
	    public static const CONFIRM_MAIL_AUTO:int		= 3763;

	    public static const EXEC_SPAWN:String         = "S";
	    public static const EXEC_WAIT:String          = "W";
	
	    public static const   CUSTOM_INT:String            = 'i';
	    public static const   CUSTOM_LONG:String           = 'l';
	    public static const   CUSTOM_STRING:String         = 's';
	    public static const   CUSTOM_BOOL:String           = 'b';
	    public static const   CUSTOM_CHAR:String           = 'c';
	    public static const   CUSTOM_DOUBLE:String         = 'd';
	    public static const   CUSTOM_MAP:String            = 'm';
	    public static const   CUSTOM_BINARY:String         = 'y';
	    public static const   CUSTOM_ARRAY:String          = 'a';
	    
	    public static const SUPPORT_SALES:String        = "sales";
	    public static const SUPPORT_TECH:String         = "technical";
	    public static const SUPPORT_ENHANCE:String      = "enhancements";

	    /**
		 * Convert a response code into a human-readable string
		 * @param response the response code
		 * @return a readable representation of the response code
		 */
		public static function responseToString(response:int):String
		{
	        switch (response) {
	            case RESPONSE_OK:                    return "Ok";
	            case RESPONSE_MISSINGINPUT:          return "Missing Input";
	            case RESPONSE_CLIENT_OUT_OF_DATE:    return "Client is out of date";
	            case RESPONSE_CONFIRMATION_REQUIRED: return "User confirmation is required - Check your e-mail";
	            case RESPONSE_INTERNAL_ERROR:        return "An internal error has occurred on the LM server";
	            case RESPONSE_NO_FREE_LICENSES:      return "No free licenses available";
	            case RESPONSE_INVALID_LICENSE:       return "Invalid or missing License";
	            case RESPONSE_NEED_NEW_VERSION:      return "Need a new version of the product";
	            case RESPONSE_NO_KEY:                return "No key found for product";
	            case RESPONSE_NO_DECRYPT:            return "Unable to decrypt data";
	            case RESPONSE_BAD_PASSWORD:          return "User password is incorrect";
	            case RESPONSE_NEED_NEW_USER:         return "New user, need additional info";
	            case RESPONSE_INVALID_COMPANY:       return "Unknown company specified";
	//            case RESPONSE_INVALID_PRODUCT_LICENSEE: return "Unknown licensee or product specified";
	            case RESPONSE_INVALID_PRODUCT:       return "Unknown product specified";
	            case RESPONSE_INVALID_DAYS:          return "Invalid number of days specified";
	            case RESPONSE_UNKNOWN_USER:          return "User is unknown";
	            case RESPONSE_USER_ALREADY_EXISTS:   return "User already exists";
	            case RESPONSE_BAD_RELEASE:           return "Not allowed to release license";
	            case RESPONSE_RELEASED:              return "License has been released";
	            case RESPONSE_EXPIRED:               return "License has expired and must be renewed";
	            case RESPONSE_NO_RENEW:              return "License cannot be renewed";
	            case RESPONSE_INVALID_MACHINE:       return "Unknown machine specified";
	            case RESPONSE_EMAIL_ERROR:           return "Error occurred trying to send email";
	            case RESPONSE_SALESCONFIRM_REQUIRED: return "Sales confirmation is required - Check your e-mail";
	            case RESPONSE_VERINFO:               return "New version information included in message";
	            case RESPONSE_EXPIRED_DEMO:          return "Demo License has expired and must be renewed";
	            case RESPONSE_NO_CONNECT:            return "Could not connect to server";
	            case RESPONSE_NO_MACIDS:             return "No MAC address or Network card found";
	            case RESPONSE_INVALID_APP:           return "Application name not found";
	            case RESPONSE_APPINFO:               return "Application info included in message";
	            case RESPONSE_INVALID_LOCKTYPE:      return "Invalid lock type";
	            case RESPONSE_NOEXEC:                return "Could not execute application";
	            case RESPONSE_INVALID_FILE:          return "Invalid file name";
	            case RESPONSE_BAD_ARGUMENTS:         return "Invalid arguments to clientexec";
	            case RESPONSE_NO_OUTFILE:            return "Output file not found";
	            case RESPONSE_BAD_PULL:              return "Cannot return data when 'wait' is false";
	            case RESPONSE_CONFIRM_EXPIRED:       return "User confirmation has timed out";
	            case RESPONSE_PWD_MATCH:             return "New passwords do not match";
	            case RESPONSE_INVALID_SUPPORT_TYPE:  return "Invalid support request type";
	            case RESPONSE_EXCEEDED_MAX_EXEC:     return "Exceeded maximum execution limit for this license";
	            case RESPONSE_BAD_REQUEST:           return "Invalid request type from client to server";
	            case RESPONSE_EXCEEDED_WARN_EXEC:    return "Reached the execution warning limit for this license";
	            case RESPONSE_INTERNAL_CLIENT_ERROR: return "An internal error has occurred on the LM client";
	            case RESPONSE_NO_LICENSES_FOR_CO:    return "The company code used has not purchased any licenses for this product";
	            case RESPONSE_HASMESSAGES:           return "There are unread messages";
	            case RESPONSE_NOMESSAGES:            return "There are no unread messages";
	//            case RESPONSE_CANT_SERIALIZE:        return "Cannot serialize this request type";
	            case RESPONSE_BAD_MANUAL_REQ:        return "Cannot validate manual license request";
	            case RESPONSE_ALREADY_HAVE_FLOAT:    return "Cannot get demo; you already have a floating license";
	            case RESPONSE_ALREADY_HAVE_LOCKED:   return "Cannot get demo; you already have a checked-out license";
	            case RESPONSE_MSGDATA_PARSE:         return "Error parsing registration data";
	            case RESPONSE_VAR_INVALID:           return "Invalid variable name";
	            case RESPONSE_VAR_RESERVED:          return "Cannot use reserved variable name";
	            case RESPONSE_VAR_READONLY:          return "Variable is readonly";
	//            case RESPONSE_USER_NOT_CONFIRM:      return "User exists but has not been confirmed";
	            case RESPONSE_INVALID_CONFIRM:       return "This request has already been confirmed.";
	            case RESPONSE_ALREADY_APPROVED:      return "You have either already approved/denied, or don't have a valid user id.";
	            case RESPONSE_DISABLED_RENEW:        return "License has expired and must be renewed";
	            case RESPONSE_NOT_OWNER:             return "You are no longer the owner of this license";
	            case RESPONSE_BAD_CLOCK:             return "The machine's time clock has been set back";
	            case RESPONSE_DISABLED_RENEW_DEMO:   return "Demo License has expired and must be renewed";
	            case RESPONSE_NO_PRODUCTS:           return "No products found for company";
	            case RESPONSE_NO_CHECKOUTS:          return "No checkouts allowed on licenses for this company";
	            case RESPONSE_INVALID_PURGE:         return "Not allowed to purge this user";
	            case RESPONSE_EMPTY_FILE:            return "File was empty when it reached the server";
	            case RESPONSE_NO_FILE:               return "File does not exist or is not readable";
	            case RESPONSE_FILE_TOO_BIG:          return "File is larger than the maximum allowed size";
	            case RESPONSE_NO_VARLIST:            return "For a new report, must pass a list of variables";
	            case RESPONSE_VARS_MISMATCH:         return "Passed variable list does not match what's on the report";
	            case RESPONSE_VMWARE:                return "Cannot use a checked-out license in a Virtual PC or VMWare";
	            case RESPONSE_MACH_MISMATCH:         return "License was requested for a different machine";
	            case RESPONSE_SESS_TIMEOUT:          return "Session has timed out";
	            case RESPONSE_NO_COMPANY:            return "No company specified";
	            case RESPONSE_NO_MORE_CHECKOUTS:     return "No more checkouts allowed on licenses for this company; must use a floating license";
	            case RESPONSE_RESTRICTED:            return "You are not authorized to get licenses for this product from this company";
	            case RESPONSE_IN_QUEUE:              return "There are no free licenses currently, but your request has been added to the queue and you will receive an email when a license becomes available";
	            case RESPONSE_QUEUE_AVAIL:           return "No free licenses available, but you may place a request in queue";
	            case RESPONSE_CONFIRM_IN_QUEUE:      return "Your request has been added to the queue; you will receive an email when a license becomes available";
	            case RESPONSE_BANNED_MACHINE:        return "Your machine has been blacklisted.  Please contact Sales.";
	            case RESPONSE_BANNED_USER:           return "Your user account has been blacklisted.  Please contact Sales.";
	            case RESPONSE_LOGONLY_VAR:           return "The variable is log-only.";
	            case RESPONSE_CANT_LOCK:             return "Cannot set variables because queue is locked";
	            case RESPONSE_TOO_MANY_VARS:         return "Variable log has gotten too large; must renew license before you can continue.";
	            case RESPONSE_CANT_WRITE_FILE:       return "Cannot write to output file.";
	            case RESPONSE_BATCH_DONE:            return "Variable log sync has completed";
	            case RESPONSE_RESET_SENT:            return "Password-reset email has been sent to you - check your e-mail.";
	            case RESPONSE_NO_LIC_PERIOD:         return "No licenses are available for the requested time period.";
	            case RESPONSE_EXCEEDED_MAX_DEMOS:	 return "Licensee has exceeded the number of available demos.";
	            case RESPONSE_NO_NEW_DEMO:           return "You are not allowed to get a demo for this product";
	            case RESPONSE_MISSING_LINKMGR:       return "The Link Manager URL has not been defined";
	            case RESPONSE_PROD_NOT_IN_POOL:      return "The requested product is not in the customer pool";
	            case RESPONSE_PROD_STILL_VALID:      return "The requested pool product has not expired";
	            case RESPONSE_PROD_NOT_VALID:        return "The product is no longer valid for this company's pools";
	            case RESPONSE_PROD_NO_VALID_UNTIL:   return "The product in this pool has no valid-until date set";
	            case RESPONSE_LICENSE_IS_BUNDLE:     return "The license is a bundle";
	            
	            case CONNECT_OK:                     return "Connect test succeeded";
	            case CONNECT_FAILED:                 return "Unable to talk to server";
	            case CONNECT_NO_PROXY:               return "No proxy has been defined";
	            case CONNECT_BAD_PROXY_DNS:          return "Proxy server's address was not found";
	            case CONNECT_BAD_HOST_DNS:           return "Host server's address was not found";
	            case CONNECT_CONN_EXCEPT:            return "Error on connect";
	            case CONNECT_SVR_CLOSED:             return "Unexpected close of connection";
	            case CONNECT_NEED_LOGIN:             return "Server requested a user login";
	            case CONNECT_EXCEPT:                 return "General error has occurred on request";
	            case CONNECT_READ:                   return "Cannot read from connection";
	            case CONNECT_WRITE:                  return "Cannot write to connection";
	            case CONNECT_BAD_CHECKFILE:          return "Checkfile invalid on server connection test";
	            
	            default:                             return "Unknown response: " + response;
	        }
		}
	
		/**
		 * This method lets you know if the response code is an informational message
		 * @param response the response code
		 * @return true if informational message, false otherwise
		 */
	    public static function isInfoMessage(response:int):Boolean {
	        if (response==RESPONSE_OK ||
	            response==RESPONSE_CONFIRMATION_REQUIRED ||
	            response==RESPONSE_SALESCONFIRM_REQUIRED ||
	            response==RESPONSE_RELEASED || 
	            response==RESPONSE_VERINFO ||
	            response==RESPONSE_APPINFO ||
	            response==RESPONSE_HASMESSAGES ||
	            response==RESPONSE_NOMESSAGES ||
	            response==RESPONSE_IN_QUEUE || 
	            response==RESPONSE_CONFIRM_IN_QUEUE || 
	            response==RESPONSE_LOGONLY_VAR || 
	            response==RESPONSE_BATCH_DONE || 
	            response==RESPONSE_RESET_SENT || 
	            response==RESPONSE_LICENSE_IS_BUNDLE || 
	            response==CONNECT_OK) {
	            return true;
	        }
	        else
	            return false;
	    }
	
		/**
		 * This method checks to see if there was any problem getting a license
		 * @param response the response code
		 * @return true if problems occurred, false otherwise
		 */
	    public static function isNoLicenseMessage(response:int):Boolean {
	        if (response==RESPONSE_INVALID_LICENSE ||
	            response==RESPONSE_EXPIRED ||
	            response==RESPONSE_EXPIRED_DEMO ||
	            response==RESPONSE_EXCEEDED_MAX_EXEC ||
	            response==RESPONSE_DISABLED_RENEW ||
	            response==RESPONSE_DISABLED_RENEW_DEMO ||
	            response==RESPONSE_BAD_CLOCK ||
	            response==RESPONSE_IN_QUEUE ||
	            response==RESPONSE_QUEUE_AVAIL ||
	            response==RESPONSE_CONFIRM_IN_QUEUE ||
	            response==RESPONSE_NO_LIC_PERIOD ||
	            response==RESPONSE_EXCEEDED_MAX_DEMOS ||
	            response==RESPONSE_NO_NEW_DEMO ||
	            response==RESPONSE_PROD_NOT_IN_POOL ||
	            response==RESPONSE_PROD_NOT_VALID) {
	            return true;
	        }
	        else
	            return false;
	    }
	
		/**
		 * Convert a request code into a human-readable string
		 * @param request the request code
		 * @return a readable representation of the request type
		 */
	    public static function requestToString(request:int):String
	    {
	    	switch(request)
	    	{
				case REQUEST_GETLICENSE:			return "Get License";
			    case REQUEST_RENEWLICENSE:			return "Renew License";
			    case REQUEST_RELEASELICENSE:		return "Release License";
			    case REQUEST_NEWUSER:				return "Create New User";
			    case REQUEST_VERCHECK:				return "Check Version";
				case REQUEST_CHANGE_PASSWORD:		return "Change Password";
			    case REQUEST_CHKUSER:				return "Check User";
			    case REQUEST_VERIFYAPP:				return "Verify App";
			    case REQUEST_SUPPORT:				return "Support Request";
			    case REQUEST_KEY:					return "Key Request";
			    case REQUEST_MESSAGES:				return "Messages Request";
			    case REQUEST_SETEXECCTR:			return "Set Exec Counter";
			    case REQUEST_SETUSERVAR:			return "Set User Variable";
			    case REQUEST_GETUSERVAR:			return "Get User Variable";
			    case REQUEST_GETMANUAL:				return "Get Manual License";
			    case REQUEST_GETUSERINFO:			return "Get User Info";
			    case REQUEST_GETPRODUCTS:			return "Get Products";
			    case REQUEST_PURGEUSER:				return "Purge User";
			    case REQUEST_SETUSERFILE:			return "Set User File";
			    case REQUEST_LOGVARS:				return "Log Variables";
			    case REQUEST_GETAPPLOGIN:			return "Get App Login";
			    case REQUEST_SESSIONDATA:			return "Session Data";
			    case REQUEST_GETLICENSE_APPID:		return "Get License AppId";
			    case REQUEST_GETLICENSE_DEFAULT:	return "Get License Default";
			    case REQUEST_CONNTEST:				return "Test Connection";
				case REQUEST_CONFIRM:				return "Confirm User";
				case REQUEST_SURVEY:				return "Send Survey";
			}
			return null;
	    }
	}
}