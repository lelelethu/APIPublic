using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;
using Serilog;

namespace TXAPI
{
	public class Program
	{
		public static void Main(string[] args)
		{ 
			CreateHostBuilder(args).Build().Run();
			Log.Logger = new LoggerConfiguration()
			.WriteTo.File("log.txt", rollingInterval: RollingInterval.Day)
			.CreateLogger();
			Log.CloseAndFlush();
		}

		public static IHostBuilder CreateHostBuilder(string[] args) =>
			Host.CreateDefaultBuilder(args)
				.ConfigureWebHostDefaults(webBuilder =>
				{
					webBuilder.UseStartup<Startup>();
				});
	}
}
