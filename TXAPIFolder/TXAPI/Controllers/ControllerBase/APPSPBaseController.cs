using TXAPI.Common;
using TXAPI.Controllers;
using TXAPI.Models;
using TXAPI.ModelBase;
using TXAPI.Models.Results;
using System;
using Dapper;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Net.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Newtonsoft.Json;

namespace TXAPI.ControllerBase
{
	[Route("api/APPSPBase")]
	[ApiController]
	public class APPSPBaseController : BaseApiController
	{
		private readonly IAppSetting _appSetting;

		public APPSPBaseController(IAppSetting appSetting)
		{
			_appSetting = appSetting;
		}
	}
}
