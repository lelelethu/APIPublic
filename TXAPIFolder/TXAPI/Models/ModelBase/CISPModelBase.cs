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
	public class CIResultCIMInsert
	{
		private SQLCon _sQLCon;

		public CIResultCIMInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public CIResultCIMInsert()
		{
		}

		public async Task<int> CIResultCIMInsertDAO(CIResultCIMInsertIN _cIResultCIMInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _cIResultCIMInsertIN.DataKey);
			DP.Add("WebName", _cIResultCIMInsertIN.WebName);
			DP.Add("GameName", _cIResultCIMInsertIN.GameName);
			DP.Add("GameId", _cIResultCIMInsertIN.GameId);
			DP.Add("Result", _cIResultCIMInsertIN.Result);
			DP.Add("GameDateEnd", _cIResultCIMInsertIN.GameDateEnd);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("CI_ResultCIMInsert", DP));
		}
	}

	public class CIResultCIMInsertIN
	{
		public string DataKey { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public bool? Result { get; set; }
		public DateTime? GameDateEnd { get; set; }
	}

	public class CIStatusCIMUpdate
	{
		private SQLCon _sQLCon;

		public CIStatusCIMUpdate(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public CIStatusCIMUpdate()
		{
		}

		public async Task<int> CIStatusCIMUpdateDAO(CIStatusCIMUpdateIN _cIStatusCIMUpdateIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _cIStatusCIMUpdateIN.DataKey);
			DP.Add("WebName", _cIStatusCIMUpdateIN.WebName);
			DP.Add("GameName", _cIStatusCIMUpdateIN.GameName);
			DP.Add("GameId", _cIStatusCIMUpdateIN.GameId);
			DP.Add("Status", _cIStatusCIMUpdateIN.Status);
			DP.Add("GameDateEnd", _cIStatusCIMUpdateIN.GameDateEnd);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("CI_StatusCIMUpdate", DP));
		}
	}

	public class CIStatusCIMUpdateIN
	{
		public string DataKey { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public short? Status { get; set; }
		public DateTime? GameDateEnd { get; set; }
	}
}
