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
	[Route("api/OPSPBase")]
	[ApiController]
	public class OPSPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public OPSPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("OPKeyInsertBase")]
		public async Task<ActionResult<object>> OPKeyInsertBase(string AdminKey, double? AmountUnit, DateTime? ExpireDate, double? LimitMoney)
		{
			try
			{
				List<OPKeyInsert> rsOPKeyInsert = await new OPKeyInsert(_appSetting).OPKeyInsertDAO(AdminKey, AmountUnit, ExpireDate, LimitMoney);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"OPKeyInsert", rsOPKeyInsert},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "OP_KeyInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("OPKeySearchBase")]
		public async Task<ActionResult<object>> OPKeySearchBase(string AdminKey, DateTime? DateSearch, double? MoneySearch, double? AmountUnit, bool? CheckAssiged, string Key, int? PageSize, int? PageIndex)
		{
			try
			{
				List<OPKeySearch> rsOPKeySearch = await new OPKeySearch(_appSetting).OPKeySearchDAO(AdminKey, DateSearch, MoneySearch, AmountUnit, CheckAssiged, Key, PageSize, PageIndex);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"OPKeySearch", rsOPKeySearch},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "OP_KeySearch";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("OPKeyUpdateBase")]
		public async Task<ActionResult<object>> OPKeyUpdateBase(OPKeyUpdateIN _oPKeyUpdateIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new OPKeyUpdate(_appSetting).OPKeyUpdateDAO(_oPKeyUpdateIN) };
			}
			catch (Exception ex)
			{
				string spName = "OP_KeyUpdate";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("OPUserGetByUserNameBase")]
		public async Task<ActionResult<object>> OPUserGetByUserNameBase(string AdminKey, string UserName)
		{
			try
			{
				List<OPUserGetByUserName> rsOPUserGetByUserName = await new OPUserGetByUserName(_appSetting).OPUserGetByUserNameDAO(AdminKey, UserName);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"OPUserGetByUserName", rsOPUserGetByUserName},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserGetByUserName";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("OPUserInsertBase")]
		public async Task<ActionResult<object>> OPUserInsertBase(OPUserInsertIN _oPUserInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new OPUserInsert(_appSetting).OPUserInsertDAO(_oPUserInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("OPUserKeyDeleteBase")]
		public async Task<ActionResult<object>> OPUserKeyDeleteBase(OPUserKeyDeleteIN _oPUserKeyDeleteIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new OPUserKeyDelete(_appSetting).OPUserKeyDeleteDAO(_oPUserKeyDeleteIN) };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserKeyDelete";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("OPUserKeyGetByKeyIdBase")]
		public async Task<ActionResult<object>> OPUserKeyGetByKeyIdBase(string AdminKey, int? KeyId)
		{
			try
			{
				List<OPUserKeyGetByKeyId> rsOPUserKeyGetByKeyId = await new OPUserKeyGetByKeyId(_appSetting).OPUserKeyGetByKeyIdDAO(AdminKey, KeyId);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"OPUserKeyGetByKeyId", rsOPUserKeyGetByKeyId},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserKeyGetByKeyId";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("OPUserKeyGetByUserIdBase")]
		public async Task<ActionResult<object>> OPUserKeyGetByUserIdBase(string AdminKey, int? UserId)
		{
			try
			{
				List<OPUserKeyGetByUserId> rsOPUserKeyGetByUserId = await new OPUserKeyGetByUserId(_appSetting).OPUserKeyGetByUserIdDAO(AdminKey, UserId);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"OPUserKeyGetByUserId", rsOPUserKeyGetByUserId},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserKeyGetByUserId";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("OPUserKeyInsertBase")]
		public async Task<ActionResult<object>> OPUserKeyInsertBase(OPUserKeyInsertIN _oPUserKeyInsertIN)
		{
			try
			{
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = await new OPUserKeyInsert(_appSetting).OPUserKeyInsertDAO(_oPUserKeyInsertIN) };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserKeyInsert";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[AllowAnonymous]
		[Route("OPUserSearchBase")]
		public async Task<ActionResult<object>> OPUserSearchBase(string AdminKey, string Search, int? PageSize, int? PageIndex)
		{
			try
			{
				List<OPUserSearch> rsOPUserSearch = await new OPUserSearch(_appSetting).OPUserSearchDAO(AdminKey, Search, PageSize, PageIndex);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"OPUserSearch", rsOPUserSearch},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				string spName = "OP_UserSearch";
				new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
