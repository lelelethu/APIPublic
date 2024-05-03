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
	[Route("api/SYSPBase")]
	[ApiController]
	public class SYSPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public SYSPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("SYLinkGameJsGetAllBase")]
		public async Task<ActionResult<object>> SYLinkGameJsGetAllBase()
		{
			try
			{
				List<SYLinkGameJsGetAll> rsSYLinkGameJsGetAll = await new SYLinkGameJsGetAll(_appSetting).SYLinkGameJsGetAllDAO();
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"SYLinkGameJsGetAll", rsSYLinkGameJsGetAll},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "SY_LinkGameJsGetAll";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("SYTokenInsertBase")]
		public async Task<ActionResult<object>> SYTokenInsertBase(SYTokenInsertIN _sYTokenInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new SYTokenInsert(_appSetting).SYTokenInsertDAO(_sYTokenInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "SY_TokenInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
