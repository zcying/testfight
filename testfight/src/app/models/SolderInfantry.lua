--步兵
local SolderBase=import(".SolderBase")
local SolderInfantry = class("SolderInfantry",SolderBase)

function SolderInfantry:ctor(myorene)
    SolderInfantry.super.ctor(self,myorene)
    self.atktime=12/15
    self.walktime=4/15
    self.steadytime=7/12
    self:addAnimationCache()
    self.speed=200
    self.soldertype=SolderBase.SOLDER_TYPE_INFANTRY

end

--function SolderInfantry:getSolderName()
----    if self.myorene=='my' then
----        return 'myinf.png'
----    else 
----        return 'eneinf.png'
----    end
--    return self.myorene..'inf.png'
--end

function SolderInfantry:getAniWalkName()
    return self.myorene..'infwalk'
end

function SolderInfantry:getAniAtkName()
    return self.myorene..'infatk'
end

function SolderInfantry:getAniStyName()
    return self.myorene..'infsteady'
end

function SolderInfantry:getDeadName()
    return self.myorene..'infdie.png'
end

function SolderInfantry:addAnimationCache()
    display.addSpriteFrames(self.aninamewalk..'.plist',self.aninamewalk..'.png')
    local frameswalk=display.newFrames(self.aninamewalk..'0%d.png',1,6)
    local animationwalk=display.newAnimation(frameswalk,self.walktime/6)
    display.setAnimationCache(self.aninamewalk,animationwalk)--走路动画

    display.addSpriteFrames(self.aninameatk..'.plist',self.aninameatk..'.png')
    local framesatk=display.newFrames(self.aninameatk..'0%d.png',1,5)
    local animationatk=display.newAnimation(framesatk,self.atktime/5)
    display.setAnimationCache(self.aninameatk,animationatk)--攻击动画

    display.addSpriteFrames(self.aninamesty..'.plist',self.aninamesty..'.png')
    local framesty=display.newFrames(self.aninamesty..'0%d.png',1,7)
    local animationsty=display.newAnimation(framesty,self.steadytime/7)
    display.setAnimationCache(self.aninamesty,animationsty)--待命动画
end

return SolderInfantry