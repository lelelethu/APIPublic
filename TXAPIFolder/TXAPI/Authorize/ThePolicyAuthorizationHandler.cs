using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;
using TXAPI.Common;

namespace TXAPI.Authorize
{
	public class ThePolicyAuthorizationHandler : AuthorizationHandler<ThePolicyRequirement>
	{
		//readonly HttpActionContext _appContext;
		readonly IHttpContextAccessor _contextAccessor;
		private readonly IAppSetting _appSetting;

		public ThePolicyAuthorizationHandler(IHttpContextAccessor ca, IAppSetting appSetting)
		{
			//_appContext = c;
			_contextAccessor = ca;	
			_appSetting = appSetting;
		}

		protected override async Task HandleRequirementAsync(AuthorizationHandlerContext context, ThePolicyRequirement requirement)
		{
			//var result = await requirement.isPass(_contextAccessor, context);

			//check IsAuthorized
			var IsAuthenticated = context.User.Identity.IsAuthenticated;

			////string APIName = _contextAccessor.HttpContext.Request.Path;
			//string APIName = "";
			//Claim userId = context.User.Claims.FirstOrDefault(claim => claim.Type == "Id");
			//bool permission = false;
			//if (userId != null)
			//{
			//	//Insert to API table, only using for dev enviroment
			//	Endpoint endpoint = _contextAccessor.HttpContext.GetEndpoint();
			//	string str = endpoint?.Metadata.GetMetadata<Microsoft.AspNetCore.Routing.Patterns.RoutePattern>()?.RawText;
			//	if (endpoint is Microsoft.AspNetCore.Routing.RouteEndpoint routeEndpoint)
			//	{
			//		APIName = routeEndpoint.RoutePattern.RawText;
			//	}
			//	SYAPIInsertIN _sYAPIInsertIN = new SYAPIInsertIN { Name = APIName, Authorize = true };
			//	await new SYAPIInsert(_appSetting).SYAPIInsertDAO(_sYAPIInsertIN);

			//	//Check permission
			//	List<SYPermissionCheckByUserId> rsSYPermissionCheckByUserId = await new SYPermissionCheckByUserId(_appSetting).SYPermissionCheckByUserIdDAO(Int32.Parse(userId.Value.ToString()), APIName);

			//	if (rsSYPermissionCheckByUserId.Count > 0) permission = rsSYPermissionCheckByUserId[0].Permission > 0;
			//}
			context.Succeed(requirement);
			//if (IsAuthenticated && permission)
			//	context.Succeed(requirement);
			//else
			//	context.Fail();
		}
	}
}
