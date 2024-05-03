using Newtonsoft.Json;
using System;
using TXAPI.Controllers;

namespace TXAPI.Models
{
	public class GetTokenInputLog
	{
		public DateTime DatetimeAction { get; set; }
		public GetTokenInput GetTokenInput { get; set; }
	}

	public class SelUserKeyScriptWILLBETLog
	{
		public DateTime DatetimeAction { get; set; }
		public string Key { get; set; }
		public int UserId { get; set; }
		public string UniqueDeviceId { get; set; }
		public SelUserKeyScriptWILLBETInput SelUserKeyScriptWILLBETInput { get; set; }
	}

	public class SelUserKeyScriptWILLBETInput
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
	}

	public class SelUserKeyScriptWILLBET8Input
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
	}

	public class SelUserKeyScriptWILLBET8Log
	{
		public DateTime DatetimeAction { get; set; }
		public string Key { get; set; }
		public int UserId { get; set; }
		public string UniqueDeviceId { get; set; }
		public SelUserKeyScriptWILLBET8Input SelUserKeyScriptWILLBET8Input { get; set; }
	}

	public class TradeHistoryInsertLog
	{
		public DateTime DatetimeAction { get; set; }
		public string Key { get; set; }
		public int UserId { get; set; }
		public string UniqueDeviceId { get; set; }
		public TradeHistoryInsertModel TradeHistoryInsertModel { get; set; }
	}

	public class UpdateHisByClientLog
	{
		public DateTime DatetimeAction { get; set; }
		public string Key { get; set; }
		public int UserId { get; set; }
		public string UniqueDeviceId { get; set; }
		public UpdateHisByClientModel UpdateHisByClientModel { get; set; }
	}

	public class ResetKeyUserLog
	{
		public DateTime DatetimeAction { get; set; }
		public string Key { get; set; }
		public int UserId { get; set; }
		public string UniqueDeviceId { get; set; }
		public ResetKeyUserModel ResetKeyUserModel { get; set; }
	}

	public class UploadScreenShotInput
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
	}

	public class UploadScreenShotLog
	{
		public DateTime DatetimeAction { get; set; }
		public string Key { get; set; }
		public int UserId { get; set; }
		public string UniqueDeviceId { get; set; }
		public UploadScreenShotInput UploadScreenShotInput { get; set; }
	}
}
