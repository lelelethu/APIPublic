using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Configuration;
using Newtonsoft.Json;
using System;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace TXAPI.Common
{
	public static class FuncWeb
	{
		public static async Task<HttpResponseMessage> Post(string endPointURL, string tokenSSO, object values)
		{
			HttpClientHandler clientHandler = new HttpClientHandler
			{
				AutomaticDecompression = System.Net.DecompressionMethods.GZip | System.Net.DecompressionMethods.Deflate,
				ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
				SslProtocols = System.Security.Authentication.SslProtocols.Tls | System.Security.Authentication.SslProtocols.Tls11 | System.Security.Authentication.SslProtocols.Tls12,
				UseProxy = true,
				ClientCertificateOptions = ClientCertificateOption.Automatic,
			};
			HttpClient client = new HttpClient(clientHandler);
			client.DefaultRequestHeaders.Accept.Clear();
			client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
			client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", tokenSSO);

			var content = new StringContent(JsonConvert.SerializeObject(values), Encoding.UTF8, "application/json");

			return await client.PostAsync(endPointURL, content);
		}

		public static async Task<HttpResponseMessage> GetAsync(string endPointURL, string tokenSSO)
		{
			HttpClientHandler clientHandler = new HttpClientHandler
			{
				AutomaticDecompression = System.Net.DecompressionMethods.GZip | System.Net.DecompressionMethods.Deflate,
				ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
				SslProtocols = System.Security.Authentication.SslProtocols.Tls | System.Security.Authentication.SslProtocols.Tls11 | System.Security.Authentication.SslProtocols.Tls12,
				UseProxy = true,
				ClientCertificateOptions = ClientCertificateOption.Automatic,
			};
			HttpClient client = new HttpClient(clientHandler);
			client.DefaultRequestHeaders.Accept.Clear();
			client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
			client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", tokenSSO);
			return await client.GetAsync(endPointURL);
			//return client.GetAsync(endPointURL).GetAwaiter().GetResult();
		}

		public static async Task<HttpResponseMessage> GetAsync(string endPointURL, string tokenAlias, string token)
		{
			HttpClientHandler clientHandler = new HttpClientHandler
			{
				AutomaticDecompression = System.Net.DecompressionMethods.GZip | System.Net.DecompressionMethods.Deflate,
				ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator,
				SslProtocols = System.Security.Authentication.SslProtocols.Tls | System.Security.Authentication.SslProtocols.Tls11 | System.Security.Authentication.SslProtocols.Tls12,
				UseProxy = true,
				ClientCertificateOptions = ClientCertificateOption.Automatic,
			};
			HttpClient client = new HttpClient(clientHandler);
			client.DefaultRequestHeaders.Accept.Clear();
			client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
			//client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue(tokenAlias, token);
			if (!string.IsNullOrEmpty(tokenAlias)) client.DefaultRequestHeaders.Add(tokenAlias, token);

			return await client.GetAsync(endPointURL);
			//return client.GetAsync(endPointURL).GetAwaiter().GetResult();
		}

		public static string GetUrlChunk(int Id)
		{
			return WebEncoders.Base64UrlEncode(BitConverter.GetBytes(Id)).ToLowerInvariant();
		}

		public static async Task SendNoti(string message, IConfiguration config)
		{
			string bot_api_key = config["BotApiKey"];
			string chatId = config["ChatId"];
			message = $"{DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss")} : ☮ {message} ☮";

			string urlString = $"https://api.telegram.org/bot{bot_api_key}/sendMessage?chat_id={chatId}&text={message}";

			HttpResponseMessage response = await FuncWeb.GetAsync(urlString, null, null);
		}
	}
}