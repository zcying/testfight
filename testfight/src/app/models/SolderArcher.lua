--弓箭
local SolderBase=import(".SolderBase")
local SolderArcher = class("SolderArcher",SolderBase)

function SolderArcher:ctor(myorene)
    SolderArcher.super.ctor(self,myorene)
    self.speed=200
    self.soldertype=SolderBase.SOLDER_TYPE_ARCHER
    self.arrow=nil
    self.arrow=display.newSprite(self.myorene..'arrow.png')
                :scale(0.5)
                :pos(40,40)
                :addTo(self)
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

function SolderArcher:attack(posfrom,posto)
    SolderArcher.super.attack(self,posfrom,posto)
--    self.arrow=display.newSprite(self.myorene..'arrow.png')
--                :pos(display.cx,display.cy)
--                :addTo(self)
    --local action=cca.bezierBy(10/15,cc.p(50,100),cc.p(250,100),cc.p(300,0))
    --self.arrow:runAction(action)
end

return SolderArcher