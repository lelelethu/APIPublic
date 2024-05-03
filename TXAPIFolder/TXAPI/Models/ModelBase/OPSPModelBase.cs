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
	public class OPKeyInsert
	{
		private SQLCon _sQLCon;

		public OPKeyInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPKeyInsert()
		{
		}

		public string Key { get; set; } // nvarchar(256), null

		public async Task<List<OPKeyInsert>> OPKeyInsertDAO(string AdminKey, double? AmountUnit, DateTime? ExpireDate, double? LimitMoney)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", AdminKey);
			DP.Add("AmountUnit", AmountUnit);
			DP.Add("ExpireDate", ExpireDate);
			DP.Add("LimitMoney", LimitMoney);

			return (await _sQLCon.ExecuteListDapperAsync<OPKeyInsert>("OP_KeyInsert", DP)).ToList();
		}
	}

	public class OPKeyInsertIN
	{
		public string AdminKey { get; set; }
		public double? AmountUnit { get; set; }
		public DateTime? ExpireDate { get; set; }
		public double? LimitMoney { get; set; }
	}

	public class OPKeySearch
	{
		private SQLCon _sQLCon;

		public OPKeySearch(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPKeySearch()
		{
		}

		public int Id { get; set; } // int, not null
		public string Key { get; set; } // nvarchar(256), not null
		public double? AmountUnit { get; set; } // float, null
		public bool Status { get; set; } // bit, not null
		public DateTime? ExpireDate { get; set; } // date, null
		public double? LimitMoney { get; set; } // float, null
		public DateTime? CreatedDate { get; set; } // date, null

		public async Task<List<OPKeySearch>> OPKeySearchDAO(string AdminKey, DateTime? DateSearch, double? MoneySearch, double? AmountUnit, bool? CheckAssiged, string Key, int? PageSize, int? PageIndex)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", AdminKey);
			DP.Add("DateSearch", DateSearch);
			DP.Add("MoneySearch", MoneySearch);
			DP.Add("AmountUnit", AmountUnit);
			DP.Add("CheckAssiged", CheckAssiged);
			DP.Add("Key", Key);
			DP.Add("PageSize", PageSize);
			DP.Add("PageIndex", PageIndex);

			return (await _sQLCon.ExecuteListDapperAsync<OPKeySearch>("OP_KeySearch", DP)).ToList();
		}
	}

	public class OPKeyUpdate
	{
		private SQLCon _sQLCon;

		public OPKeyUpdate(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPKeyUpdate()
		{
		}

		public async Task<int> OPKeyUpdateDAO(OPKeyUpdateIN _oPKeyUpdateIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", _oPKeyUpdateIN.AdminKey);
			DP.Add("Id", _oPKeyUpdateIN.Id);
			DP.Add("AmountUnit", _oPKeyUpdateIN.AmountUnit);
			DP.Add("Status", _oPKeyUpdateIN.Status);
			DP.Add("ExpireDate", _oPKeyUpdateIN.ExpireDate);
			DP.Add("LimitMoney", _oPKeyUpdateIN.LimitMoney);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("OP_KeyUpdate", DP));
		}
	}

	public class OPKeyUpdateIN
	{
		public string AdminKey { get; set; }
		public int? Id { get; set; }
		public double? AmountUnit { get; set; }
		public bool? Status { get; set; }
		public DateTime? ExpireDate { get; set; }
		public double? LimitMoney { get; set; }
	}

	public class OPUserGetByUserName
	{
		private SQLCon _sQLCon;

		public OPUserGetByUserName(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserGetByUserName()
		{
		}

		public int Id { get; set; } // int, not null
		public string UserName { get; set; } // nvarchar(256), null
		public string FirstName { get; set; } // nvarchar(256), null
		public string LastName { get; set; } // nvarchar(256), null
		public string Email { get; set; } // nvarchar(256), null

		public async Task<List<OPUserGetByUserName>> OPUserGetByUserNameDAO(string AdminKey, string UserName)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", AdminKey);
			DP.Add("UserName", UserName);

			return (await _sQLCon.ExecuteListDapperAsync<OPUserGetByUserName>("OP_UserGetByUserName", DP)).ToList();
		}
	}

	public class OPUserInsert
	{
		private SQLCon _sQLCon;

		public OPUserInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserInsert()
		{
		}

		public async Task<int> OPUserInsertDAO(OPUserInsertIN _oPUserInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", _oPUserInsertIN.AdminKey);
			DP.Add("UserName", _oPUserInsertIN.UserName);
			DP.Add("FirstName", _oPUserInsertIN.FirstName);
			DP.Add("LastName", _oPUserInsertIN.LastName);
			DP.Add("Email", _oPUserInsertIN.Email);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("OP_UserInsert", DP));
		}
	}

	public class OPUserInsertIN
	{
		public string AdminKey { get; set; }
		public string UserName { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string Email { get; set; }
	}

	public class OPUserKeyDelete
	{
		private SQLCon _sQLCon;

		public OPUserKeyDelete(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserKeyDelete()
		{
		}

		public async Task<int> OPUserKeyDeleteDAO(OPUserKeyDeleteIN _oPUserKeyDeleteIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", _oPUserKeyDeleteIN.AdminKey);
			DP.Add("KeyId", _oPUserKeyDeleteIN.KeyId);
			DP.Add("UserId", _oPUserKeyDeleteIN.UserId);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("OP_UserKeyDelete", DP));
		}
	}

	public class OPUserKeyDeleteIN
	{
		public string AdminKey { get; set; }
		public int? KeyId { get; set; }
		public int? UserId { get; set; }
	}

	public class OPUserKeyGetByKeyId
	{
		private SQLCon _sQLCon;

		public OPUserKeyGetByKeyId(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserKeyGetByKeyId()
		{
		}

		public int Id { get; set; } // int, not null
		public int UserId { get; set; } // int, not null
		public int KeyId { get; set; } // int, not null
		public bool? Status { get; set; } // bit, null

		public async Task<List<OPUserKeyGetByKeyId>> OPUserKeyGetByKeyIdDAO(string AdminKey, int? KeyId)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", AdminKey);
			DP.Add("KeyId", KeyId);

			return (await _sQLCon.ExecuteListDapperAsync<OPUserKeyGetByKeyId>("OP_UserKeyGetByKeyId", DP)).ToList();
		}
	}

	public class OPUserKeyGetByUserId
	{
		private SQLCon _sQLCon;

		public OPUserKeyGetByUserId(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserKeyGetByUserId()
		{
		}

		public int Id { get; set; } // int, not null
		public string Key { get; set; } // nvarchar(256), not null
		public bool Status { get; set; } // bit, not null
		public DateTime? ExpireDate { get; set; } // date, null
		public double? AmountUnit { get; set; } // float, null
		public double? LimitMoney { get; set; } // float, null
		public DateTime? CreatedDate { get; set; } // date, null

		public async Task<List<OPUserKeyGetByUserId>> OPUserKeyGetByUserIdDAO(string AdminKey, int? UserId)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", AdminKey);
			DP.Add("UserId", UserId);

			return (await _sQLCon.ExecuteListDapperAsync<OPUserKeyGetByUserId>("OP_UserKeyGetByUserId", DP)).ToList();
		}
	}

	public class OPUserKeyInsert
	{
		private SQLCon _sQLCon;

		public OPUserKeyInsert(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserKeyInsert()
		{
		}

		public async Task<int> OPUserKeyInsertDAO(OPUserKeyInsertIN _oPUserKeyInsertIN)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", _oPUserKeyInsertIN.AdminKey);
			DP.Add("UserId", _oPUserKeyInsertIN.UserId);
			DP.Add("KeyId", _oPUserKeyInsertIN.KeyId);
			DP.Add("Status", _oPUserKeyInsertIN.Status);

			return (await _sQLCon.ExecuteNonQueryDapperAsync("OP_UserKeyInsert", DP));
		}
	}

	public class OPUserKeyInsertIN
	{
		public string AdminKey { get; set; }
		public int? UserId { get; set; }
		public int? KeyId { get; set; }
		public bool? Status { get; set; }
	}

	public class OPUserSearch
	{
		private SQLCon _sQLCon;

		public OPUserSearch(IAppSetting appSetting)
		{
			_sQLCon = new SQLCon(appSetting.GetConnectstring());
		}

		public OPUserSearch()
		{
		}

		public int Id { get; set; } // int, not null
		public string UserName { get; set; } // nvarchar(256), null
		public string FirstName { get; set; } // nvarchar(256), null
		public string LastName { get; set; } // nvarchar(256), null
		public string Email { get; set; } // nvarchar(256), null

		public async Task<List<OPUserSearch>> OPUserSearchDAO(string AdminKey, string Search, int? PageSize, int? PageIndex)
		{
			DynamicParameters DP = new DynamicParameters();
			DP.Add("AdminKey", AdminKey);
			DP.Add("Search", Search);
			DP.Add("PageSize", PageSize);
			DP.Add("PageIndex", PageIndex);

			return (await _sQLCon.ExecuteListDapperAsync<OPUserSearch>("OP_UserSearch", DP)).ToList();
		}
	}
}
