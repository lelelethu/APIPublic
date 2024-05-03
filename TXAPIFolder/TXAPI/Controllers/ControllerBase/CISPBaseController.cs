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
	[Route("api/CISPBase")]
	[ApiController]
	public class CISPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public CISPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("CIResultCIMInsertBase")]
		public async Task<ActionResult<object>> CIResultCIMInsertBase(CIResultCIMInsertIN _cIResultCIMInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new CIResultCIMInsert(_appSetting).CIResultCIMInsertDAO(_cIResultCIMInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "CI_ResultCIMInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("CIStatusCIMUpdateBase")]
		public async Task<ActionResult<object>> CIStatusCIMUpdateBase(CIStatusCIMUpdateIN _cIStatusCIMUpdateIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new CIStatusCIMUpdate(_appSetting).CIStatusCIMUpdateDAO(_cIStatusCIMUpdateIN) };
			}
			catch (Exception ex)
			{
				string spName = "CI_StatusCIMUpdate";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
