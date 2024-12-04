# Use the official .NET SDK 8.0 image for building the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files to the container
COPY . ./
# test test
# Restore dependencies
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o out

# Use the lightweight .NET 8.0 runtime image for running the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set the working directory inside the container
WORKDIR /app

# Copy the built application from the build stage
COPY --from=build /app/out .

# Expose the port the application listens on
EXPOSE 80

# Set the entry point for the application

ENTRYPOINT ["dotnet", "WebApplication1.dll"]
