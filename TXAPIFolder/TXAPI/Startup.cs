using TXAPI.Authorize;
using TXAPI.Common;
using TXAPI.Hub;
using TXAPI.Middle;
using Bugsnag.AspNet.Core;
using IdentityServer4.AccessTokenValidation;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Mvc.Authorization;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using NSwag;
using NSwag.Generation.Processors.Security;
using Quartz;
using Quartz.Impl;
using Quartz.Spi;
using System.Linq;
using System.Text;
using TXAPI.Services.FileUpload;

namespace TXAPI
{
	public class Startup
	{
		public Startup(IConfiguration configuration)
		{
			Configuration = configuration;
		}

		public IConfiguration Configuration { get; }
		readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
		public void ConfigureServices(IServiceCollection services)
		{
			services.AddCors(options =>
			{
				options.AddPolicy(MyAllowSpecificOrigins,
				builder =>
				{
					builder.WithOrigins("https://localhost:44331", "https://thutool.com", "http://localhost:4200")
							.AllowAnyHeader()
							.AllowAnyMethod();
				});
			});
			services.AddMvc().AddNewtonsoftJson();
			services.AddControllers().AddNewtonsoftJson(options =>
			{
				options.SerializerSettings.MaxDepth = 64;  // or however deep you need
			});

			//services.AddMvc(options =>
			//{
			//	options.Filters.Add(new AuthorizeFilter("ThePolicy"));
			//});

			services.AddControllers().AddNewtonsoftJson(); ;
			//services.AddTransient<CustomMiddleware>();
			services.AddHttpContextAccessor();
			services.AddHttpClient();

			//Add Service
			services.AddTransient<IAppSetting, AppSetting>();
			services.AddSingleton<IFileService, FileService>();

			services.AddAuthentication(options =>
			{
				options.DefaultAuthenticateScheme = IdentityServerAuthenticationDefaults.AuthenticationScheme;
				options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
				options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
			})
			.AddJwtBearer(options =>
			{
				options.Audience = Configuration["Jwt:Issuer"];
				options.ClaimsIssuer = Configuration["Jwt:Issuer"];
				options.TokenValidationParameters = new TokenValidationParameters
				{
					ValidateIssuer = true,
					ValidateAudience = true,
					ValidateLifetime = true,
					ValidateIssuerSigningKey = true,
					ValidIssuer = Configuration["Jwt:Issuer"],
					ValidAudience = Configuration["Jwt:Issuer"],
					IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Configuration["Jwt:Key"]))
				};
			});

			services.AddAuthorization(options =>
			{
				var defaultAuthorizationPolicyBuilder = new AuthorizationPolicyBuilder(JwtBearerDefaults.AuthenticationScheme);
				defaultAuthorizationPolicyBuilder = defaultAuthorizationPolicyBuilder.RequireAuthenticatedUser();
				options.DefaultPolicy = defaultAuthorizationPolicyBuilder.Build();
				//options.AddPolicy("ThePolicy", policy => policy.Requirements.Add(new ThePolicyRequirement()));
			});
			//services.AddTransient<IAuthorizationHandler, ThePolicyAuthorizationHandler>();

			services.AddOpenApiDocument(document =>
			{
				document.AddSecurity("JWT", Enumerable.Empty<string>(), new OpenApiSecurityScheme
				{
					Type = OpenApiSecuritySchemeType.ApiKey,
					Name = "Authorization",
					In = OpenApiSecurityApiKeyLocation.Header,
					Description = "Type into the textbox: Bearer {your JWT token}."
				});

				document.OperationProcessors.Add(
					new AspNetCoreOperationSecurityScopeProcessor("JWT"));
				document.Title = "TX API";
			});
			// If using IIS:
			services.Configure<IISServerOptions>(options =>
			{
				options.AllowSynchronousIO = true;
				options.MaxRequestBodySize = int.MaxValue;
			});

			services.Configure<FormOptions>(o =>  // currently all set to max, configure it to your needs!
			{
				o.ValueLengthLimit = int.MaxValue;
				o.MultipartBodyLengthLimit = long.MaxValue; // <-- !!! long.MaxValue
				o.MultipartBoundaryLengthLimit = int.MaxValue;
				o.MultipartHeadersCountLimit = int.MaxValue;
				o.MultipartHeadersLengthLimit = int.MaxValue;
				o.MemoryBufferThreshold = int.MaxValue;
			});

			services.AddBugsnag(configuration =>
			{
				configuration.ApiKey = Configuration["BugsnapId"];
			});

			//// Add our job
			//services.AddSingleton<ISSOService, SSOService>();
			////services.AddSingleton<IUserJobService, UserJobService>();
			//services.AddSingleton<IRoleJobService, RoleJobService>();
			//services.AddSingleton<IRoleGroupJobService, RoleGroupJobService>();
			//services.AddSingleton<IUserRoleJobService, UserRoleJobService>();
			//services.AddSingleton<IUpdateRestaurantJobStatusJobService, UpdateRestaurantJobStatusJobService>();
			////services.AddSingleton<IRoleManageJobService, RoleManageJobService>(); //bỏ
			//services.AddSingleton<IRoleLevelJobService, RoleLevelJobService>();
			//services.AddSingleton<IRoleNotAvailableJobService, RoleNotAvailableJobService>();
			//services.AddSingleton<IRoleUserNotAvailableJobService, RoleUserNotAvailableJobService>();
			////services.AddSingleton<IRestaurantCreateSSOJobService, RestaurantCreateSSOJobService>();//bỏ
			//services.AddSingleton<IRestaurantRacingJobService, RestaurantRacingJobService>();
			//services.AddSingleton<IStafftRacingSJobService, StafftRacingSJobService>();

			// Add Quartz services
			services.AddSingleton<ISchedulerFactory, StdSchedulerFactory>();

			//services.AddSingleton<GHeroHub>();
			services.AddSignalR().AddJsonProtocol(options =>
			{
				options.PayloadSerializerOptions.PropertyNamingPolicy = null;
			});
			services.AddSignalR().AddHubOptions<GHeroHub>(options =>
			{
				options.EnableDetailedErrors = true;
			});
		}

		public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
		{
			//app.UseMvc();
			//////if (env.IsDevelopment())
			{
				app.UseDeveloperExceptionPage();
				//app.UseSwagger();
				//app.UseSwaggerUI(c =>
				//{
				//	c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
				//	c.RoutePrefix = string.Empty;
				//});
			}
			app.Use(async (context, next) =>
			{
				context.Features.Get<IHttpMaxRequestBodySizeFeature>().MaxRequestBodySize = null; // unlimited I guess
				await next.Invoke();
			});
			//app.UseMiddleware<CustomMiddleware>();

			app.UseCorsMiddleware();
			app.UseCors(MyAllowSpecificOrigins);

			app.UseOpenApi();
			app.UseSwaggerUi3();
			//app.UseHttpsRedirection();
			app.UseRouting();
			app.UseCors("AnotherPolicy");
			app.UseAuthorization();
			app.UseEndpoints(endpoints =>
			{
				endpoints.MapHub<GHeroHub>("/api/Gherohub");
				endpoints.MapControllers();
			});
		}
	}
}
