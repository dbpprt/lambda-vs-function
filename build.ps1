
# lets do some cleanup and restore all packages first
rm -Path ./dist -ErrorAction SilentlyContinue -r -Confirm:$false | Out-Null
dotnet clean
dotnet restore

# building aws lambda
dotnet lambda package -pl ./aws/ -o ./dist/aws.zip

# building azure function
dotnet publish -c Release ./azure/AzureFunction.csproj -o ./../dist/azure/
Compress-Archive -Path ./dist/azure/* -DestinationPath ./dist/azure.zip
# rm -Path ./dist/azure/ -ErrorAction SilentlyContinue -r -Confirm:$false | Out-Null