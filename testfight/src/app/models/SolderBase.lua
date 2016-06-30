--������
local SolderBase = class("SolderBase",function()
		return display.newSprite()
       	end)

SolderBase.SOLDER_TYPE_HORSE=1
SolderBase.SOLDER_TYPE_ARCHER=2
SolderBase.SOLDER_TYPE_INFANTRY=3


function SolderBase:ctor(myorene)
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

--��������
function SolderBase:walk()
--    local function move(dt)
--        transition.moveBy(self,{time=0.2,x=20,y=15})
--    end
--    if self.sprite then
--        self:removeChild(self.sprite)
--    end
    self:stop()
    self.aniaction=transition.playAnimationForever(self,display.getAnimationCache(self.aninamewalk))
    self.aniaction:setTag(2)
    --scheduler.scheduleGlobal(move,0.3)
end

--��������
function SolderBase:attack()
--    if self.sprite then 
--        self:removeChild(self.sprite)
--    end
    self:stop()
    self.aniaction=transition.playAnimationForever(self,display.getAnimationCache(self.aninameatk))
    self.aniaction:setTag(2)
end

--��������
function SolderBase:steady()
    self:stop()
    self.aniaction=transition.playAnimationForever(self,display.getAnimationCache(self.aninamesty))
    self.aniaction:setTag(2)
end

--ֹͣ
function SolderBase:stop()
    --self.sprite:setVisible(true)
    self:stopActionByTag(2)
    self.aniaction=nil
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

--��������
function SolderBase:addAnimationCache()
    display.addSpriteFrames(self.aninamewalk..'.plist',self.aninamewalk..'.png')
    local frameswalk=display.newFrames(self.aninamewalk..'0%d.png',1,6)
    local animationwalk=display.newAnimation(frameswalk,2/15)
    display.setAnimationCache(self.aninamewalk,animationwalk)--��·����

    display.addSpriteFrames(self.aninameatk..'.plist',self.aninameatk..'.png')
    local framesatk=display.newFrames(self.aninameatk..'0%d.png',1,6)
    local animationatk=display.newAnimation(framesatk,2/15)
    display.setAnimationCache(self.aninameatk,animationatk)--��������

    display.addSpriteFrames(self.aninamesty..'.plist',self.aninamesty..'.png')
    local framesty=display.newFrames(self.aninamesty..'0%d.png',1,7)
    local animationsty=display.newAnimation(framesty,1/12)
    display.setAnimationCache(self.aninamesty,animationsty)--��������

end

--���ܣ�ʵ�ʾ���walk
function SolderBase:runaway()
    if self.sprite then 
        self:removeChild(self.sprite)
    end
    --self:stop()
    self:walk()
end

return SolderBase