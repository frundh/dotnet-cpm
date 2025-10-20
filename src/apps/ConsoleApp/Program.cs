using Microsoft.Extensions.Configuration;

var configuration = new ConfigurationBuilder()
    .AddJsonFile("appsettings.json", optional: true)
    .AddEnvironmentVariables()
    .Build();

Console.WriteLine("Console Application Starting...");
Console.WriteLine($"Environment: {Environment.GetEnvironmentVariable("DOTNET_ENVIRONMENT") ?? "Not set"}");
Console.WriteLine($"App Name: {configuration["AppSettings:ApplicationName"] ?? "Not configured"}");
Console.WriteLine($"Version: {configuration["AppSettings:Version"] ?? "Not configured"}");

await Task.Delay(1000);
Console.WriteLine("Application completed successfully.");