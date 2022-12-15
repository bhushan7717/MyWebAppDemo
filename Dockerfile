FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base

WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /src

COPY ["MyWebAppDemo.csproj", "MyWebAppDemo/"]

RUN dotnet restore "MyWebAppDemo/MyWebAppDemo.csproj"

COPY . .

WORKDIR "/src/MyWebAppDemo"
RUN dotnet build "MyWebAppDemo.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MyWebAppDemo.csproj" -c Release -o /app/publish

FROM base as final
WORKDIR /app

COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet" , "MyWebAppDemo.dll"]


