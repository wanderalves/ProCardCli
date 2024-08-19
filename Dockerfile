FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ProCardCli.API/ProCardCli.API.csproj", "ProCardCli.API/"]
RUN dotnet restore "ProCardCli.API/ProCardCli.API.csproj"
COPY . .
WORKDIR "/src/ProCardCli.API"
RUN dotnet build "ProCardCli.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ProCardCli.API.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ProCardCli.API.dll"]
