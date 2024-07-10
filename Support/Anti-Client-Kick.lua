local namecall
namecall = hookmetamethod(game, "__namecall", function(self, ...)
	  if self == game.Players.LocalPlayer and getnamecallmethod():lower() == "kick" then
		    return nil
		end
	  return namecall(self, ...)
end)
