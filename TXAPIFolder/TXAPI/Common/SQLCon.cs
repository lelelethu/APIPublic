using Dapper;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace TXAPI.Common
{
	public class SQLCon
	{
		private static string _connectString;

		public SQLCon(string connectString)
		{
			_connectString = connectString;
		}

		public SQLCon()
		{
		}

		public static SqlConnection GetConnection()
		{
			return new SqlConnection(_connectString);
		}

		#region Static functions

		public static int ExecuteNonQueryStringStatic(string sqlText, SqlParameter[] param = null)
		{
			if (param == null)
			{
				param = new SqlParameter[] { };
			}

			using (SqlConnection conn = GetConnection())
			{
				using (SqlCommand cmd = new SqlCommand(sqlText, conn))
				{
					cmd.CommandType = CommandType.Text;
					cmd.Parameters.AddRange(param);

					conn.Open();
					return cmd.ExecuteNonQuery();
				}
			}
		}

		public static DataTable ExecuteDataTableStatic(string commandText, SqlParameter[] param, CommandType cmdType = CommandType.StoredProcedure)
		{
			DataTable dt = new DataTable();

			using (SqlConnection conn = GetConnection())
			using (SqlCommand cmd = new SqlCommand(commandText, conn))
			using (SqlDataAdapter da = new SqlDataAdapter(cmd))
			{
				cmd.CommandType = cmdType;
				cmd.Parameters.AddRange(param);

				conn.Open();
				da.Fill(dt);
				return dt;
			}
		}

		public static IEnumerable<T> ExecuteListDapperStatic<T>(string commandText, DynamicParameters DP, CommandType cmdType = CommandType.StoredProcedure)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				IEnumerable<T> result = conn.Query<T>(commandText, DP, commandType: cmdType);
				return result;
			}
		}

		public static IEnumerable<T> ExecuteListDapperStaticText<T>(string commandText, DynamicParameters DP, CommandType cmdType = CommandType.Text)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return conn.Query<T>(commandText, DP, commandType: cmdType);
			}
		}

		#endregion Static Functions

		public T ExecuteScalar<T>(string sqlText, params SqlParameter[] param)
		{
			using (SqlConnection conn = GetConnection())
			using (SqlCommand cmd = new SqlCommand(sqlText, conn))
			{
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.AddRange(param);

				conn.Open();
				return (T)cmd.ExecuteScalar();
			}
		}

		public int ExecuteNonQuery(string sqlText, params SqlParameter[] param)
		{
			using (SqlConnection conn = GetConnection())
			using (SqlCommand cmd = new SqlCommand(sqlText, conn))
			{
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.AddRange(param);
				cmd.CommandTimeout = 6000;
				conn.Open();
				return cmd.ExecuteNonQuery();
			}
		}

		public void ExecuteNonQueryProc(string ProcedureName, params SqlParameter[] param)
		{
			using (SqlConnection conn = GetConnection())
			using (SqlCommand cmd = new SqlCommand(ProcedureName, conn))
			{
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.AddRange(param);
				cmd.CommandTimeout = 6000;
				conn.Open();
				cmd.ExecuteNonQuery();
			}
		}

		public DataTable ExecuteDataTable(string ProcedureName, SqlParameter[] param)
		{
			DataTable dt = new DataTable();

			using (SqlConnection conn = GetConnection())
			using (SqlCommand cmd = new SqlCommand(ProcedureName, conn))
			using (SqlDataAdapter da = new SqlDataAdapter(cmd))
			{
				cmd.CommandType = CommandType.StoredProcedure;
				cmd.Parameters.AddRange(param);

				conn.Open();
				da.Fill(dt);
				return dt;
			}
		}

		public DataTable ExecuteDataTableText(string query, params SqlParameter[] param)
		{
			DataTable dt = new DataTable();

			using (SqlConnection conn = GetConnection())
			using (SqlCommand cmd = new SqlCommand(query, conn))
			using (SqlDataAdapter da = new SqlDataAdapter(cmd))
			{
				cmd.CommandType = CommandType.Text;
				cmd.Parameters.AddRange(param);

				conn.Open();
				da.Fill(dt);
				return dt;
			}
		}

		public int ExecuteNonQueryDapper(string ProcedureName, DynamicParameters DP)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return conn.Execute(ProcedureName, DP, commandTimeout: 6000, commandType: CommandType.StoredProcedure);
			}
		}

		public async Task<int> ExecuteNonQueryDapperAsync(string ProcedureName, DynamicParameters DP)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return await conn.ExecuteAsync(ProcedureName, DP, commandType: CommandType.StoredProcedure, commandTimeout: 6000);
			}
		}

		public T ExecuteScalarDapper<T>(string ProcedureName, DynamicParameters DP)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return (T)conn.ExecuteScalar(ProcedureName, DP, commandType: CommandType.StoredProcedure);
			}
		}

		public async Task<T> ExecuteScalarDapperAsync<T>(string ProcedureName, DynamicParameters DP)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return (T)await conn.ExecuteScalarAsync(ProcedureName, DP, commandType: CommandType.StoredProcedure);
			}
		}

		public T ExecuteScalarDapper<T>(string query)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return (T)conn.ExecuteScalar(query, commandType: CommandType.Text);
			}
		}

		public IEnumerable<T> ExecuteListDapper<T>(string ProcedureName, DynamicParameters DP)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return conn.Query<T>(ProcedureName, DP, commandType: CommandType.StoredProcedure, commandTimeout: 6000);
			}
		}

		public async Task<IEnumerable<T>> ExecuteListDapperAsync<T>(string ProcedureName, DynamicParameters DP)
		{
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return await conn.QueryAsync<T>(ProcedureName, DP, commandType: CommandType.StoredProcedure, commandTimeout: 6000);
			}
		}

		public IEnumerable<T> ExecuteListDapperText<T>(string query, DynamicParameters DP = null)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return conn.Query<T>(query, DP, commandType: CommandType.Text);
			}
		}

		public async Task<IEnumerable<T>> ExecuteListDapperTextAsync<T>(string query, DynamicParameters DP = null)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();
				return await conn.QueryAsync<T>(query, DP, commandType: CommandType.Text);
			}
		}

		public T ExecuteDapper<T>(string query, DynamicParameters DP = null)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				List<T> list = conn.Query<T>(query, DP, commandType: CommandType.Text).ToList();

				return list.Count > 0 ? list[0] : default(T);
			}
		}

		public async Task<T> ExecuteDapperAsync<T>(string query, DynamicParameters DP = null)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				List<T> list = (await conn.QueryAsync<T>(query, DP, commandType: CommandType.Text)).ToList();

				return list.Count > 0 ? list[0] : default(T);
			}
		}

		public T GetFirstOrDefaultEntityDapper<T>(string ProcedureName, DynamicParameters DP)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				List<T> list = conn.Query<T>(ProcedureName, DP, commandType: CommandType.StoredProcedure).ToList();

				return list.Count > 0 ? list[0] : default(T);
			}
		}

		public async Task<T> GetFirstOrDefaultEntityDapperAsync<T>(string ProcedureName, DynamicParameters DP)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				List<T> list = (await conn.QueryAsync<T>(ProcedureName, DP, commandType: CommandType.StoredProcedure)).ToList();

				return list.Count > 0 ? list[0] : default(T);
			}
		}

		public async Task<T> GetFirstOrDefaultEntityDapperTextAsync<T>(string query, DynamicParameters DP) where T : new()
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				List<T> list = (await conn.QueryAsync<T>(query, DP, commandType: CommandType.Text)).ToList();

				return list.Count > 0 ? list[0] : new T();
			}
		}

		public async Task<T> GetFirstOrDefaultEntityIsolationDapperAsync<T>(string ProcedureName, DynamicParameters DP)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				List<T> list = (await conn.QueryAsync<T>(ProcedureName, DP, commandType: CommandType.StoredProcedure)).ToList();

				return list.Count > 0 ? list[0] : default(T);
			}
		}

		public async Task<SqlMapper.GridReader> GetQueryMultipleAsync(string ProcedureName, DynamicParameters DP)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				SqlMapper.GridReader grid = (await conn.QueryMultipleAsync(ProcedureName, DP, commandType: CommandType.StoredProcedure));

				return grid;
			}
		}
		public async Task<IDictionary<string, object>> GetQueryMultipleAsyncTwo<TFirst, TSecond>(string ProcedureName, DynamicParameters DP)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				SqlMapper.GridReader grid = (await conn.QueryMultipleAsync(ProcedureName, DP, commandType: CommandType.StoredProcedure, commandTimeout: 6000));
				var l1 = grid.Read<TFirst>().ToList();
				var l2 = grid.Read<TSecond>().ToList();
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"List1", l1},
						{"List2", l2},
					};
				return json;
			}
		}

		public async Task<IDictionary<string, object>> GetQueryMultipleAsyncThree<TFirst, TSecond, TThird>(string ProcedureName, DynamicParameters DP)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				SqlMapper.GridReader grid = (await conn.QueryMultipleAsync(ProcedureName, DP, commandType: CommandType.StoredProcedure, commandTimeout: 6000));
				var l1 = grid.Read<TFirst>().ToList();
				var l2 = grid.Read<TSecond>().ToList();
				var l3= grid.Read<TThird>().ToList();
				IDictionary<string, object> json = new Dictionary<string, object>
					{
						{"List1", l1},
						{"List2", l2},
						{"List3", l3},
					};
				return json;
			}

		}
		public async Task<IEnumerable<TReturn>> GetListThreeType<TFirst, TSecond, TThird, TReturn>(string proc, System.Func<TFirst, TSecond, TThird, TReturn> map, string splitOn, DynamicParameters DP = null)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}

			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				IEnumerable<TReturn> result = await conn.QueryAsync<TFirst, TSecond, TThird, TReturn>(proc, map, DP, splitOn: splitOn, commandType: CommandType.StoredProcedure);

				return result;
			}
		}

		public async Task<IEnumerable<TReturn>> GetListFourType<TFirst, TSecond, TThird, TFourth, TReturn>(string proc, System.Func<TFirst, TSecond, TThird, TFourth, TReturn> map, string splitOn, DynamicParameters DP = null)
		{
			if (DP == null)
			{
				DP = new DynamicParameters();
			}
			using (SqlConnection conn = GetConnection())
			{
				conn.Open();

				IEnumerable<TReturn> result = await conn.QueryAsync<TFirst, TSecond, TThird, TFourth, TReturn>(proc, map, DP, splitOn: splitOn, commandType: CommandType.StoredProcedure);

				return result;
			}
		}

		//public async Task<T> GetListQueryGroupDapperAsync<T>(string query, DynamicParameters DP, List<T> list, T object2) where T : new()
		//{
		//	//List<object1> sYFunction1s = new List<object1>();
		//	using (SqlConnection conn = GetConnection())
		//	{
		//		conn.Open();

		//		(await conn.QueryAsync<T, T, T>(query, (sYFunction1, sYFunctionAction1) =>
		//		{
		//			var _sYFunction1 = list.Find(item => item.Id == sYFunction1.Id);
		//			if (_sYFunction1 == null) { list.Add(sYFunction1); _sYFunction1 = sYFunction1; }
		//			_sYFunction1.sYFunctionAction1s = _sYFunction1.sYFunctionAction1s ?? new List<T>();
		//			if (sYFunctionAction1 != null)
		//				_sYFunction1.sYFunctionAction1s.Add(sYFunctionAction1);
		//			return _sYFunction1;
		//		})).ToList();
		//	}
		//}
	}
}