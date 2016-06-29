--弓箭
local SolderBase=import(".SolderBase")
local SolderArcher = class("SolderArcher",SolderBase)

function SolderArcher:ctor(myorene)
    SolderArcher.super.ctor(self)
    self.speed=200
    self.myorene=myorene
    self.soldertype=SolderBase.SOLDER_TYPE_ARCHER
end

function SolderArcher:getSolderName()
    return self.myorene..'archer.png'
end

function SolderArcher:getAniWalkName()
    return self.myorene..'archerwalk'
end

function SolderArcher:getAniAtkName()
    return self.myorene..'archeratk'
end

function SolderArcher:getDeadName()
--    if self.myorene=='my' then
--        return 'myarcherdie'
--    else 
--        return 'enearcherdie'
--    end
    return self.myorene..'archerdie.png'
end

return SolderArcher