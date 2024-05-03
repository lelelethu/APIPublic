using System;
using Dapper;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;
using System.Data;
using TXAPI.Common;
using TXAPI.Models.Results;

namespace TXAPI.ModelBase
{
	public class APApClientErrorInsert
	{
		private SQLCon _sQLCon;

		public APApClientErrorInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APApClientErrorInsert()
		{
		}

		public async Task<int> APApClientErrorInsertDAO(APApClientErrorInsertIN _aPApClientErrorInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", _aPApClientErrorInsertIN.WebName);
			DP.Add("GameName", _aPApClientErrorInsertIN.GameName);
			DP.Add("ErrorMessage", _aPApClientErrorInsertIN.ErrorMessage);
			DP.Add("CreatedDate", _aPApClientErrorInsertIN.CreatedDate);
			DP.Add("UserId", _aPApClientErrorInsertIN.UserId);
			DP.Add("KeyId", _aPApClientErrorInsertIN.KeyId);
			DP.Add("UniqueDeviceId", _aPApClientErrorInsertIN.UniqueDeviceId);
			DP.Add("APIName", _aPApClientErrorInsertIN.APIName);
			DP.Add("Response", _aPApClientErrorInsertIN.Response);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_ApClient_ErrorInsert", DP));
		}
	}

