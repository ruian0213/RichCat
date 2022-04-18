using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using RichCat.Web.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Caching.Memory;
using RichCat.Infrastructure;
using RichCat.Domain;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace RichCat.Web.Controllers
{



    [TypeFilter(typeof( CustomResourceFilterAttribute))]
    //[TypeFilter(typeof(CustomActionFilterAttribute))]
    [ServiceFilter(typeof(CustomActionFilterAttribute))]
    [Route("api/[controller]")]
    [ApiExplorerSettings(GroupName = "v1")]
    [ApiController]
    public class AgentsController : ControllerBase
    {

        private readonly ILogger<AgentsController> _logger;
        private IConfiguration _iConfiguration = null;
        //private IMemoryCache _memoryCache = null;

        private readonly RichCatContext _context;

        public AgentsController(ILogger<AgentsController> logger,
            IConfiguration iConfiguration,
            //IMemoryCache memoryCache,
            RichCatContext context)
        {
            _logger = logger;
            _iConfiguration = iConfiguration;
            //_memoryCache = memoryCache;
            _context = context;

            //_context.Database.EnsureDeleted();
            //_context.Database.EnsureCreated();
        }

       // GET: api/<AgentsController>
       [HttpGet]
       //[AllowAnonymous] //use for skip atrribute.
        public IEnumerable<User> Get()
        {
            _logger.LogInformation("execute get USERSs...");


            //var users  = _context.Users.ToList();
            //foreach (var user in users)
            //{
            //    Console.WriteLine(user.Department.Name); 
            //}



           return _context.Users.Include(u=>u.Department).Include(u=>u.UserRole).ToList();
           // return new string[] { "value1", "value2" };
        }

        //// GET api/<AgentsController>/5
        //[HttpGet("{id}")]
        //public string Get(int id)
        //{
        //    return "value";
        //}

        // POST api/<AgentsController>
        [HttpPost]
        public void Post([FromBody] User user)
        {
            _context.Users.Add(user);
            _context.SaveChanges();
        }

        //// PUT api/<AgentsController>/5
        //[HttpPut("{id}")]
        //public void Put(int id, [FromBody] string value)
        //{
        //}

        //// DELETE api/<AgentsController>/5
        //[HttpDelete("{id}")]
        //public void Delete(int id)
        //{
        //}
    }
}
