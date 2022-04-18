using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace RichCat.Web.Utility
{
    public class CustomActionFilterAttribute : Attribute, IActionFilter
    {

        private ILogger<CustomActionFilterAttribute> _Logger = null;
        public CustomActionFilterAttribute(ILogger<CustomActionFilterAttribute> logger)
        {
            _Logger = logger;
        }
        public void OnActionExecuted(ActionExecutedContext context)
        {
            var result = context.Result;
            ObjectResult objResult = result as ObjectResult;
            var actionLog = $"[{DateTime.Now.ToString("yyy-MM-dd hh:mm:ss")}]  action  {context.RouteData.Values["action"]}  excuted, result: " +
                $"{(objResult == null ? string.Empty:JsonConvert.SerializeObject(objResult.Value))}";
            _Logger.LogDebug(actionLog);
        }

        public void OnActionExecuting(ActionExecutingContext context)
        {
            var actionLog = $"[{DateTime.Now.ToString("yyy-MM-dd hh:mm:ss")}]  action  {context.RouteData.Values["action"]}  excutting, parameters: {JsonConvert.SerializeObject(context.ActionArguments)}";
            _Logger.LogDebug(actionLog);
        }
    }
}