	public class APApClientErrorInsertIN
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public string ErrorMessage { get; set; }
		public DateTime? CreatedDate { get; set; }
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string UniqueDeviceId { get; set; }
		public string APIName { get; set; }
		public string Response { get; set; }
	}

	public class ApClientClickHistoryInsert
	{
		private SQLCon _sQLCon;

		public ApClientClickHistoryInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public ApClientClickHistoryInsert()
		{
		}

		public async Task<int> ApClientClickHistoryInsertDAO(ApClientClickHistoryInsertIN _apClientClickHistoryInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", _apClientClickHistoryInsertIN.WebName);
			DP.Add("GameName", _apClientClickHistoryInsertIN.GameName);
			DP.Add("UserId", _apClientClickHistoryInsertIN.UserId);
			DP.Add("KeyId", _apClientClickHistoryInsertIN.KeyId);
			DP.Add("UniqueDeviceId", _apClientClickHistoryInsertIN.UniqueDeviceId);
			DP.Add("X", _apClientClickHistoryInsertIN.X);
			DP.Add("Y", _apClientClickHistoryInsertIN.Y);
			DP.Add("Amount", _apClientClickHistoryInsertIN.Amount);
			DP.Add("ActionName", _apClientClickHistoryInsertIN.ActionName);
			DP.Add("ClickResult", _apClientClickHistoryInsertIN.ClickResult);
			DP.Add("ClickCount", _apClientClickHistoryInsertIN.ClickCount);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("Ap_ClientClickHistoryInsert", DP));
		}
	}

	public class ApClientClickHistoryInsertIN
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string UniqueDeviceId { get; set; }
		public int? X { get; set; }
		public int? Y { get; set; }
		public double? Amount { get; set; }
		public string ActionName { get; set; }
		public bool? ClickResult { get; set; }
		public int? ClickCount { get; set; }
	}

	public class APDeviceCheckAvailabel
	{
		private SQLCon _sQLCon;

		public APDeviceCheckAvailabel(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APDeviceCheckAvailabel()
		{
		}

		public bool? Avail { get; set; } // bit, null

		public async Task<List<APDeviceCheckAvailabel>> APDeviceCheckAvailabelDAO(int? UserId, int? KeyId, string UniqueDeviceId)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("UserId", UserId);
			DP.Add("KeyId", KeyId);
			DP.Add("UniqueDeviceId", UniqueDeviceId);

			return (await _sQLCon.ExecuteListDapperAsync<APDeviceCheckAvailabel>("AP_DeviceCheckAvailabel", DP)).ToList();
		}
	}

	public class APDeviceInsert
	{
		private SQLCon _sQLCon;

		public APDeviceInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APDeviceInsert()
		{
		}

		public async Task<int> APDeviceInsertDAO(APDeviceInsertIN _aPDeviceInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("UserId", _aPDeviceInsertIN.UserId);
			DP.Add("KeyId", _aPDeviceInsertIN.KeyId);
			DP.Add("AndroidId", _aPDeviceInsertIN.AndroidId);
			DP.Add("AppId", _aPDeviceInsertIN.AppId);
			DP.Add("AppVersionName", _aPDeviceInsertIN.AppVersionName);
			DP.Add("IpAddress", _aPDeviceInsertIN.IpAddress);
			DP.Add("IsDevelopmentSetting", _aPDeviceInsertIN.IsDevelopmentSetting);
			DP.Add("IsDeviceRooted", _aPDeviceInsertIN.IsDeviceRooted);
			DP.Add("IsEmulator", _aPDeviceInsertIN.IsEmulator);
			DP.Add("IsTablet", _aPDeviceInsertIN.IsTablet);
			DP.Add("Language", _aPDeviceInsertIN.Language);
			DP.Add("Manufacturer", _aPDeviceInsertIN.Manufacturer);
			DP.Add("Model", _aPDeviceInsertIN.Model);
			DP.Add("NetType", _aPDeviceInsertIN.NetType);
			DP.Add("OsVersion", _aPDeviceInsertIN.OsVersion);
			DP.Add("PhoneBrand", _aPDeviceInsertIN.PhoneBrand);
			DP.Add("ScreenSize", _aPDeviceInsertIN.ScreenSize);
			DP.Add("SdkVersionCode", _aPDeviceInsertIN.SdkVersionCode);
			DP.Add("SdkVersionName", _aPDeviceInsertIN.SdkVersionName);
			DP.Add("UniqueDeviceId", _aPDeviceInsertIN.UniqueDeviceId);
			DP.Add("Device", _aPDeviceInsertIN.Device);
			DP.Add("InfoDevice", _aPDeviceInsertIN.InfoDevice);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_DeviceInsert", DP));
		}
	}

	public class APDeviceInsertIN
	{
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string AndroidId { get; set; }
		public string AppId { get; set; }
		public string AppVersionName { get; set; }
		public string IpAddress { get; set; }
		public bool? IsDevelopmentSetting { get; set; }
		public bool? IsDeviceRooted { get; set; }
		public bool? IsEmulator { get; set; }
		public bool? IsTablet { get; set; }
		public string Language { get; set; }
		public string Manufacturer { get; set; }
		public string Model { get; set; }
		public string NetType { get; set; }
		public string OsVersion { get; set; }
		public string PhoneBrand { get; set; }
		public string ScreenSize { get; set; }
		public int? SdkVersionCode { get; set; }
		public string SdkVersionName { get; set; }
		public string UniqueDeviceId { get; set; }
		public string Device { get; set; }
		public string InfoDevice { get; set; }
	}

	public class APErrorInsert
	{
		private SQLCon _sQLCon;

		public APErrorInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APErrorInsert()
		{
		}

		public async Task<int> APErrorInsertDAO(APErrorInsertIN _aPErrorInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", _aPErrorInsertIN.WebName);
			DP.Add("GameName", _aPErrorInsertIN.GameName);
			DP.Add("ErrorMessage", _aPErrorInsertIN.ErrorMessage);
			DP.Add("CreatedDate", _aPErrorInsertIN.CreatedDate);
			DP.Add("UserId", _aPErrorInsertIN.UserId);
			DP.Add("KeyId", _aPErrorInsertIN.KeyId);
			DP.Add("UniqueDeviceId", _aPErrorInsertIN.UniqueDeviceId);
			DP.Add("APIName", _aPErrorInsertIN.APIName);
			DP.Add("Request", _aPErrorInsertIN.Request);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_ErrorInsert", DP));
		}
	}

	public class APErrorInsertIN
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public string ErrorMessage { get; set; }
		public DateTime? CreatedDate { get; set; }
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string UniqueDeviceId { get; set; }
		public string APIName { get; set; }
		public string Request { get; set; }
	}

	public class APGameGetAll
	{
		private SQLCon _sQLCon;

		public APGameGetAll(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APGameGetAll()
		{
		}

		public int Id { get; set; } // int, not null
		public string Name { get; set; } // nvarchar(256), not null
		public string WebName { get; set; } // nvarchar(256), not null
		public string GameName { get; set; } // nvarchar(256), not null
		public string Desc { get; set; } // nvarchar(256), null
		public string TargetPackage { get; set; } // nvarchar(256), null
		public string Apk { get; set; } // nvarchar(256), null
		public DateTime? CreatedDate { get; set; } // date, null

		public async Task<List<APGameGetAll>> APGameGetAllDAO()
		{
			DynamicParameters DP = new DynamicParameters();

			return (await _sQLCon.ExecuteListDapperAsync<APGameGetAll>("AP_GameGetAll", DP)).ToList();
		}
	}

	public class APGameGetItemClick
	{
		private SQLCon _sQLCon;

		public APGameGetItemClick(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APGameGetItemClick()
		{
		}

		public string Item { get; set; } // varchar(50), null
		public int? ClickCount { get; set; } // int, null

		public async Task<List<APGameGetItemClick>> APGameGetItemClickDAO(string WebName, string GameName, int? Amount, int? Result)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", WebName);
			DP.Add("GameName", GameName);
			DP.Add("Amount", Amount);
			DP.Add("Result", Result);

			return (await _sQLCon.ExecuteListDapperAsync<APGameGetItemClick>("AP_GameGetItemClick", DP)).ToList();
		}
	}

	public class APInsUserKeyScript
	{
		private SQLCon _sQLCon;

		public APInsUserKeyScript(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APInsUserKeyScript()
		{
		}

		public async Task<int> APInsUserKeyScriptDAO(APInsUserKeyScriptIN _aPInsUserKeyScriptIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("UserId", _aPInsUserKeyScriptIN.UserId);
			DP.Add("KeyId", _aPInsUserKeyScriptIN.KeyId);
			DP.Add("WebName", _aPInsUserKeyScriptIN.WebName);
			DP.Add("GameName", _aPInsUserKeyScriptIN.GameName);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_InsUserKeyScript", DP));
		}
	}

	public class APInsUserKeyScriptIN
	{
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
	}

	public class APMessageGetByCode
	{
		private SQLCon _sQLCon;

		public APMessageGetByCode(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APMessageGetByCode()
		{
		}

		public long Id { get; set; } // bigint, not null
		public string Code { get; set; } // nvarchar(256), not null
		public string APIName { get; set; } // nvarchar(256), null
		public string Message { get; set; } // nvarchar(max), null
		public string Description { get; set; } // nvarchar(max), null
		public DateTime? CreatedDate { get; set; } // datetime, null

		public async Task<List<APMessageGetByCode>> APMessageGetByCodeDAO(string Code)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("Code", Code);

			return (await _sQLCon.ExecuteListDapperAsync<APMessageGetByCode>("AP_MessageGetByCode", DP)).ToList();
		}
	}

	public class APResetKeyUser
	{
		private SQLCon _sQLCon;

		public APResetKeyUser(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APResetKeyUser()
		{
		}

		public async Task<int> APResetKeyUserDAO(APResetKeyUserIN _aPResetKeyUserIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", _aPResetKeyUserIN.WebName);
			DP.Add("GameName", _aPResetKeyUserIN.GameName);
			DP.Add("KeyId", _aPResetKeyUserIN.KeyId);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_ResetKeyUser", DP));
		}
	}

	public class APResetKeyUserIN
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? KeyId { get; set; }
	}

	public class APSelUserKeyScriptWILLBET
	{
		private SQLCon _sQLCon;

		public APSelUserKeyScriptWILLBET(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APSelUserKeyScriptWILLBET()
		{
		}

		public int STATUS { get; set; } // int, not null
		public int? unitAmount { get; set; } // int, null
		public int? bet_Expected { get; set; } // int, null

		public async Task<List<APSelUserKeyScriptWILLBET>> APSelUserKeyScriptWILLBETDAO(int? UserId, int? KeyId, string WebName, string GameName, long? GameId)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("UserId", UserId);
			DP.Add("KeyId", KeyId);
			DP.Add("WebName", WebName);
			DP.Add("GameName", GameName);
			DP.Add("GameId", GameId);

			return (await _sQLCon.ExecuteListDapperAsync<APSelUserKeyScriptWILLBET>("AP_SelUserKeyScript_WILL_BET", DP)).ToList();
		}
	}

	public class APSelUserKeyScriptWILLBETIN
	{
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
	}

	public class APSelUserKeyScriptWILLBET8
	{
		private SQLCon _sQLCon;

		public APSelUserKeyScriptWILLBET8(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APSelUserKeyScriptWILLBET8()
		{
		}

		public int STATUS { get; set; } // int, not null
		public int? unitAmount { get; set; } // int, null
		public int? bet_Expected { get; set; } // int, null

		public async Task<List<APSelUserKeyScriptWILLBET8>> APSelUserKeyScriptWILLBET8DAO(int? UserId, int? KeyId, string WebName, string GameName, long? GameId)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("UserId", UserId);
			DP.Add("KeyId", KeyId);
			DP.Add("WebName", WebName);
			DP.Add("GameName", GameName);
			DP.Add("GameId", GameId);

			return (await _sQLCon.ExecuteListDapperAsync<APSelUserKeyScriptWILLBET8>("AP_SelUserKeyScript_WILL_BET_8", DP)).ToList();
		}
	}

	public class APSelUserKeyScriptWILLBET8IN
	{
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
	}

	public class APStatusWSSGetByGameName
	{
		private SQLCon _sQLCon;

		public APStatusWSSGetByGameName(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APStatusWSSGetByGameName()
		{
		}

		public short Id { get; set; } // smallint, not null
		public string WebName { get; set; } // nvarchar(256), not null
		public string GameName { get; set; } // nvarchar(256), not null
		public long? GameId { get; set; } // bigint, null
		public int Status { get; set; } // int, not null
		public DateTime? GameDateEnd { get; set; } // datetime, null
		public DateTime? ModifieldDate { get; set; } // datetime, null
		public int NumberSecond { get; set; } // int, not null
		public bool? LastResult { get; set; } // bit, null

		public async Task<List<APStatusWSSGetByGameName>> APStatusWSSGetByGameNameDAO(string WebName, string GameName)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", WebName);
			DP.Add("GameName", GameName);

			return (await _sQLCon.ExecuteListDapperAsync<APStatusWSSGetByGameName>("AP_StatusWSSGetByGameName", DP)).ToList();
		}
	}

	public class APTradeHistoryInsert
	{
		private SQLCon _sQLCon;

		public APTradeHistoryInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APTradeHistoryInsert()
		{
		}

		public async Task<int> APTradeHistoryInsertDAO(APTradeHistoryInsertIN _aPTradeHistoryInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", _aPTradeHistoryInsertIN.WebName);
			DP.Add("GameName", _aPTradeHistoryInsertIN.GameName);
			DP.Add("GameId", _aPTradeHistoryInsertIN.GameId);
			DP.Add("Bet", _aPTradeHistoryInsertIN.Bet);
			DP.Add("UserId", _aPTradeHistoryInsertIN.UserId);
			DP.Add("TaskId", _aPTradeHistoryInsertIN.TaskId);
			DP.Add("ScreenId", _aPTradeHistoryInsertIN.ScreenId);
			DP.Add("BetAmount", _aPTradeHistoryInsertIN.BetAmount);
			DP.Add("Result", _aPTradeHistoryInsertIN.Result);
			DP.Add("ResultClick", _aPTradeHistoryInsertIN.ResultClick);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_TradeHistoryInsert", DP));
		}
	}

	public class APTradeHistoryInsertIN
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public string Bet { get; set; }
		public int? UserId { get; set; }
		public int? TaskId { get; set; }
		public int? ScreenId { get; set; }
		public double? BetAmount { get; set; }
		public bool? Result { get; set; }
		public bool? ResultClick { get; set; }
	}

	public class APUpdateHisByClient
	{
		private SQLCon _sQLCon;

		public APUpdateHisByClient(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APUpdateHisByClient()
		{
		}

		public async Task<int> APUpdateHisByClientDAO(APUpdateHisByClientIN _aPUpdateHisByClientIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("UserId", _aPUpdateHisByClientIN.UserId);
			DP.Add("KeyId", _aPUpdateHisByClientIN.KeyId);
			DP.Add("WebName", _aPUpdateHisByClientIN.WebName);
			DP.Add("GameName", _aPUpdateHisByClientIN.GameName);
			DP.Add("GameId", _aPUpdateHisByClientIN.GameId);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_UpdateHisByClient", DP));
		}
	}

	public class APUpdateHisByClientIN
	{
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
	}

	public class APUserGetByKey
	{
		private SQLCon _sQLCon;

		public APUserGetByKey(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APUserGetByKey()
		{
		}

		public int UserId { get; set; } // int, not null
		public string UserName { get; set; } // nvarchar(256), null
		public string FirstName { get; set; } // nvarchar(256), null
		public string LastName { get; set; } // nvarchar(256), null
		public string Email { get; set; } // nvarchar(256), null
		public string Key { get; set; } // nvarchar(256), null
		public int? KeyId { get; set; } // int, null
		public double? LimitMoney { get; set; } // float, null
		public DateTime? ExpireDate { get; set; } // date, null
		public bool? Status { get; set; } // bit, null

		public async Task<List<APUserGetByKey>> APUserGetByKeyDAO(string Key)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("Key", Key);

			return (await _sQLCon.ExecuteListDapperAsync<APUserGetByKey>("AP_UserGetByKey", DP)).ToList();
		}
	}

	public class APUserKeyHistoryImageInsert
	{
		private SQLCon _sQLCon;

		public APUserKeyHistoryImageInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public APUserKeyHistoryImageInsert()
		{
		}

		public async Task<int> APUserKeyHistoryImageInsertDAO(APUserKeyHistoryImageInsertIN _aPUserKeyHistoryImageInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("WebName", _aPUserKeyHistoryImageInsertIN.WebName);
			DP.Add("GameName", _aPUserKeyHistoryImageInsertIN.GameName);
			DP.Add("UserId", _aPUserKeyHistoryImageInsertIN.UserId);
			DP.Add("KeyId", _aPUserKeyHistoryImageInsertIN.KeyId);
			DP.Add("Image", _aPUserKeyHistoryImageInsertIN.Image);
			DP.Add("GameId", _aPUserKeyHistoryImageInsertIN.GameId);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("AP_UserKeyHistoryImageInsert", DP));
		}
	}

	public class APUserKeyHistoryImageInsertIN
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public string Image { get; set; }
		public long? GameId { get; set; }
	}
}
