--弓箭
local SolderBase=import(".SolderBase")
local SolderArcher = class("SolderArcher",SolderBase)

function SolderArcher:ctor(myorene)
    SolderArcher.super.ctor(self,myorene)
    self.speed=150
    self.soldertype=SolderBase.SOLDER_TYPE_ARCHER
end

--function SolderArcher:getSolderName()
--    return self.myorene..'archer.png'
--end

function SolderArcher:getAniWalkName()
    return self.myorene..'archerwalk'
end

function SolderArcher:getAniAtkName()
    return self.myorene..'archeratk'
end

function SolderArcher:getAniStyName()
    return self.myorene..'archersteady'
end

function SolderArcher:getDeadName()
    return self.myorene..'archerdie.png'
end

return SolderArcher