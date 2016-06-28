--步兵
local SolderBase=import(".SolderBase")
local SolderInfantry = class("SolderInfantry",SolderBase)

function SolderInfantry:ctor()
    SolderInfantry.super.ctor(self)
    self.speed=200
    self.soldertype=SolderBase.SOLDER_TYPE_HORSE
end

function SolderInfantry:getSolderName()
    return 'solder.png'
end

function SolderInfantry:getAniName()
    return 'solderwalk'
end

return SolderInfantry