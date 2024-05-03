using Microsoft.Extensions.Configuration;
using System;
using System.Net;
using System.Net.Mail;
using System.Text;

namespace TXAPI.Common
{
	public class SendMail
	{
		private readonly IConfiguration _configuration;
		public SendMail(IConfiguration configuration)
		{
			_configuration = configuration;
		}

		public void Send(string from, string[] to_list, string[] cc_list, string[] bcc_list, string subject, string body, string[] cc_email_config_list = null)
		{
			try
			{
				if (!string.IsNullOrEmpty(body))
				{
					MailMessage msg = new MailMessage();
					msg.IsBodyHtml = true;
					msg.Body = body;
					msg.Subject = subject;
					msg.BodyEncoding = Encoding.UTF8;
					msg.Priority = MailPriority.Normal;
					if (to_list != null)
						foreach (string to in to_list)
						{
							if (!string.IsNullOrEmpty(to))
								msg.To.Add(new MailAddress(to));
						}
					if (cc_list != null)
						foreach (string cc in cc_list)
						{
							if (!string.IsNullOrEmpty(cc))
								msg.CC.Add(new MailAddress(cc));
						}
					if (bcc_list != null)
						foreach (string bcc in bcc_list)
						{
							if (!string.IsNullOrEmpty(bcc))
								msg.Bcc.Add(new MailAddress(bcc));
						}
					if (cc_email_config_list != null)
						foreach (string cc in cc_email_config_list)
						{
							if (!string.IsNullOrEmpty(cc))
								msg.CC.Add(new MailAddress(cc));
						}

					msg.From = new MailAddress(from != null ? from : _configuration["fromEmail"]);
					var client = new SmtpClient()
					{
						Host = _configuration["sendMailHost"],
						UseDefaultCredentials = false,
						Credentials = new NetworkCredential(_configuration["fromEmail"], _configuration["fromEmailPw"]),
						Port = Convert.ToInt32(_configuration["sendMailPort"]),
						EnableSsl = true
					};
					client.Send(msg);
				}

			}
			catch (Exception ex)
			{
				var error = ex.Message;
			}

		}
	}
}
