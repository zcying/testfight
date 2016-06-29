--Æï±ø
local SolderBase=import(".SolderBase")
local SolderHorse = class("SolderHorse",SolderBase)


function SolderHorse:ctor(myorene)
    SolderHorse.super.ctor(self)
    self.speed=800
    self.myorene=myorene
    self.soldertype=SolderBase.SOLDER_TYPE_HORSE
end

function SolderHorse:getSolderName()
    if self.myorene=='my' then
        return 'solder.png'
    else 
        return 'solder.png'
    end
end

function SolderHorse:getAniWalkName()
    if self.myorene=='my' then
        return 'solderwalk'
    else
        return 'solderwalk'
    end
end

function SolderHorse:getAniAtkName()
    if self.myorene=='my' then
        return 'solderattack'
    else 
        return 'solderattack'
    end
end

function SolderHorse:getDeadName()
    if self.myorene=='my' then
        return 'solderdead.png'
    else 
        return 'solderdead.png'
    end
end

return SolderHorse