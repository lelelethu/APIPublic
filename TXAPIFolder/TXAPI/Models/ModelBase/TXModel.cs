using System;

namespace TXAPI.Models.ModelBase
{
	public class KeyInsertModel
	{
		public string AdminKey { get; set; }
		public DateTime? ExpireDate { get; set; }
		public double? LimitMoney { get; set; }
	}
}
