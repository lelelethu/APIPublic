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
	[Route("api/TXSPBase")]
	[ApiController]
	public class TXSPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public TXSPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("ResultGetAllOnPageBase")]
		public async Task<ActionResult<object>> ResultGetAllOnPageBase(int? PageSize, int? PageIndex, string LinkGame, string TenGame, DateTime? StartDate, DateTime? EndDate)
		{
			try
			{
				List<ResultGetAllOnPage> rsResultGetAllOnPage = await new ResultGetAllOnPage(_appSetting).ResultGetAllOnPageDAO(PageSize, PageIndex, LinkGame, TenGame, StartDate, EndDate);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"ResultGetAllOnPage", rsResultGetAllOnPage},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "ResultGetAllOnPage";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("ResultInsertBase")]
		public async Task<ActionResult<object>> ResultInsertBase(ResultInsertIN _resultInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new ResultInsert(_appSetting).ResultInsertDAO(_resultInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "ResultInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("UserGetByKeyBase")]
		public async Task<ActionResult<object>> UserGetByKeyBase(string Key)
		{
			try
			{
				List<UserGetByKey> rsUserGetByKey = await new UserGetByKey(_appSetting).UserGetByKeyDAO(Key);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"UserGetByKey", rsUserGetByKey},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "UserGetByKey";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
