using Newtonsoft.Json;
using System;

namespace TXAPI.Models
{
    public class KeyInsertModel
    {
        public string AdminKey { get; set; }
        public DateTime? ExpireDate { get; set; }
        public double? LimitMoney { get; set; }
    }

    public class UserInsertModel
    {
        public string AdminKey { get; set; }
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
    }

    public class UserKeyInsertModel
    {
        public string AdminKey { get; set; }
        public int? UserId { get; set; }
        public int? KeyId { get; set; }
        public bool? Status { get; set; }
    }

	public class TradeHistoryInsertModel
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
		public string Bet { get; set; }
		public int? TaskId { get; set; }
		public int? ScreenId { get; set; }
		public double? BetAmount { get; set; }
		public bool? Result { get; set; }
		public bool? ResultClick { get; set; }
	}

	public class UpdateHisByClientModel
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public long? GameId { get; set; }
	}

	public class DeviceInfo
	{
		[JsonProperty("abis")]
		public string[] Abis { get; set; }

		[JsonProperty("android_id")]
		public string AndroidId { get; set; }

		[JsonProperty("app_id")]
		public string AppId { get; set; }

		[JsonProperty("app_name")]
		public string AppName { get; set; }

		[JsonProperty("app_version_code")]
		public string AppVersionCode { get; set; }

		[JsonProperty("app_version_name")]
		public string AppVersionName { get; set; }

		[JsonProperty("ip_address")]
		public string IpAddress { get; set; }

		[JsonProperty("is_development_setting")]
		public bool IsDevelopmentSetting { get; set; }

		[JsonProperty("is_device_rooted")]
		public bool IsDeviceRooted { get; set; }

		[JsonProperty("is_emulator")]
		public bool IsEmulator { get; set; }

		[JsonProperty("is_tablet")]
		public bool IsTablet { get; set; }

		[JsonProperty("language")]
		public string Language { get; set; }

		[JsonProperty("manufacturer")]
		public string Manufacturer { get; set; }

		[JsonProperty("model")]
		public string Model { get; set; }

		[JsonProperty("net_type")]
		public string NetType { get; set; }

		[JsonProperty("os_version")]
		public string OsVersion { get; set; }

		[JsonProperty("phone_brand")]
		public string PhoneBrand { get; set; }

		[JsonProperty("rom_info")]
		public RomInfo RomInfo { get; set; }

		[JsonProperty("screen_size")]
		public string ScreenSize { get; set; }

		[JsonProperty("sdk_version_code")]
		public int SdkVersionCode { get; set; }

		[JsonProperty("sdk_version_name")]
		public string SdkVersionName { get; set; }

		[JsonProperty("unique_device_id")]
		public string UniqueDeviceId { get; set; }
	}

	public class RomInfo
	{
		[JsonProperty("name")]
		public string Name { get; set; }

		[JsonProperty("version")]
		public string Version { get; set; }
	}

	public class ResetKeyUserModel
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
	}

	public class ApStopTradeSendNotiInput
	{
		public string WebName { get; set; }
		public string GameName { get; set; }
		public int? GameId { get; set; }
		public string Message { get; set; }
	}
}
