--兵基类
local SolderBase = class("SolderBase",function()
		return display.newSprite()
       	end)

SolderBase.SOLDER_TYPE_HORSE=1
SolderBase.SOLDER_TYPE_ARCHER=2
SolderBase.SOLDER_TYPE_INFANTRY=3


function SolderBase:ctor(myorene)
    self.atktime=1
    self.walktime=4/15
    self.steadytime=7/12
    self.myorene=myorene
    --self.sprite=display.newSprite(self:getSolderName()):addTo(self)
    --self.sprite=display.newSprite():addTo(self)
    --self.soldertype=SolderBase.SOLDER_TYPE_HORSE
    self.soldertype=nil
    self.speed=200
    self.aninamewalk=self:getAniWalkName()
    self.aninameatk=self:getAniAtkName()
    self.aninamesty=self:getAniStyName()
    self.aninameDead=self:getDeadName()
    self:addAnimationCache()

end

--function SolderBase:getSolderName()
--    return 'solder.png'
--end
--function SolderBase:getSolderName()
--    return 
--end

function SolderBase:getAniWalkName()
    return 
end

function SolderBase:getAniAtkName()
    return
end

function SolderBase:getAniStyName()
    return
end

function SolderBase:getDeadName()
    return
end

function SolderBase:getSpeed()
    return self.speed
end

function SolderBase:getType()
    return self.soldertype
end

--单兵行走
function SolderBase:walk()
    self:stop()
    self.aniactionwalk=transition.playAnimationForever(self,display.getAnimationCache(self.aninamewalk))
    --self:playAnimationForever(display.getAnimationCache(self.aninamewalk))
    self.aniactionwalk:setTag(1)
end

--单兵攻击
function SolderBase:attack(posfrom,posto)
    self:stop()
    --self.aniactionatk=transition.playAnimationForever(self,display.getAnimationCache(self.aninameatk))
    self.aniactionatk=transition.playAnimationOnce(self,
                                                   display.getAnimationCache(self.aninameatk),
                                                   false,
                                                   function() 
                                                      self:steady() 
                                                   end)
                                                   :setTag(2)
    --self:playAnimationOnce(display.getAnimationCache(self.aninameatk))
    return self.aniactionatk
end

function SolderBase:attackForever()
    self:stop()
    self.aniactionatkf=transition.playAnimationForever(self,
                                                       display.getAnimationCache(self.aninameatk),
                                                       false)
                                                       :setTag(4)
end

function SolderBase:getAttack()
    return display.getAnimationCache(self.aninameatk)
end

function SolderBase:getSteady()
    return display.getAnimationCache(self.aninamesty)
end

--单兵待命
function SolderBase:steady()
    self:stop()
    self.aniactionstd=transition.playAnimationForever(self,display.getAnimationCache(self.aninamesty))
    self.aniactionstd:setTag(3)
    --self:playAnimationForever(display.getAnimationCache(self.aninamesty))
end

--停止
function SolderBase:stop()
    self:stopActionByTag(2)--attack
        :stopActionByTag(1)--walk
        :stopActionByTag(3)--steady
        :stopActionByTag(4)--atkforever
    if self.arrow then
        self.arrow:stopActionByTag(6)
        self.arrow:setVisible(false)
    end
    --transition.stopTarget()
end

--function SolderBase:die()
--    self:stop()
--    self.sprite=display.newSprite(self.aninameDead)
--                 :addTo(self)
--    transition.fadeOut(self.sprite,{time=0.5,
--                               delay=1,
--                               onComplete=function()
--                                   sprite:removeSelf()
--                               end})   
--end

--动画缓存
function SolderBase:addAnimationCache()
    display.addSpriteFrames(self.aninamewalk..'.plist',self.aninamewalk..'.png')
    local frameswalk=display.newFrames(self.aninamewalk..'0%d.png',1,6)
    self.animationwalk=display.newAnimation(frameswalk,self.walktime/6)
    display.setAnimationCache(self.aninamewalk,self.animationwalk)--走路动画

    display.addSpriteFrames(self.aninameatk..'.plist',self.aninameatk..'.png')
    local framesatk=display.newFrames(self.aninameatk..'0%d.png',1,6)
    self.animationatk=display.newAnimation(framesatk,self.atktime/6)
    display.setAnimationCache(self.aninameatk,self.animationatk)--攻击动画

    display.addSpriteFrames(self.aninamesty..'.plist',self.aninamesty..'.png')
    local framesty=display.newFrames(self.aninamesty..'0%d.png',1,7)
    self.animationsty=display.newAnimation(framesty,self.steadytime/7)
    display.setAnimationCache(self.aninamesty,self.animationsty)--待命动画

end

--逃跑，实际就是walk
function SolderBase:runaway()
    self:walk()
end



return SolderBase