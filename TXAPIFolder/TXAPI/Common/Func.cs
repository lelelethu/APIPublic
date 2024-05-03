using Newtonsoft.Json.Linq;
using System;
using System.Data;

namespace TXAPI.Common
{
	public static class Func
	{
		public static int GetQuarter(DateTime date)
		{
			if (date.Month >= 4 && date.Month <= 6)
				return 2;
			else if (date.Month >= 7 && date.Month <= 9)
				return 3;
			else if (date.Month >= 10 && date.Month <= 12)
				return 4;
			else
				return 1;
		}

		public static DataTable JsonToDataTable(JObject jsonObject)
		{
			DataTable dataTable = new DataTable();

			// Tạo các cột trong DataTable dựa trên các thuộc tính của đối tượng JSON
			foreach (var property in jsonObject.Properties())
			{
				dataTable.Columns.Add(property.Name, typeof(string)); // Đổi kiểu dữ liệu tương ứng nếu cần
			}

			// Thêm một dòng vào DataTable
			DataRow row = dataTable.NewRow();
			foreach (var property in jsonObject.Properties())
			{
				row[property.Name] = property.Value.ToString(); // Đổi kiểu dữ liệu tương ứng nếu cần
			}
			dataTable.Rows.Add(row);

			return dataTable;
		}
	}
}