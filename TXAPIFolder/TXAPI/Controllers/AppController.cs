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
using ChoETL;
using Microsoft.AspNetCore.Hosting;
using DocumentFormat.OpenXml.Wordprocessing;

namespace TXAPI.Controllers
{
	[Route("api/App")]
	[ApiController]
	public class AppController : BaseApiController
	{
		private readonly IAppSetting _appSetting;
		private readonly IHttpContextAccessor _httpContextAccessor;
		private readonly IHttpClientFactory _httpClientFactory;
		private readonly IConfiguration _config;
		private readonly IWebHostEnvironment _webHostEnvironment;

		public AppController(IAppSetting appSetting, IHttpContextAccessor httpContextAccessor, IHttpClientFactory httpClientFactory, IConfiguration config, IWebHostEnvironment webHostEnvironment)
		{
			_appSetting = appSetting;
			_httpContextAccessor = httpContextAccessor;
			_httpClientFactory = httpClientFactory;
			_config = config;
			_webHostEnvironment = webHostEnvironment;
		}

		[HttpGet]
		[Authorize]
		[Route("SelUserKeyScriptWILLBET")]
		public async Task<ActionResult<object>> SelUserKeyScriptWILLBET(string WebName, string GameName, long? GameId)
		{
			var userIdClaim = HttpContext.User.FindFirst("UserId");
			int userId = Int32.Parse(userIdClaim.Value);
			var keyIdClaim = HttpContext.User.FindFirst("KeyId");
			int keyId = Int32.Parse(keyIdClaim.Value);
			var keyClaim = HttpContext.User.FindFirst("Key");
			string key = keyClaim.Value;
			var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
			string uniqueDeviceId = uniqueDeviceIdClaim.Value;

			//Lưu log
			SelUserKeyScriptWILLBETInput selUserKeyScriptWILLBETInput = new SelUserKeyScriptWILLBETInput
			{
				WebName = WebName,
				GameName = GameName,
				GameId = GameId,
			};
			SelUserKeyScriptWILLBETLog selUserKeyScriptWILLBETLog = new SelUserKeyScriptWILLBETLog
			{
				DatetimeAction = DateTime.Now,
				Key = key,
				UserId = userId,
				UniqueDeviceId = uniqueDeviceId,
				SelUserKeyScriptWILLBETInput = selUserKeyScriptWILLBETInput
			};
			FuncFile.WriteLog<SelUserKeyScriptWILLBETLog>(selUserKeyScriptWILLBETLog, _webHostEnvironment, "SelUserKeyScriptWILLBET.txt", key, WebName, GameName);

			try
			{
				List<APDeviceCheckAvailabel> rsDeviceCheckAvailabel = await new APDeviceCheckAvailabel(_appSetting).APDeviceCheckAvailabelDAO(userId, keyId, uniqueDeviceId);
				if (rsDeviceCheckAvailabel != null && rsDeviceCheckAvailabel.Count > 0 && rsDeviceCheckAvailabel[0].Avail.Value)
				{
					List<APSelUserKeyScriptWILLBET> rsSelUserKeyScriptWILLBET = await new APSelUserKeyScriptWILLBET(_appSetting).APSelUserKeyScriptWILLBETDAO(userId, keyId, WebName, GameName,GameId);

					//Ghi log nếu trả về null
					if (rsSelUserKeyScriptWILLBET == null || rsSelUserKeyScriptWILLBET.Count == 0)
					{
						APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
						{
							WebName = WebName,
							GameName = GameName,
							UserId = userId,
							KeyId = keyId,
							UniqueDeviceId = uniqueDeviceId,
							APIName = "SelUserKeyScriptWILLBET",
							Request = JsonConvert.SerializeObject(selUserKeyScriptWILLBETInput),
							ErrorMessage = "Data return null!"
						};
						await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
					}
					else if (rsSelUserKeyScriptWILLBET[0].STATUS == -2)
					{
						//Get message return to client
						List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B1");
						return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
					}

					IDictionary<string, object> json = new Dictionary<string, object>
						{
							{"SelUserKeyScriptWILLBET", rsSelUserKeyScriptWILLBET},
						};
					return new ResultApi { Success = ResultCode.OK, Result = json };
				}
				else
				{
					APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
					{
						WebName = WebName,
						GameName = GameName,
						UserId = userId,
						KeyId = keyId,
						UniqueDeviceId = uniqueDeviceId,
						APIName = "SelUserKeyScriptWILLBET",
						Request = JsonConvert.SerializeObject(selUserKeyScriptWILLBETInput),
						ErrorMessage = "Key login on other device!"
					};
					await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

					//Get message return to client
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B2");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}
			}
			catch (Exception ex)
			{
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = WebName,
					GameName = GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "SelUserKeyScriptWILLBET",
					Request = JsonConvert.SerializeObject(selUserKeyScriptWILLBETInput),
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B3");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpGet]
		[Authorize]
		[Route("SelUserKeyScriptWILLBET8")]
		public async Task<ActionResult<object>> SelUserKeyScriptWILLBET8(string WebName, string GameName, long? GameId)
		{
			var userIdClaim = HttpContext.User.FindFirst("UserId");
			int userId = Int32.Parse(userIdClaim.Value);
			var keyIdClaim = HttpContext.User.FindFirst("KeyId");
			int keyId = Int32.Parse(keyIdClaim.Value);
			var keyClaim = HttpContext.User.FindFirst("Key");
			string key = keyClaim.Value;
			var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
			string uniqueDeviceId = uniqueDeviceIdClaim.Value;

			//Lưu log
			SelUserKeyScriptWILLBET8Input SelUserKeyScriptWILLBET8Input = new SelUserKeyScriptWILLBET8Input
			{
				WebName = WebName,
				GameName = GameName,
				GameId = GameId,
			};
			SelUserKeyScriptWILLBET8Log SelUserKeyScriptWILLBET8Log = new SelUserKeyScriptWILLBET8Log
			{
				DatetimeAction = DateTime.Now,
				Key = key,
				UserId = userId,
				UniqueDeviceId = uniqueDeviceId,
				SelUserKeyScriptWILLBET8Input = SelUserKeyScriptWILLBET8Input
			};
			FuncFile.WriteLog<SelUserKeyScriptWILLBET8Log>(SelUserKeyScriptWILLBET8Log, _webHostEnvironment, "SelUserKeyScriptWILLBET8.txt", key, WebName, GameName);

			try
			{
				List<APDeviceCheckAvailabel> rsDeviceCheckAvailabel = await new APDeviceCheckAvailabel(_appSetting).APDeviceCheckAvailabelDAO(userId, keyId, uniqueDeviceId);
				if (rsDeviceCheckAvailabel != null && rsDeviceCheckAvailabel.Count > 0 && rsDeviceCheckAvailabel[0].Avail.Value)
				{
					List<APSelUserKeyScriptWILLBET8> rsSelUserKeyScriptWILLBET8 = await new APSelUserKeyScriptWILLBET8(_appSetting).APSelUserKeyScriptWILLBET8DAO(userId, keyId, WebName, GameName, GameId);

					//Ghi log nếu trả về null
					if (rsSelUserKeyScriptWILLBET8 == null || rsSelUserKeyScriptWILLBET8.Count == 0)
					{
						APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
						{
							WebName = WebName,
							GameName = GameName,
							UserId = userId,
							KeyId = keyId,
							UniqueDeviceId = uniqueDeviceId,
							APIName = "SelUserKeyScriptWILLBET8",
							Request = JsonConvert.SerializeObject(SelUserKeyScriptWILLBET8Input),
							ErrorMessage = "Data return null!"
						};
						await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
					}
					else if (rsSelUserKeyScriptWILLBET8[0].STATUS == -2)
					{
						//Get message return to client
						List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B1");
						return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
					}

					IDictionary<string, object> json = new Dictionary<string, object>
						{
							{"SelUserKeyScriptWILLBET8", rsSelUserKeyScriptWILLBET8},
						};
					return new ResultApi { Success = ResultCode.OK, Result = json };
				}
				else
				{
					APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
					{
						WebName = WebName,
						GameName = GameName,
						UserId = userId,
						KeyId = keyId,
						UniqueDeviceId = uniqueDeviceId,
						APIName = "SelUserKeyScriptWILLBET8",
						Request = JsonConvert.SerializeObject(SelUserKeyScriptWILLBET8Input),
						ErrorMessage = "Key login on other device!"
					};
					await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

					//Get message return to client
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B2");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}
			}
			catch (Exception ex)
			{
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = WebName,
					GameName = GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "SelUserKeyScriptWILLBET8",
					Request = JsonConvert.SerializeObject(SelUserKeyScriptWILLBET8Input),
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B3");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpGet]
		[Authorize]
		[Route("App_SelUserKeyScriptWILLBET8")]
		public async Task<ActionResult<object>> App_SelUserKeyScriptWILLBET8(string WebName, string GameName, long? GameId)
		{
			var userIdClaim = HttpContext.User.FindFirst("UserId");
			int userId = Int32.Parse(userIdClaim.Value);
			var keyIdClaim = HttpContext.User.FindFirst("KeyId");
			int keyId = Int32.Parse(keyIdClaim.Value);
			var keyClaim = HttpContext.User.FindFirst("Key");
			string key = keyClaim.Value;
			var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
			string uniqueDeviceId = uniqueDeviceIdClaim.Value;

			//Lưu log
			SelUserKeyScriptWILLBET8Input SelUserKeyScriptWILLBET8Input = new SelUserKeyScriptWILLBET8Input
			{
				WebName = WebName,
				GameName = GameName,
				GameId = GameId,
			};
			SelUserKeyScriptWILLBET8Log SelUserKeyScriptWILLBET8Log = new SelUserKeyScriptWILLBET8Log
			{
				DatetimeAction = DateTime.Now,
				Key = key,
				UserId = userId,
				UniqueDeviceId = uniqueDeviceId,
				SelUserKeyScriptWILLBET8Input = SelUserKeyScriptWILLBET8Input
			};
			FuncFile.WriteLog<SelUserKeyScriptWILLBET8Log>(SelUserKeyScriptWILLBET8Log, _webHostEnvironment, "SelUserKeyScriptWILLBET8.txt", key, WebName, GameName);

			try
			{
				List<APDeviceCheckAvailabel> rsDeviceCheckAvailabel = await new APDeviceCheckAvailabel(_appSetting).APDeviceCheckAvailabelDAO(userId, keyId, uniqueDeviceId);
				if (rsDeviceCheckAvailabel != null && rsDeviceCheckAvailabel.Count > 0 && rsDeviceCheckAvailabel[0].Avail.Value)
				{
					List<APSelUserKeyScriptWILLBET8> rsSelUserKeyScriptWILLBET8 = await new APSelUserKeyScriptWILLBET8(_appSetting).APSelUserKeyScriptWILLBET8DAO(userId, keyId, WebName, GameName, GameId);

					//Ghi log nếu trả về null
					if (rsSelUserKeyScriptWILLBET8 == null || rsSelUserKeyScriptWILLBET8.Count == 0)
					{
						APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
						{
							WebName = WebName,
							GameName = GameName,
							UserId = userId,
							KeyId = keyId,
							UniqueDeviceId = uniqueDeviceId,
							APIName = "SelUserKeyScriptWILLBET8",
							Request = JsonConvert.SerializeObject(SelUserKeyScriptWILLBET8Input),
							ErrorMessage = "Data return null!"
						};
						await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
					}
					else if (rsSelUserKeyScriptWILLBET8[0].STATUS == -2)
					{
						//Get message return to client
						List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B1");
						return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
					}

					IDictionary<string, object> json = new Dictionary<string, object>
						{
							{"SelUserKeyScriptWILLBET", rsSelUserKeyScriptWILLBET8},
						};
					return new ResultApi { Success = ResultCode.OK, Result = json };
				}
				else
				{
					APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
					{
						WebName = WebName,
						GameName = GameName,
						UserId = userId,
						KeyId = keyId,
						UniqueDeviceId = uniqueDeviceId,
						APIName = "SelUserKeyScriptWILLBET8",
						Request = JsonConvert.SerializeObject(SelUserKeyScriptWILLBET8Input),
						ErrorMessage = "Key login on other device!"
					};
					await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

					//Get message return to client
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B2");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}
			}
			catch (Exception ex)
			{
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = WebName,
					GameName = GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "SelUserKeyScriptWILLBET8",
					Request = JsonConvert.SerializeObject(SelUserKeyScriptWILLBET8Input),
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("B3");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpPost]
		[Authorize]
		[Route("TradeHistoryInsert")]
		public async Task<ActionResult<object>> TradeHistoryInsert(TradeHistoryInsertModel _tradeHistoryInsertModel)
		{
			var userIdClaim = HttpContext.User.FindFirst("UserId");
			int userId = Int32.Parse(userIdClaim.Value);
			var keyClaim = HttpContext.User.FindFirst("Key");
			string key = keyClaim.Value;
			var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
			string uniqueDeviceId = uniqueDeviceIdClaim.Value;

			//Lưu log
			TradeHistoryInsertLog tradeHistoryInsertLog = new TradeHistoryInsertLog
			{
				DatetimeAction = DateTime.Now,
				Key = key,
				UserId = userId,
				UniqueDeviceId = uniqueDeviceId,
				TradeHistoryInsertModel = _tradeHistoryInsertModel
			};
			FuncFile.WriteLog<TradeHistoryInsertLog>(tradeHistoryInsertLog, _webHostEnvironment, "TradeHistoryInsert.txt", key, _tradeHistoryInsertModel.WebName, _tradeHistoryInsertModel.GameName);

			try
			{
				APTradeHistoryInsertIN _tradeHistoryInsertIN = new APTradeHistoryInsertIN
				{
					WebName = _tradeHistoryInsertModel.WebName,
					GameName = _tradeHistoryInsertModel.GameName,
					GameId = _tradeHistoryInsertModel.GameId,
					Bet = _tradeHistoryInsertModel.Bet,
					UserId = userId,
					TaskId = _tradeHistoryInsertModel.TaskId,
					ScreenId = _tradeHistoryInsertModel.ScreenId,
					BetAmount = _tradeHistoryInsertModel.BetAmount,
					Result = _tradeHistoryInsertModel.Result,
					ResultClick = _tradeHistoryInsertModel.ResultClick,
				};

				return new ResultApi { Success = ResultCode.OK, Result = await new APTradeHistoryInsert(_appSetting).APTradeHistoryInsertDAO(_tradeHistoryInsertIN) };
			}
			catch (Exception ex)
			{
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = _tradeHistoryInsertModel.WebName,
					GameName = _tradeHistoryInsertModel.GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "TradeHistoryInsert",
					Request = JsonConvert.SerializeObject(_tradeHistoryInsertModel),
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("C1");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpPost]
		[Authorize]
		[Route("UpdateHisByClient")]
		public async Task<ActionResult<object>> UpdateHisByClient(UpdateHisByClientModel _updateHisByClientModel)
		{
			var userIdClaim = HttpContext.User.FindFirst("UserId");
			int userId = Int32.Parse(userIdClaim.Value);
			var keyIdClaim = HttpContext.User.FindFirst("KeyId");
			int keyId = Int32.Parse(keyIdClaim.Value);
			var keyClaim = HttpContext.User.FindFirst("Key");
			string key = keyClaim.Value;
			var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
			string uniqueDeviceId = uniqueDeviceIdClaim.Value;

			//Lưu log
			UpdateHisByClientLog updateHisByClientLog = new UpdateHisByClientLog
			{
				DatetimeAction = DateTime.Now,
				Key = key,
				UserId = userId,
				UniqueDeviceId = uniqueDeviceId,
				UpdateHisByClientModel = _updateHisByClientModel
			};
			FuncFile.WriteLog<UpdateHisByClientLog>(updateHisByClientLog, _webHostEnvironment, "UpdateHisByClient.txt", key, _updateHisByClientModel.WebName, _updateHisByClientModel.GameName);

			try
			{
				APUpdateHisByClientIN _updateHisByClientIN = new APUpdateHisByClientIN
				{
					WebName = _updateHisByClientModel.WebName,
					GameName = _updateHisByClientModel.GameName,
					GameId = _updateHisByClientModel.GameId,
					UserId = userId,
					KeyId = keyId,
				};

				return new ResultApi { Success = ResultCode.OK, Result = await new APUpdateHisByClient(_appSetting).APUpdateHisByClientDAO(_updateHisByClientIN) };
			}
			catch (Exception ex)
			{
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = _updateHisByClientModel.WebName,
					GameName = _updateHisByClientModel.GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "UpdateHisByClient",
					Request = JsonConvert.SerializeObject(_updateHisByClientModel),
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("D1");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpPost]
		[Authorize]
		[Route("ResetKeyUser")]
		public async Task<ActionResult<object>> ResetKeyUser(ResetKeyUserModel _resetKeyUserModel)
		{
			var userIdClaim = HttpContext.User.FindFirst("UserId");
			int userId = Int32.Parse(userIdClaim.Value);
			var keyIdClaim = HttpContext.User.FindFirst("KeyId");
			int keyId = Int32.Parse(keyIdClaim.Value);
			var keyClaim = HttpContext.User.FindFirst("Key");
			string key = keyClaim.Value;
			var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
			string uniqueDeviceId = uniqueDeviceIdClaim.Value;

			//Lưu log
			ResetKeyUserLog resetKeyUserLog = new ResetKeyUserLog
			{
				DatetimeAction = DateTime.Now,
				Key = key,
				UserId = userId,
				UniqueDeviceId = uniqueDeviceId,
				ResetKeyUserModel = _resetKeyUserModel
			};
			FuncFile.WriteLog<ResetKeyUserLog>(resetKeyUserLog, _webHostEnvironment, "ResetKeyUser.txt", key, _resetKeyUserModel.WebName, _resetKeyUserModel.GameName);

			try
			{
				APResetKeyUserIN _resetKeyUserIN = new APResetKeyUserIN
				{
					WebName = _resetKeyUserModel.WebName,
					GameName = _resetKeyUserModel.GameName,
					KeyId = keyId,
				};

				return new ResultApi { Success = ResultCode.OK, Result = await new APResetKeyUser(_appSetting).APResetKeyUserDAO(_resetKeyUserIN) };
			}
			catch (Exception ex)
			{
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = _resetKeyUserModel.WebName,
					GameName = _resetKeyUserModel.GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "ResetKeyUser",
					Request = JsonConvert.SerializeObject(_resetKeyUserModel),
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("E1");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpGet]
		[Authorize]
		[Route("GameGetAll")]
		public async Task<ActionResult<object>> GameGetAll()
		{
			try
			{
				List<APGameGetAll> rsAPGameGetAll = await new APGameGetAll(_appSetting).APGameGetAllDAO();
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"GameGetAll", rsAPGameGetAll},
					};

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = string.Empty,
					GameName = string.Empty,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "GameGetAll",
					Request = string.Empty,
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("F1");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpGet]
		[Authorize]
		[Route("StatusWSSGetByGameName")]
		public async Task<ActionResult<object>> StatusWSSGetByGameName(string WebName, string GameName)
		{
			try
			{
				////Tạo random, nếu nằm 1/5 thì sẽ bỏ qua không đánh ván này
				//Random random = new Random();

				//// Tạo số ngẫu nhiên từ 1 đến 5
				//int randomNumber = random.Next(1, 6);

				//// Kiểm tra nếu số ngẫu nhiên là 1 (1/5 xác suất)
				//if (randomNumber == 1)
				//{
				//	List<APStatusWSSGetByGameName> rsAPStatusWSSGetByGameNameSkip = new List<APStatusWSSGetByGameName> { };
				//	rsAPStatusWSSGetByGameNameSkip.Add(new APStatusWSSGetByGameName
				//	{
				//		WebName = WebName,
				//		GameName = GameName,
				//		Status = -2
				//	});
				//	//List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("H3");
				//	//return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				//	IDictionary<string, object> jsonSkip = new Dictionary<string, object>
				//	{
				//		{"StatusWSSGetByGameName", rsAPStatusWSSGetByGameNameSkip},
				//	};
				//	return new ResultApi { Success = ResultCode.OK, Result = jsonSkip };
				//}

				List<APStatusWSSGetByGameName> rsAPStatusWSSGetByGameName = await new APStatusWSSGetByGameName(_appSetting).APStatusWSSGetByGameNameDAO(WebName, GameName);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"StatusWSSGetByGameName", rsAPStatusWSSGetByGameName},
					};

				//Ghi log error
				if (rsAPStatusWSSGetByGameName.Count > 0 && rsAPStatusWSSGetByGameName[0].Status == -1)
				{
					var userIdClaim = HttpContext.User.FindFirst("UserId");
					int userId = Int32.Parse(userIdClaim.Value);
					var keyIdClaim = HttpContext.User.FindFirst("KeyId");
					int keyId = Int32.Parse(keyIdClaim.Value);
					var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
					string uniqueDeviceId = uniqueDeviceIdClaim.Value;
					APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
					{
						WebName = WebName,
						GameName = GameName,
						UserId = userId,
						KeyId = keyId,
						UniqueDeviceId = uniqueDeviceId,
						APIName = "StatusWSSGetByGameName",
						Request = string.Empty,
						ErrorMessage = "Status is -1, tool insert status or result fail"
					};
					await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

					//Get message return to client
					List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("H1");
					return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
				}

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = WebName,
					GameName = GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "StatusWSSGetByGameName",
					Request = string.Empty,
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);

				//Get message return to client
				List<APMessageGetByCode> rsAPMessageGetByCode = await new APMessageGetByCode(_appSetting).APMessageGetByCodeDAO("H2");
				return new ResultApi { Success = ResultCode.ERROR, Message = (rsAPMessageGetByCode != null && rsAPMessageGetByCode.Count > 0 ? rsAPMessageGetByCode[0].Message : string.Empty) };
			}
		}

		[HttpPost]
		[Authorize]
		[Route("ApClientErrorInsert")]
		public async Task<ActionResult<object>> ApClientErrorInsert(APApClientErrorInsertIN _aPApClientErrorInsertIN)
		{
			try
			{
				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;

				_aPApClientErrorInsertIN.UserId = userId;
				_aPApClientErrorInsertIN.KeyId = keyId;
				_aPApClientErrorInsertIN.UniqueDeviceId = uniqueDeviceId;
				return new ResultApi { Success = ResultCode.OK, Result = await new APApClientErrorInsert(_appSetting).APApClientErrorInsertDAO(_aPApClientErrorInsertIN) };
			}
			catch (Exception ex)
			{
				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[Authorize]
		[Route("ApClientClickHistoryInsert")]
		public async Task<ActionResult<object>> ApClientClickHistoryInsert(ApClientClickHistoryInsertIN _apClientClickHistoryInsertIN)
		{
			try
			{
				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;

				_apClientClickHistoryInsertIN.UserId = userId;
				_apClientClickHistoryInsertIN.KeyId = keyId;
				_apClientClickHistoryInsertIN.UniqueDeviceId = uniqueDeviceId;

				return new ResultApi { Success = ResultCode.OK, Result = await new ApClientClickHistoryInsert(_appSetting).ApClientClickHistoryInsertDAO(_apClientClickHistoryInsertIN) };
			}
			catch (Exception ex)
			{
				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpPost]
		[Authorize]
		[Route("ApStopTradeSendNoti")]
		public async Task<ActionResult<object>> ApStopTradeSendNoti(ApStopTradeSendNotiInput _apStopTradeSendNotiInput)
		{
			try
			{
				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;

				await  FuncWeb.SendNoti($"{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}: {_apStopTradeSendNotiInput.WebName} : {_apStopTradeSendNotiInput.GameName} : {keyId} : {uniqueDeviceId} : {_apStopTradeSendNotiInput.GameId} : {_apStopTradeSendNotiInput.Message} : Tool trade đang bị gián đoạn, hãy vào start lại.\n", _config);

				return new ResultApi { Success = ResultCode.OK };
			}
			catch (Exception ex)
			{
				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}

		[HttpGet]
		[Authorize]
		[Route("APGameGetItemClick")]
		public async Task<ActionResult<object>> APGameGetItemClick(string WebName, string GameName, int? Amount, int? Result)
		{
			try
			{
				List<APGameGetItemClick> rsAPGameGetItemClick = await new APGameGetItemClick(_appSetting).APGameGetItemClickDAO(WebName, GameName, Amount, Result);
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"APGameGetItemClick", rsAPGameGetItemClick},
					};
				new LogHelper(_appSetting).ProcessInsertLogActionAsync(HttpContext, null);

				return new ResultApi { Success = ResultCode.OK, Result = json };
			}
			catch (Exception ex)
			{
				var userIdClaim = HttpContext.User.FindFirst("UserId");
				int userId = Int32.Parse(userIdClaim.Value);
				var keyIdClaim = HttpContext.User.FindFirst("KeyId");
				int keyId = Int32.Parse(keyIdClaim.Value);
				var uniqueDeviceIdClaim = HttpContext.User.FindFirst("UniqueDeviceId");
				string uniqueDeviceId = uniqueDeviceIdClaim.Value;
				APErrorInsertIN _aPErrorInsertIN = new APErrorInsertIN
				{
					WebName = WebName,
					GameName = GameName,
					UserId = userId,
					KeyId = keyId,
					UniqueDeviceId = uniqueDeviceId,
					APIName = "APGameGetItemClick",
					Request = string.Empty,
					ErrorMessage = ex.Message
				};
				await new APErrorInsert(_appSetting).APErrorInsertDAO(_aPErrorInsertIN);
				return new ResultApi { Success = ResultCode.ERROR, Message = ex.Message };
			}
		}
	}
}
