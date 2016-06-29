--步兵
local SolderBase=import(".SolderBase")
local SolderInfantry = class("SolderInfantry",SolderBase)

function SolderInfantry:ctor(myorene)
    SolderInfantry.super.ctor(self)
    self.speed=200
    self.myorene=myorene
    self.soldertype=SolderBase.SOLDER_TYPE_INFANTRY
end

function SolderInfantry:getSolderName()
--    if self.myorene=='my' then
--        return 'myinf.png'
--    else 
--        return 'eneinf.png'
--    end
    return self.myorene..'inf.png'
end

function SolderInfantry:getAniWalkName()
    return self.myorene..'infwalk'
end

function SolderInfantry:getAniAtkName()
    return self.myorene..'infatk'
end

function SolderInfantry:getDeadName()
    return self.myorene..'infdie.png'
end

return SolderInfantry