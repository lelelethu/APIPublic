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
	public class TEResultTESInsert
	{
		private SQLCon _sQLCon;

		public TEResultTESInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public TEResultTESInsert()
		{
		}

		public async Task<int> TEResultTESInsertDAO(TEResultTESInsertIN _tEResultTESInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _tEResultTESInsertIN.DataKey);
			DP.Add("WebName", _tEResultTESInsertIN.WebName);
			DP.Add("GameName", _tEResultTESInsertIN.GameName);
			DP.Add("GameId", _tEResultTESInsertIN.GameId);
			DP.Add("Result", _tEResultTESInsertIN.Result);
			DP.Add("GameDateEnd", _tEResultTESInsertIN.GameDateEnd);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("TE_ResultTESInsert", DP));
		}
	}

	public class TEResultTESInsertIN
	{
		public string DataKey { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public bool? Result { get; set; }
		public DateTime? GameDateEnd { get; set; }
	}

	public class TEStatusTESUpdate
	{
		private SQLCon _sQLCon;

		public TEStatusTESUpdate(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public TEStatusTESUpdate()
		{
		}

		public async Task<int> TEStatusTESUpdateDAO(TEStatusTESUpdateIN _tEStatusTESUpdateIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _tEStatusTESUpdateIN.DataKey);
			DP.Add("WebName", _tEStatusTESUpdateIN.WebName);
			DP.Add("GameName", _tEStatusTESUpdateIN.GameName);
			DP.Add("GameId", _tEStatusTESUpdateIN.GameId);
			DP.Add("Status", _tEStatusTESUpdateIN.Status);
			DP.Add("GameDateEnd", _tEStatusTESUpdateIN.GameDateEnd);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("TE_StatusTESUpdate", DP));
		}
	}

	public class TEStatusTESUpdateIN
	{
		public string DataKey { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public short? Status { get; set; }
		public DateTime? GameDateEnd { get; set; }
	}
}
