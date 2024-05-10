RegisterCommand("getweather", function(source, args, rawCommand)
	local currentWeather = GetConvar("weather", "unknown")
	print(currentWeather)
end, false)
