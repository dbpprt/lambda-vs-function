using System.IO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Azure.WebJobs.Host;

namespace AzureFunction
{
    public static class Function
    {
        [FunctionName("AzureFunction")]
        public static IActionResult Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = null)]HttpRequest req, TraceWriter log)
        {
            using (var streamReader = new StreamReader(req.Body))
            {
                var requestBody = streamReader.ReadToEnd();

                return (ActionResult)new OkObjectResult(new
                {
                    Body = requestBody
                });
            }
        }
    }
}
