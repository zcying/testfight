--������
local SolderBase = class("SolderBase",function()
		return display.newSprite()
       	end)

SolderBase.SOLDER_TYPE_HORSE=1
SolderBase.SOLDER_TYPE_ARCHER=2
SolderBase.SOLDER_TYPE_INFANTRY=3


function SolderBase:ctor(myorene)
    self.myorene=myorene
    self.sprite=display.newSprite(self:getSolderName()):addTo(self)
    --self.sprite=display.newSprite():addTo(self)
    --self.soldertype=SolderBase.SOLDER_TYPE_HORSE
    self.soldertype=nil
    self.speed=200
    self.aninamewalk=self:getAniWalkName()
    self.aninameatk=self:getAniAtkName()
    self.aninameDead=self:getDeadName()
    self:addAnimationCache()
end

--function SolderBase:getSolderName()
--    return 'solder.png'
--end
function SolderBase:getSolderName()
    return 
end

function SolderBase:getAniWalkName()
    return 
end

function SolderBase:getAniAtkName()
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
    if self.sprite then
        self:removeChild(self.sprite)
    end
    self:stop()
    self.aniaction=transition.playAnimationForever(self,display.getAnimationCache(self.aninamewalk))
    self.aniaction:setTag(2)
    --scheduler.scheduleGlobal(move,0.3)
end

--��������
function SolderBase:attack()
    if self.sprite then 
        self:removeChild(self.sprite)
    end
    self:stop()
    self.aniaction=transition.playAnimationForever(self,display.getAnimationCache(self.aninameatk))
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
    local frameswalk=display.newFrames(self.aninamewalk..'0%d.png',1,2)
    local animationwalk=display.newAnimation(frameswalk,0.1)
    display.setAnimationCache(self.aninamewalk,animationwalk)--��·����

    display.addSpriteFrames(self.aninameatk..'.plist',self.aninameatk..'.png')
    local framesatk=display.newFrames(self.aninameatk..'0%d.png',1,2)
    local animationatk=display.newAnimation(framesatk,0.1)
    display.setAnimationCache(self.aninameatk,animationatk)--��������
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