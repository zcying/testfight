--Æï±ø
local SolderBase=import(".SolderBase")
local SolderHorse = class("SolderHorse",SolderBase)


function SolderHorse:ctor()
    SolderHorse.super.ctor(self)
    self.speed=400
    self.soldertype=SolderBase.SOLDER_TYPE_HORSE
end

function SolderHorse:getSolderName()
    return 'solder.png'
end

function SolderHorse:getAniWalkName()
    return 'solderwalk'
end

function SolderHorse:getAniAtkName()
    return 'solderattack'
end

function SolderHorse:getDeadName()
    return 'solderdead.png'
end

return SolderHorse