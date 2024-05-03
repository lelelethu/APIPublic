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
	public class WSResultWSSGetAllOnPage
	{
		private SQLCon _sQLCon;

		public WSResultWSSGetAllOnPage(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public WSResultWSSGetAllOnPage()
		{
		}

		public int? RowNumber { get; set; } // int, null
		public long Id { get; set; } // bigint, not null
		public string WebName { get; set; } // nvarchar(256), not null
		public string GameName { get; set; } // nvarchar(256), not null
		public long GameId { get; set; } // bigint, not null
		public bool Result { get; set; } // bit, not null
		public DateTime? GameDateEnd { get; set; } // datetime, null
		public DateTime? CreatedDate { get; set; } // datetime, null

		public async Task<List<WSResultWSSGetAllOnPage>> WSResultWSSGetAllOnPageDAO(string DataKey, string WebName, string GameName, int? PageSize, int? PageIndex)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", DataKey);
			DP.Add("WebName", WebName);
			DP.Add("GameName", GameName);
			DP.Add("PageSize", PageSize);
			DP.Add("PageIndex", PageIndex);

			return (await _sQLCon.ExecuteListDapperAsync<WSResultWSSGetAllOnPage>("WS_ResultWSSGetAllOnPage", DP)).ToList();
		}
	}

	public class WSResultWSSGetLastestResult
	{
		private SQLCon _sQLCon;

		public WSResultWSSGetLastestResult(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public WSResultWSSGetLastestResult()
		{
		}

		public long Id { get; set; } // bigint, not null
		public string WebName { get; set; } // nvarchar(256), not null
		public string GameName { get; set; } // nvarchar(256), not null
		public long GameId { get; set; } // bigint, not null
		public bool Result { get; set; } // bit, not null
		public DateTime? GameDateEnd { get; set; } // datetime, null
		public DateTime? CreatedDate { get; set; } // datetime, null

		public async Task<List<WSResultWSSGetLastestResult>> WSResultWSSGetLastestResultDAO(string DataKey, string WebName, string GameName)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", DataKey);
			DP.Add("WebName", WebName);
			DP.Add("GameName", GameName);

			return (await _sQLCon.ExecuteListDapperAsync<WSResultWSSGetLastestResult>("WS_ResultWSSGetLastestResult", DP)).ToList();
		}
	}

	public class WSResultWSSInsert
	{
		private SQLCon _sQLCon;

		public WSResultWSSInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public WSResultWSSInsert()
		{
		}

		public async Task<int> WSResultWSSInsertDAO(WSResultWSSInsertIN _wSResultWSSInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _wSResultWSSInsertIN.DataKey);
			DP.Add("WebName", _wSResultWSSInsertIN.WebName);
			DP.Add("GameName", _wSResultWSSInsertIN.GameName);
			DP.Add("GameId", _wSResultWSSInsertIN.GameId);
			DP.Add("Result", _wSResultWSSInsertIN.Result);
			DP.Add("GameDateEnd", _wSResultWSSInsertIN.GameDateEnd);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("WS_ResultWSSInsert", DP));
		}
	}

	public class WSResultWSSInsertIN
	{
		public string DataKey { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public bool? Result { get; set; }
		public DateTime? GameDateEnd { get; set; }
	}

	public class WSStatusWSSUpdate
	{
		private SQLCon _sQLCon;

		public WSStatusWSSUpdate(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public WSStatusWSSUpdate()
		{
		}

		public async Task<int> WSStatusWSSUpdateDAO(WSStatusWSSUpdateIN _wSStatusWSSUpdateIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _wSStatusWSSUpdateIN.DataKey);
			DP.Add("WebName", _wSStatusWSSUpdateIN.WebName);
			DP.Add("GameName", _wSStatusWSSUpdateIN.GameName);
			DP.Add("GameId", _wSStatusWSSUpdateIN.GameId);
			DP.Add("Status", _wSStatusWSSUpdateIN.Status);
			DP.Add("GameDateEnd", _wSStatusWSSUpdateIN.GameDateEnd);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("WS_StatusWSSUpdate", DP));
		}
	}

	public class WSStatusWSSUpdateIN
	{
		public string DataKey { get; set; }
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public short? Status { get; set; }
		public DateTime? GameDateEnd { get; set; }
	}

	public class WSTokenGetSingleToken
	{
		private SQLCon _sQLCon;

		public WSTokenGetSingleToken(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public WSTokenGetSingleToken()
		{
		}

		public long Id { get; set; } // bigint, not null
		public string Token { get; set; } // nchar(255), null
		public string UserName { get; set; } // nchar(255), null
		public DateTime? EndDate { get; set; } // datetime, null
		public bool? Status { get; set; } // bit, null

		public async Task<List<WSTokenGetSingleToken>> WSTokenGetSingleTokenDAO(string DataKey, string LinkGame)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", DataKey);
			DP.Add("LinkGame", LinkGame);

			return (await _sQLCon.ExecuteListDapperAsync<WSTokenGetSingleToken>("WS_TokenGetSingleToken", DP)).ToList();
		}
	}

	public class WSTokenUpdateStatus
	{
		private SQLCon _sQLCon;

		public WSTokenUpdateStatus(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public WSTokenUpdateStatus()
		{
		}

		public async Task<int> WSTokenUpdateStatusDAO(WSTokenUpdateStatusIN _wSTokenUpdateStatusIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("DataKey", _wSTokenUpdateStatusIN.DataKey);
			DP.Add("Id", _wSTokenUpdateStatusIN.Id);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("WS_TokenUpdateStatus", DP));
		}
	}

	public class WSTokenUpdateStatusIN
	{
		public string DataKey { get; set; }
		public long? Id { get; set; }
	}
}
