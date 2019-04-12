using Amazon.Lambda.Core;
using Amazon.Lambda.RuntimeSupport;
using System;
using System.Collections.Generic;
using System.Net;
using System.Threading.Tasks;
using Amazon.Lambda.APIGatewayEvents;
using Newtonsoft.Json;

using JsonSerializer = Amazon.Lambda.Serialization.Json.JsonSerializer;

namespace LambdaCustomRuntimeFunction
{
    public class Function
    {
        private static readonly JsonSerializer JsonSerializer = new JsonSerializer();

        private static async Task Main(string[] args)
        {
            Func<APIGatewayProxyRequest, ILambdaContext, APIGatewayProxyResponse> func = Handler;

            using (var handlerWrapper = HandlerWrapper.GetHandlerWrapper(func, JsonSerializer))
            using (var bootstrap = new LambdaBootstrap(handlerWrapper))
            {
                await bootstrap.RunAsync();
            }
        }

        private static APIGatewayProxyResponse Handler(APIGatewayProxyRequest input, ILambdaContext context)
        {
            var response = new APIGatewayProxyResponse
            {
                StatusCode = (int)HttpStatusCode.OK,
                Body = JsonConvert.SerializeObject(new
                {
                    input.Body
                }),
                Headers = new Dictionary<string, string> { { "Content-Type", "application/json" } }
            };

            return response;
        }
    }
}
