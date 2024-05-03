using Microsoft.AspNetCore.Http;
using Microsoft.IdentityModel.Logging;
using Newtonsoft.Json;
using Serilog;
using System;
using System.Security.Claims;
using TXAPI.ModelBase;

namespace TXAPI.Common
{
	public class LogHelper
	{
		private readonly IAppSetting _appSetting;

		public LogHelper(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}
		//Custome code here
		//public async void InsertSystemActionLogging(LogActions logHelper)
		//{
		//	string fullName = logHelper.claim.Claims.FirstOrDefault(c => c.Type == "FullName").Value;

		//	LOGACTIONADDIN _lOGACTIONADDIN = new LOGACTIONADDIN
		//	{
		//		USER = fullName,
		//		NOTE = logHelper.node,
		//		TABLE_NAME = logHelper.tableName,
		//		ACTION_NAME = logHelper.actionName,
		//	};
		//	await new LOGACTIONADD(_appSetting).LOGACTIONADDDAO(_lOGACTIONADDIN);
		//}

		//public async void InsertSystemErrorLogging(LogErrors logHelper)
		//{
		//	LOGERRORADDIN _lOGERRORADDIN = new LOGERRORADDIN
		//	{
		//		SP_NAME = logHelper.spName,
		//		ERR_MESSAGE = logHelper.errMessage,
		//	};
		//	await new LOGERRORADD(_appSetting).LOGERRORADDDAO(_lOGERRORADDIN);
		//}

		public BaseRequest ReadBodyFromRequest(HttpRequest httpRequest)
		{
			httpRequest.EnableBuffering();
			string str = (string)httpRequest.HttpContext.Items["body"];
			//using (StreamReader reader = new StreamReader(httpRequest.Body))
			//{
			//	str = await reader.ReadToEndAsync();
			//}

			return JsonConvert.DeserializeObject<BaseRequest>(str);
		}

		public BaseRequest ReadHeaderFromRequest(HttpRequest httpRequest)
		{
			return new BaseRequest
			{
				actionName = httpRequest.Headers["actionName"],
				tableName = httpRequest.Headers["tableName"],
				node = httpRequest.Headers["node"],
			};
		}

		public void ProcessInsertLogActionAsync(HttpContext httpContext, Exception ex)
		{
			LogHelper logHelper = new LogHelper(_appSetting);
			BaseRequest baseRequest = logHelper.ReadHeaderFromRequest(httpContext.Request);

			if (baseRequest == null) return;

			if (!string.IsNullOrEmpty(baseRequest.actionName))
			{
				var log = new LogActions
				{
					actionName = System.Uri.UnescapeDataString(baseRequest.actionName),
					tableName = System.Uri.UnescapeDataString(baseRequest.tableName),
					node = baseRequest.node,
					claim = httpContext.User
				}.ToString();
				Log.Information(log);
			}

		}

		public void ProcessInsertLogErrorAsync(HttpContext httpContext, Exception ex, string spName)
		{
			Log.Error(ex.Message);
		}

		//public async void APErrorInsertDAO(HttpContext httpContext, Exception ex, string spName)
		//{
		//	await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
		//}

		//public string GetFullNameFromRequest(IEnumerable<Claim> claims)
		//{
		//	return claims.FirstOrDefault(c => c.Type == "FullName").Value;
		//}

		//public long GetUserIdFromRequest(IEnumerable<Claim> claims)
		//{
		//	return long.Parse(claims.FirstOrDefault(c => c.Type == "Id").Value);
		//}

		//public void InsertJobSuccess(byte JobId, string JobName, DateTime RunningDate, string Scope)
		//{
		//	RCSyncLogSuccessInsertIN _rCSyncLogSuccessInsertIN = new RCSyncLogSuccessInsertIN
		//	{
		//		JobId = JobId,
		//		JobName = JobName,
		//		RunningDate = RunningDate,
		//		Scope = Scope,
		//		Client = Dns.GetHostAddresses(Dns.GetHostName()).FirstOrDefault(ha => ha.AddressFamily == AddressFamily.InterNetwork).ToString() + " - " + System.Environment.MachineName,
		//	};

		//	new RCSyncLogSuccessInsert(_appSetting).RCSyncLogSuccessInsertDAO(_rCSyncLogSuccessInsertIN);
		//}

		//public void InsertJobError(byte JobId, string JobName, string Message, DateTime RunningDate)
		//{
		//	RCSyncLogErrorJobInsertIN _rCSyncLogErrorJobInsertIN = new RCSyncLogErrorJobInsertIN
		//	{
		//		JobId = JobId,
		//		JobName = JobName,
		//		Message = Message,
		//		RunningDate = RunningDate,
		//		Client = Dns.GetHostAddresses(Dns.GetHostName()).FirstOrDefault(ha => ha.AddressFamily == AddressFamily.InterNetwork).ToString() + " - " + System.Environment.MachineName,
		//	};
		//	new RCSyncLogErrorJobInsert(_appSetting).RCSyncLogErrorJobInsertDAO(_rCSyncLogErrorJobInsertIN);
		//}
	}

	public class LogActions
	{
		public string tableName { get; set; }
		public string node { get; set; }
		public string actionName { get; set; }
		public ClaimsPrincipal claim;
	}

	public class LogErrors
	{
		public string spName { get; set; }
		public string errMessage { get; set; }
		public Exception e { get; set; }
	}

	public enum LogAction
	{
		Add = 1,
		Edit = 2,
		Delete = 3,
		Login = 4,
		LogOut = 5,
		Approved = 6,
		Request = 7,
		Export = 8,
		Publish = 9,
		ChangePassWord = 10,
		Lock = 11,
		Unlock = 12,
		Restored = 13,
		Deny = 14,
		Recover = 15,
		Send = 16,
		Wait = 17,
		Delegacy = 18,
		ProvidedNumber = 19,
		Remove = 20,
		Accept = 21,
		Forward = 22,
		Signed = 23,
		VaoSo = 24,
		EndProcess = 25,
		Support = 26,
		Keep = 27,
		Move = 28,
		Reply = 29,
		CanceKeep = 30,
		Confirm = 31,
		Finish = 32
	}
}
