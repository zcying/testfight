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
    if self.myorene=='my' then
        return 'myarcher.png'
    else 
        return 'enearcher.png'
    end
end

function SolderArcher:getAniWalkName()
    if self.myorene=='my' then
        return 'myarcherwalk'
    else 
        return 'enearcherwalk'
    end
end

function SolderArcher:getAniAtkName()
    if self.myorene=='my' then
        return 'myarcheratk'
    else 
        return 'enearcheratk'
    end
end

function SolderArcher:getDeadName()
    if self.myorene=='my' then
        return 'myarcherdie'
    else 
        return 'enearcherdie'
    end
end

return SolderArcher