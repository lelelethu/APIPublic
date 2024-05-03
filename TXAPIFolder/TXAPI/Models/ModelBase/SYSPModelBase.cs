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
	public class SYLinkGameJsGetAll
	{
		private SQLCon _sQLCon;

		public SYLinkGameJsGetAll(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public SYLinkGameJsGetAll()
		{
		}

		public long Id { get; set; } // bigint, not null
		public string LinkGame { get; set; } // nvarchar(255), null
		public string LinkJs { get; set; } // nvarchar(255), null

		public async Task<List<SYLinkGameJsGetAll>> SYLinkGameJsGetAllDAO()
		{
			DynamicParameters DP = new DynamicParameters();

			return (await _sQLCon.ExecuteListDapperAsync<SYLinkGameJsGetAll>("SY_LinkGameJsGetAll", DP)).ToList();
		}
	}

	public class SYTokenInsert
	{
		private SQLCon _sQLCon;

		public SYTokenInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public SYTokenInsert()
		{
		}

		public async Task<int> SYTokenInsertDAO(SYTokenInsertIN _sYTokenInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("LinkGame", _sYTokenInsertIN.LinkGame);
			DP.Add("Token", _sYTokenInsertIN.Token);
			DP.Add("UserName", _sYTokenInsertIN.UserName);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("SY_TokenInsert", DP));
		}
	}

	public class SYTokenInsertIN
	{
		public string LinkGame { get; set; }
		public string Token { get; set; }
		public string UserName { get; set; }
	}
}
