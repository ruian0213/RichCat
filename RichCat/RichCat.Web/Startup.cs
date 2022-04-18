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
    /// Core ȫ������DI������ע�룩ʵ��
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
                //������Ӷ���ѹ�����ͣ��������ݼ����Զ���ȡ���ŷ�ʽ
                options.Providers.Add<BrotliCompressionProvider>();
                options.Providers.Add<GzipCompressionProvider>();
                //����Զ���ѹ������
                //options.Providers.Add<MyCompressionProvider>();
                //���ָ����MimeType��ʹ��ѹ������
                options.MimeTypes =
                    ResponseCompressionDefaults.MimeTypes.Concat(
                        new[] { "application/json" });
            });
            //��Բ�ͬ��ѹ�����ͣ����ö�Ӧ��ѹ������
            services.Configure<GzipCompressionProviderOptions>(options =>
            {
                //ʹ�����ķ�ʽ����ѹ��������һ����ѹ��Ч����õķ�ʽ
                options.Level = CompressionLevel.Fastest;
                //������ѹ������
                //options.Level = CompressionLevel.NoCompression;
                //��ʹ��Ҫ�ķѺܳ���ʱ�䣬ҲҪʹ��ѹ��Ч����õķ�ʽ
                //options.Level = CompressionLevel.Optimal;
            });

            //register Action Filter service:
            services.AddScoped<CustomActionFilterAttribute>();

            //֧�ֿ������
            //Need Install Microsoft.AspNetCore.Cors
            services.AddCors(option => option.AddPolicy("AllowCors", _build => _build.AllowAnyOrigin().AllowAnyMethod())) ;

            services.AddControllers()
                .AddNewtonsoftJson();//Need Install Microsoft.AspNetCore.Mvc.NewtonsoftJson to fix chinese display issue.

            services.AddDbContext<RichCatContext>(options =>
            {

                LoggerFactory loggerFactory = new LoggerFactory(new[] { new Log4NetProvider(".\\ConfigFile\\log4net.config") });
                options
                //.UseLazyLoadingProxies() //ʹ����ʱ���أ�һ�㲻����ʹ��
                .UseLoggerFactory(loggerFactory) //Ϊ context �����Ĵ�ӡִ�е�SQL�ű�
                .UseSqlServer(Configuration.GetConnectionString("RichCatConn"));//�������ݿ�
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
