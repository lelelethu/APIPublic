using Microsoft.Extensions.Configuration;

namespace TXAPI.Common
{
	public class ConnectString
	{
		public string Default;
	}

	public interface IAppSetting
	{
		public string GetConnectstring();
	}

	public class AppSetting : IAppSetting
	{
		private readonly IConfiguration Configuration;

		public AppSetting(IConfiguration configuration)
		{
			Configuration = configuration;
		}

		public string GetConnectstring()
		{
			return Configuration["ConnectionStrings:Default"];
		}
	}
}
