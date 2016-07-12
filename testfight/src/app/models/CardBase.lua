--卡基类
local CardBase = class("CardBase",function()
		return display.newSprite()
       	end)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
CardBase.SOLDER_TYPE_HORSE=1
CardBase.SOLDER_TYPE_ARCHER=2
CardBase.SOLDER_TYPE_INFANTRY=3

function CardBase:ctor(hp,cardname,myorene,typ)
    
    self.hp=hp
    self.totalhp=hp
    self.typ=typ
    self.cardname=cardname
    --self.def=def
    --self.atk=atk
    self.myorene=myorene 
    self.hpchange=nil
    self.hplabel=nil
    self.hpbar=nil
    self.hpbarbg=nil
    self.sprite=display.newSprite(self.cardname)
                                  :addTo(self)
    self:initHp()
    self.sx=self.sprite:getPositionX()
    self.sy=self.sprite:getPositionY()

    self.status=1--活
   --scheduler.scheduleGlobal(self.update,0.1)
end

function CardBase:getMyorEne()
    return self.myorene
end

function CardBase:initHp()
    local hpposy=self.sprite:getPositionY()-10-self.sprite:getContentSize().height/2
    if self.myorene=='ene'then 
        hpposy=self.sprite:getPositionY()+10+self.sprite:getContentSize().height/2
    end
    self.hplabel=cc.ui.UILabel.new({text='hp'..self.hp,
                                   x=self.sprite:getPositionX(),
                                   y=hpposy,
                                   font = 'Arial',
                                   size=16})
                                 :align(display.CENTER)
    self.hx=self.hplabel:getPositionX()
    self.hy=self.hplabel:getPositionY()
    self.hpbar=display.newProgressTimer('hpbar.png',display.PROGRESS_TIMER_BAR)
                                        :align(display.CENTER)
                                        :pos(self.hx,self.hy)
                                        :setBarChangeRate(cc.p(1,0))
                                        :setMidpoint(cc.p(0,0.5))
                                        :setPercentage(100)
                                        :addTo(self)
    self.hpbarbg=display.newSprite('hpbarbg.png')
                                        :align(display.CENTER)
                                        :pos(self.hx,self.hy) 
                                        :addTo(self)                                   
    self.hplabel:addTo(self)
end

function CardBase:die()
    self.status=nil--死
    self.hplabel:setString('dead')
    self.sprite=display.newSprite('die'..self.cardname):addTo(self)
end

function CardBase:getState()
    return self.status
end

function CardBase:setOpacity(op)--透明度
    if self:getState() then
        self.sprite:setOpacity(op)
        self.hpbar:setOpacity(op)
        self.hpbarbg:setOpacity(op)
    end
end

function CardBase:showAttacked(v)--显示被攻击
    self:setOpacity(255)
    local atk=v.atk
    local hpchange=v.hp
    if hpchange~=nil then
        if hpchange<0 then 
            self.hpchange=cc.ui.UILabel.new({text='hp'..hpchange,size=20,color=cc.c3b(255,0,0)})
        else
            self.hpchange=cc.ui.UILabel.new({text='hp+'..hpchange,size=20,color=cc.c3b(0,255,0)})
        end
        if self.myorene =='my'then
            self.hpchange:pos(self.hx,self.sprite:getPositionY()-80)
        else
            self.hpchange:pos(self.hx,self.sprite:getPositionY()+80)
        end 
        self.hpchange:align(display.CENTER):addTo(self)
    end
    if atk then
        local atklabel=cc.ui.UILabel.new({
            font = 'Arial',
            size=18,
            x=self.sx,
            y=self.sy
        })
            :align(display.CENTER)
            :addTo(self)
        if atk>=0 then
            atklabel:setColor(cc.c3b(0,255,0)):setString('atk+'..atk)
            transition.execute(atklabel,
                               cc.MoveBy:create(1,cc.p(0,40)),
                               {onComplete=function()
                                   atklabel:removeSelf()
                               end})
        else
            atklabel:setColor(cc.c3b(255,0,0)):setString('atk'..atk)
            transition.execute(atklabel,
                               cc.MoveBy:create(1,cc.p(0,-40)),
                               {onComplete=function()
                                   atklabel:removeSelf()
                               end})
        end
    end
end

function CardBase:endAttacked()--结束被攻击
    self:setOpacity(150)
    if self.hpchange then
        self.hpchange:setVisible(false)
    end
end

function CardBase:showAttacking(atktype)--显示攻击
    self:setOpacity(255)
    local sx=self.sprite:getPositionX()
    local hx=sx
    local sy=self.sprite:getPositionY()-30
    local hy=self.hplabel:getPositionY()-40
    if self.myorene=='ene'then
        sy=sy+60
        hy=hy+80
    end
    self.sprite:pos(sx,sy)
               :setScale(1.2)
    self.hplabel:pos(hx,hy)
    self.hpbar:pos(hx,hy)
    self.hpbarbg:pos(hx,hy)
    if atktype~='normal' then
        local atklabel=cc.ui.UILabel.new({
            text=atktype,
            x=self.sprite:getPositionX(),
            y=self.sprite:getPositionY(),
            font = 'Arial',
            size=16
        })
            :align(display.CENTER)
            :addTo(self)
        transition.execute(atklabel,
                           cc.ScaleTo:create(1,1.5),
                           {onComplete=function()
                               atklabel:removeSelf()
                           end})
    end
end

function CardBase:endAttacking()--结束攻击
    self:setOpacity(150)
    self.sprite:pos(self.sx,self.sy)
               :setScale(1)
    self.hplabel:pos(self.hx,self.hy)
    self.hpbar:pos(self.hx,self.hy)
    self.hpbarbg:pos(self.hx,self.hy)
end

function CardBase:getHp()
    return self.hp
end

function CardBase:getCardName()
    return self.cardname
end

function CardBase:setHp(hp,rate)
    if hp then
        self.hp=self.hp*rate+hp
        self.hplabel:setString('hp'..self.hp)
        self.hpbar:setPercentage(self.hp/self.totalhp*100)
    end
end

function CardBase:getType()
    return self.typ
end


return CardBase