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
	public class KeyInsert
	{
		private SQLCon _sQLCon;

		public KeyInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public KeyInsert()
		{
		}

		public async Task<int> KeyInsertDAO(KeyInsertIN _keyInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("Key", _keyInsertIN.Key);
			DP.Add("ExpireDate", _keyInsertIN.ExpireDate);
			DP.Add("LimitMoney", _keyInsertIN.LimitMoney);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("KeyInsert", DP));
		}
	}

	public class KeyInsertIN
	{
		public string Key { get; set; }
		public DateTime? ExpireDate { get; set; }
		public double? LimitMoney { get; set; }
	}

	public class ResultGetAllOnPage
	{
		private SQLCon _sQLCon;

		public ResultGetAllOnPage(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public ResultGetAllOnPage()
		{
		}

		public long Id { get; set; }
		public int? RowNumber { get; set; }
		public string LinkGame { get; set; }
		public string TenGame { get; set; }
		public string KetQua { get; set; }
		public DateTime? CreatedDate { get; set; }

		public async Task<List<ResultGetAllOnPage>> ResultGetAllOnPageDAO(int? PageSize, int? PageIndex, string LinkGame, string TenGame, DateTime? StartDate, DateTime? EndDate)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("PageSize", PageSize);
			DP.Add("PageIndex", PageIndex);
			DP.Add("LinkGame", LinkGame);
			DP.Add("TenGame", TenGame);
			DP.Add("StartDate", StartDate);
			DP.Add("EndDate", EndDate);

			return (await _sQLCon.ExecuteListDapperAsync<ResultGetAllOnPage>("ResultGetAllOnPage", DP)).ToList();
		}
	}

	public class ResultInsert
	{
		private SQLCon _sQLCon;

		public ResultInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public ResultInsert()
		{
		}

		public async Task<int> ResultInsertDAO(ResultInsertIN _resultInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("LinkGame", _resultInsertIN.LinkGame);
			DP.Add("TenGame", _resultInsertIN.TenGame);
			DP.Add("KetQua", _resultInsertIN.KetQua);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("ResultInsert", DP));
		}
	}

	public class ResultInsertIN
	{
		public string LinkGame { get; set; }
		public string TenGame { get; set; }
		public string KetQua { get; set; }
	}

	public class UserGetByKey
	{
		private SQLCon _sQLCon;

		public UserGetByKey(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public UserGetByKey()
		{
		}

		public int Id { get; set; }
		public string UserName { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string Email { get; set; }
		public string Key { get; set; }
		public double? LimitMoney { get; set; }
		public DateTime? ExpireDate { get; set; }

		public async Task<List<UserGetByKey>> UserGetByKeyDAO(string Key)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("Key", Key);

			return (await _sQLCon.ExecuteListDapperAsync<UserGetByKey>("UserGetByKey", DP)).ToList();
		}
	}
}
