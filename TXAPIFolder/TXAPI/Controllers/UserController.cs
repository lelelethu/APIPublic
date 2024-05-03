using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using System;
using TXAPI.Common;
using TXAPI.Models.Results;
using Microsoft.AspNetCore.Authorization;
using TXAPI.ModelBase;
using Chilkat;
using YoutubeExplode.Channels;
using Microsoft.AspNetCore.Http;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.Extensions.Configuration;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using Newtonsoft.Json.Linq;
using TXAPI.Models;

namespace TXAPI.Controllers
{
	[Route("api/User")]
	[ApiController]
	public class UserController : BaseApiController
	{
		private readonly IAppSetting _appSetting;
		private readonly IHttpContextAccessor _httpContextAccessor;
		private readonly IHttpClientFactory _httpClientFactory;
		private readonly IConfiguration _config;

		public UserController(IAppSetting appSetting, IHttpContextAccessor httpContextAccessor, IHttpClientFactory httpClientFactory, IConfiguration config)
		{
			_appSetting = appSetting;
			_httpContextAccessor = httpContextAccessor;
			_httpClientFactory = httpClientFactory;
			_config = config;
		}

		//[HttpPost]
		//[AllowAnonymous]
		//[Route("UserInsertBase")]
		//public async Task<ActionResult<object>> UserInsertBase(UserInsertModel _userInsertModel)
		//{
		//	try
		//	{
		//		if (_userInsertModel.AdminKey != _config["AdminKey"])
		//		{
		//			return new ResultApi { Success = ResultCode.ERROR, Message = "Admin key incorrect!" };
		//		}
		//		UserInsertIN _userInsertIN = new UserInsertIN
		//		{
		//			UserName = _userInsertModel.UserName,
		//			FirstName = _userInsertModel.FirstName,
		//			LastName = _userInsertModel.LastName,
		//			Email = _userInsertModel.Email,
		//		};
		//		new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

		//		return new ResultApi { Success = ResultCode.OK, Result = await new UserInsert(_appSetting).UserInsertDAO(_userInsertIN) };
		//	}
		//	catch (Exception ex)
		//	{
		//		string spName = "UserInsert";
		//		new LogHelper(_appSetting).ProcessInsertLogErrorAsync(HttpContext, ex, spName);

		//		return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
		//	}
		//}
	}
}
