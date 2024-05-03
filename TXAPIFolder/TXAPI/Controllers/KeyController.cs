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
using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.AspNetCore.Hosting;
using System.IO;

namespace TXAPI.Controllers
{
	[Route("api/Key")]
	[ApiController]
	public class KeyController : BaseApiController
	{
		private readonly IAppSetting _appSetting;
		private readonly IHttpContextAccessor _httpContextAccessor;
		private readonly IHttpClientFactory _httpClientFactory;
		private readonly IConfiguration _config;
		private readonly IWebHostEnvironment _webHostEnvironment;

		public KeyController(IAppSetting appSetting, IHttpContextAccessor httpContextAccessor, IHttpClientFactory httpClientFactory, IConfiguration config, IWebHostEnvironment webHostEnvironment)
		{
			_appSetting = appSetting;
			_httpContextAccessor = httpContextAccessor;
			_httpClientFactory = httpClientFactory;
			_config = config;
			_webHostEnvironment = webHostEnvironment;
		}

		[HttpPost]
		[AllowAnonymous]
		[Route("GetToken")]
		public async Task<ResultApi> GetToken(GetTokenInput _getTokenInput)
		{
			//Lưu log
			GetTokenInputLog getTokenInputLog = new GetTokenInputLog
			{
				DatetimeAction = DateTime.Now,
				GetTokenInput = _getTokenInput
			};
			FuncFile.WriteLog<GetTokenInputLog>(getTokenInputLog, _webHostEnvironment, "GetToken.txt", _getTokenInput.Key, null, null, "Login/");

			List<APUserGetByKey> users = await new APUserGetByKey(_appSetting).APUserGetByKeyDAO(_getTokenInput.Key);

			if (users != null && users.Count > 0)
			{
				var user = users[0];
				if (user.Status == null || !user.Status.Value)
				{
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("A5");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}
				else if (user.ExpireDate < DateTime.Now)
				{
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("A6");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}

				APDeviceInsertIN _deviceInsertIN = new APDeviceInsertIN
				{
					UserId = users[0].UserId,
					KeyId = users[0].KeyId,
					InfoDevice = _getTokenInput.InfoDevice
				};
				//Insert Device info
				try
				{
					if (!string.IsNullOrEmpty(_getTokenInput.InfoDevice))
					{
						DeviceInfo deviceInfo = JsonConvert.DeserializeObject<DeviceInfo>(_getTokenInput.InfoDevice);
						_deviceInsertIN.AndroidId = deviceInfo.AndroidId;
						_deviceInsertIN.AppId = deviceInfo.AppId;
						_deviceInsertIN.AppVersionName = deviceInfo.AppVersionName;
						_deviceInsertIN.IpAddress = deviceInfo.IpAddress;
						_deviceInsertIN.IsDevelopmentSetting = deviceInfo.IsDevelopmentSetting;
						_deviceInsertIN.IsDeviceRooted = deviceInfo.IsDeviceRooted;
						_deviceInsertIN.IsEmulator = deviceInfo.IsEmulator;
						_deviceInsertIN.IsTablet = deviceInfo.IsTablet;
						_deviceInsertIN.Language = deviceInfo.Language;
						_deviceInsertIN.Manufacturer = deviceInfo.Manufacturer;
						_deviceInsertIN.Model = deviceInfo.Model;
						_deviceInsertIN.NetType = deviceInfo.NetType;
						_deviceInsertIN.OsVersion = deviceInfo.OsVersion;
						_deviceInsertIN.PhoneBrand = deviceInfo.PhoneBrand;
						_deviceInsertIN.ScreenSize = deviceInfo.ScreenSize;
						_deviceInsertIN.SdkVersionCode = deviceInfo.SdkVersionCode;
						_deviceInsertIN.SdkVersionName = deviceInfo.SdkVersionName;
						_deviceInsertIN.UniqueDeviceId = deviceInfo.UniqueDeviceId;
					}
					else
					{
						APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
						{
							WebName = string.Empty,
							GameName = string.Empty,
							UserId = users[0].UserId,
							KeyId = users[0].KeyId,
							UniqueDeviceId = string.Empty,
							APIName = "GetToken",
							Request = JsonConvert.SerializeObject(_getTokenInput),
							ErrorMessage = "Device info is empty"
						};
						await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
						//Get message return to client
						List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("A1");
						return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
					}
				}
				catch (Exception ex)
				{
					APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
					{
						WebName = string.Empty,
						GameName = string.Empty,
						UserId = users[0].UserId,
						KeyId = users[0].KeyId,
						UniqueDeviceId = string.Empty,
						APIName = "GetToken",
						Request = JsonConvert.SerializeObject(_getTokenInput),
						ErrorMessage = ex.Message
					};
					await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
					//Get message return to client
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("A4");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}

				if (string.IsNullOrEmpty(_deviceInsertIN.UniqueDeviceId))
				{
					APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
					{
						WebName = string.Empty,
						GameName = string.Empty,
						UserId = users[0].UserId,
						KeyId = users[0].KeyId,
						UniqueDeviceId = string.Empty,
						APIName = "GetToken",
						Request = JsonConvert.SerializeObject(_getTokenInput),
						ErrorMessage = "UniqueDeviceId is empty"
					};
					await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
					//Get message return to client
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("A2");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}
				string token = GenerateJSONWebToken(users[0], _deviceInsertIN.UniqueDeviceId);
				await new APDeviceInsert(_appSetting).APDeviceInsertDAO(_deviceInsertIN);

				return new ResultApi { Success = ResultCode.OK, Result = token };
			}
			else
			{
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = string.Empty,
					GameName = string.Empty,
					UserId = null,
					KeyId = null,
					UniqueDeviceId = null,
					APIName = "GetToken",
					Request = JsonConvert.SerializeObject(_getTokenInput),
					ErrorMessage = "Key not found"
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("A3");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		private string GenerateJSONWebToken(APUserGetByKey userGetByKey, string UniqueDeviceId)
		{
			var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
			var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

			var claims = new[] {
					new Claim("UserName", userGetByKey.UserName != null ?userGetByKey.UserName :string.Empty),
					new Claim("Email", userGetByKey.Email != null ? userGetByKey.Email : string.Empty),
					new Claim("UserId", userGetByKey.UserId.ToString()),
					new Claim("ExpireDate", userGetByKey.ExpireDate != null?userGetByKey.ExpireDate.Value.ToString("dd-MM-yyyy"):""),
					new Claim("Key", userGetByKey.Key),
					new Claim("KeyId", userGetByKey.KeyId.ToString()),
					new Claim("LimitMoney", userGetByKey.LimitMoney!= null?userGetByKey.LimitMoney.ToString():""),
					new Claim("UniqueDeviceId", UniqueDeviceId != null ? UniqueDeviceId : string.Empty),
				};

			var token = new JwtSecurityToken(
			_config["Jwt:Issuer"],
			_config["Jwt:Issuer"],
			claims,
			expires: DateTime.Now.AddDays(20),
			signingCredentials: credentials);

			return new JwtSecurityTokenHandler().WriteToken(token);
		}

		private string GenerateRandomKey()
		{
			Guid guid = Guid.NewGuid();
			string key = guid.ToString("N");
			return key;
		}
	}

	public class GetTokenInput
	{
		public string Key { get; set; }
		public string InfoDevice { get; set; }
	}


}
