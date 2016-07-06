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
    if self.myorene=='my'then
        self.arrow:setRotation(-60)
    else
        self.arrow:setRotation(30)
    end
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
--    printLog('posfrom',posfrom.x..','..posfrom.y)
--    printLog('posto',posto.x..','..posto.y)    
    local p2=cc.p(posto.x-posfrom.x,posto.y-posfrom.y)
    local c1=cc.p(p2.x/4,p2.y*1.5)
    local c2=cc.p(p2.x/4*3,p2.y*2.5)
    local action=cc.Sequence:create(
                    cc.DelayTime:create(0.3),
                    cc.BezierBy:create(0.5,{c1,c2,p2})
                    ) 
    --self.arrow:runAction(action)
    transition.execute(self.arrow,
                       action,
                       {onComplete=function() 
                            self.arrow:removeSelf()
                            self.arrow=display.newSprite(self.myorene..'arrow.png')
                                :scale(0.5)
                                :pos(40,40)
                                :addTo(self)
                         end})
end

function SolderArcher:attackForever()
    SolderArcher.super.attackForever(self)
    self.arrow:setVisible(true)
    local p2,c1,c2,action,repaction
    p2=cc.p(self:getArrowPos()) 
    if self.myorene=='my' then
        c1=cc.p(p2.x/4,p2.y*1.5)
        c2=cc.p(p2.x/4*3,p2.y*2.5)     
        action=cc.Sequence:create(
                        cc.DelayTime:create(0.3),
                        cc.Spawn:create(cc.BezierBy:create(0.7,{c1,c2,p2}),
                                        cc.RotateBy:create(0.7,100)),
                        cc.CallFunc:create(function() 
                                self.arrow:pos(40,40)
                                          :setRotation(-60)
                        end)
                        )
    else
        c1=cc.p(p2.x/4*3,-p2.y*0.5)
        c2=cc.p(p2.x/4,-p2.y*0.5) 
        action=cc.Sequence:create(
                        cc.DelayTime:create(0.3),
                        cc.Spawn:create(cc.BezierBy:create(0.7,{c1,c2,p2}),
                                        cc.RotateBy:create(0.7,-100)),
                        cc.CallFunc:create(function() 
                                self.arrow:pos(40,40)
                                          :setRotation(30)
                        end)
                        )
    end
    repaction=cc.RepeatForever:create(action)
    transition.execute(self.arrow,repaction):setTag(6)
end

function SolderArcher:getArrowPos()
    local p2,px,py
    if self.myorene=='my'then
        p2=cc.p(250,160)
        px=30-math.random(0,60)
        py=20-math.random(0,40)
    else
        p2=cc.p(-280,-180)
        px=30-math.random(0,60)
        py=20-math.random(0,40)
    end
    return cc.p(p2.x+px,p2.y+py)
end

return SolderArcher