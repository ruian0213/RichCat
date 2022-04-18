using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace RichCat.Web.Utility
{
    public class CustomResourceFilterAttribute : Attribute, IResourceFilter
    {
        private ILogger<CustomActionFilterAttribute> _Logger = null;
        public CustomResourceFilterAttribute(ILogger<CustomActionFilterAttribute> logger)
        {
            _Logger = logger;
        }
        public void OnResourceExecuted(ResourceExecutedContext context)
        {
            _Logger.LogError("this is CustomResourceFilterAttribute.OnResourceExcuting.");
        }

        public void OnResourceExecuting(ResourceExecutingContext context)
        {
            _Logger.LogError("this is CustomResourceFilterAttribute.OnResourceExcuting.");
        }
    }
}
