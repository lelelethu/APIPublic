using TXAPI.Common;
using TXAPI.Controllers;
using TXAPI.Models;
using TXAPI.ModelBase;
using TXAPI.Models.Results;
using System;
using Dapper;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Net.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Newtonsoft.Json;

namespace TXAPI.ControllerBase
{
	[Route("api/WSSPBase")]
	[ApiController]
	public class WSSPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public WSSPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("WSResultWSSGetAllOnPageBase")]
		public async Task<ActionResult<object>> WSResultWSSGetAllOnPageBase(string DataKey, string WebName, string GameName, int? PageSize, int? PageIndex)
		{
			try
			{
				List<WSResultWSSGetAllOnPage> rsWSResultWSSGetAllOnPage = await new WSResultWSSGetAllOnPage(_appSetting).WSResultWSSGetAllOnPageDAO(DataKey, WebName, GameName, PageSize, PageIndex);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"WSResultWSSGetAllOnPage", rsWSResultWSSGetAllOnPage},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "WS_ResultWSSGetAllOnPage";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("WSResultWSSGetLastestResultBase")]
		public async Task<ActionResult<object>> WSResultWSSGetLastestResultBase(string DataKey, string WebName, string GameName)
		{
			try
			{
				List<WSResultWSSGetLastestResult> rsWSResultWSSGetLastestResult = await new WSResultWSSGetLastestResult(_appSetting).WSResultWSSGetLastestResultDAO(DataKey, WebName, GameName);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"WSResultWSSGetLastestResult", rsWSResultWSSGetLastestResult},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "WS_ResultWSSGetLastestResult";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("WSResultWSSInsertBase")]
		public async Task<ActionResult<object>> WSResultWSSInsertBase(WSResultWSSInsertIN _wSResultWSSInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new WSResultWSSInsert(_appSetting).WSResultWSSInsertDAO(_wSResultWSSInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "WS_ResultWSSInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("WSStatusWSSUpdateBase")]
		public async Task<ActionResult<object>> WSStatusWSSUpdateBase(WSStatusWSSUpdateIN _wSStatusWSSUpdateIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new WSStatusWSSUpdate(_appSetting).WSStatusWSSUpdateDAO(_wSStatusWSSUpdateIN) };
			}
			catch (Exception ex)
			{
				string spName = "WS_StatusWSSUpdate";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("WSTokenGetSingleTokenBase")]
		public async Task<ActionResult<object>> WSTokenGetSingleTokenBase(string DataKey, string LinkGame)
		{
			try
			{
				List<WSTokenGetSingleToken> rsWSTokenGetSingleToken = await new WSTokenGetSingleToken(_appSetting).WSTokenGetSingleTokenDAO(DataKey, LinkGame);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"WSTokenGetSingleToken", rsWSTokenGetSingleToken},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "WS_TokenGetSingleToken";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("WSTokenUpdateStatusBase")]
		public async Task<ActionResult<object>> WSTokenUpdateStatusBase(WSTokenUpdateStatusIN _wSTokenUpdateStatusIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new WSTokenUpdateStatus(_appSetting).WSTokenUpdateStatusDAO(_wSTokenUpdateStatusIN) };
			}
			catch (Exception ex)
			{
				string spName = "WS_TokenUpdateStatus";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
