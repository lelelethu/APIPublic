using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;

namespace TXAPI.Hub
{
	[Route("api/GHeroHub")]
	public class GHeroHub : Hub<IHubClient>
	{
		public GHeroHub()
		{
		}
		public async Task ReCalculateReportYearMessage(string objValue)
		{
			await Clients.All.ReCalculateReportYearMessage(objValue);
		}
		public async Task OpenQRCode(string objValue)
		{
			await Clients.All.OpenQRCode(objValue);
		}
	}

	public interface IHubClient
	{
		Task ReCalculateReportYearMessage(string objValue);
		Task OpenQRCode(string objValue);
	}
}
