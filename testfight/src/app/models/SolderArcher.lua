--弓箭
local SolderBase=import(".SolderBase")
local SolderArcher = class("SolderArcher",SolderBase)

function SolderArcher:ctor()
    SolderArcher.super.ctor(self)
    self.speed=200
    self.soldertype=SolderBase.SOLDER_TYPE_ARCHER
end

function SolderArcher:getSolderName()
    return 'solder.png'
end

function SolderArcher:getAniName()
    return 'solderwalk'
end

function SolderHorse:getAniAtkName()
    return 'solderattack'
end

function SolderHorse:getDeadName()
    return 'solderdead.png'
end

return SolderArcher