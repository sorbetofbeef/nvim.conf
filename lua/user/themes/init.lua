local setup = function()
	require("user.themes." .. os.getenv("DARK_THEME")).setup(os.getenv("DARK_VARIANT"))
end

if os.getenv("DARK_THEME") == "nord" then
  return
else
  setup()
end


