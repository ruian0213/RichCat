using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Swashbuckle.AspNetCore.Swagger;
using Microsoft.OpenApi.Models;
using RichCat.Web.Utility;
using Microsoft.AspNetCore.ResponseCompression;
using System.IO.Compression;
using RichCat.Infrastructure;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.Debug;

namespace RichCat.Web
{
    /// <summary>
    /// Core 全部都是DI（依赖注入）实现
    /// </summary>
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //Need Install Swashbuckle.AspNetCore
            services.AddSwaggerGen(options =>
             {
                 //options.SwaggerDoc("v1", new OpenApiInfo() {
                 //    Version = "v1",
                 //    Title = "RichCat.Web",
                 //    Description = "RichCat.Web offer api for rich cat project. "
                 //});

                 typeof(ApiVersions).GetEnumNames().ToList().ForEach(version =>
                 {
                     options.SwaggerDoc(version, new OpenApiInfo()
                     {
                         Version = version,
                         Title = $"RichCat.Web {version}",
                         Description = $"RichCat.Web {version}offer api for rich cat project. "
                     });
                 });
             });


            // add response comression
            //use response compression.
            services.AddResponseCompression(options =>
            {
                //可以添加多种压缩类型，程序会根据级别自动获取最优方式
                options.Providers.Add<BrotliCompressionProvider>();
                options.Providers.Add<GzipCompressionProvider>();
                //添加自定义压缩策略
                //options.Providers.Add<MyCompressionProvider>();
                //针对指定的MimeType来使用压缩策略
                options.MimeTypes =
                    ResponseCompressionDefaults.MimeTypes.Concat(
                        new[] { "application/json" });
            });
            //针对不同的压缩类型，设置对应的压缩级别
            services.Configure<GzipCompressionProviderOptions>(options =>
            {
                //使用最快的方式进行压缩，单不一定是压缩效果最好的方式
                options.Level = CompressionLevel.Fastest;
                //不进行压缩操作
                //options.Level = CompressionLevel.NoCompression;
                //即使需要耗费很长的时间，也要使用压缩效果最好的方式
                //options.Level = CompressionLevel.Optimal;
            });

            //register Action Filter service:
            services.AddScoped<CustomActionFilterAttribute>();

            //支持跨域访问
            //Need Install Microsoft.AspNetCore.Cors
            services.AddCors(option => option.AddPolicy("AllowCors", _build => _build.AllowAnyOrigin().AllowAnyMethod())) ;

            services.AddControllers()
                .AddNewtonsoftJson();//Need Install Microsoft.AspNetCore.Mvc.NewtonsoftJson to fix chinese display issue.

            services.AddDbContext<RichCatContext>(options =>
            {

                LoggerFactory loggerFactory = new LoggerFactory(new[] { new Log4NetProvider(".\\ConfigFile\\log4net.config") });
                options
                //.UseLazyLoadingProxies() //使用延时加载，一般不这样使用
                .UseLoggerFactory(loggerFactory) //为 context 上下文打印执行的SQL脚本
                .UseSqlServer(Configuration.GetConnectionString("RichCatConn"));//链接数据库
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseResponseCompression();

            app.UseSwagger();
            app.UseSwaggerUI(c=> {
                //c.SwaggerEndpoint($"/swagger/v1/swagger.json", "v1");

                //use group name to flag different apis.
                //need to set atribute for controllers like this: [ApiExplorerSettings(GroupName = "v2")]
                typeof(ApiVersions).GetEnumNames().ToList().ForEach(version =>
                {
                    c.SwaggerEndpoint($"/swagger/{version}/swagger.json", version);
                });
            });

          

            app.UseCors("AllowCors");

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
