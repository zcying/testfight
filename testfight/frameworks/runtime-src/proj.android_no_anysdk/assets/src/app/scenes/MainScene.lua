
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local Game=import("app.models.Game")

function MainScene:ctor()
    self._game=Game.new()
        :addTo(self)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
