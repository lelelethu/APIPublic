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
	[Route("api/TESPBase")]
	[ApiController]
	public class TESPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public TESPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("TEResultTESInsertBase")]
		public async Task<ActionResult<object>> TEResultTESInsertBase(TEResultTESInsertIN _tEResultTESInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new TEResultTESInsert(_appSetting).TEResultTESInsertDAO(_tEResultTESInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "TE_ResultTESInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("TEStatusTESUpdateBase")]
		public async Task<ActionResult<object>> TEStatusTESUpdateBase(TEStatusTESUpdateIN _tEStatusTESUpdateIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new TEStatusTESUpdate(_appSetting).TEStatusTESUpdateDAO(_tEStatusTESUpdateIN) };
			}
			catch (Exception ex)
			{
				string spName = "TE_StatusTESUpdate";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
