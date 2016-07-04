--Æï±ø
local SolderBase=import(".SolderBase")
local SolderHorse = class("SolderHorse",SolderBase)


function SolderHorse:ctor(myorene)
    SolderHorse.super.ctor(self,myorene)
    self.speed=300
    self.soldertype=SolderBase.SOLDER_TYPE_HORSE
end

function SolderHorse:getAniWalkName()
    return self.myorene..'horsewalk'
end

function SolderHorse:getAniAtkName()
    return self.myorene..'horseatk'
end

function SolderHorse:getAniStyName()
    return self.myorene..'horsesteady'
end

function SolderHorse:getDeadName()
    return self.myorene..'horsedie.png'
end

return SolderHorse