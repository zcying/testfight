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
    self.typ=typ
    self.cardname=cardname
    --self.def=def
    --self.atk=atk
    self.myorene=myorene 
    self.hpchange=nil
    self.sprite=display.newSprite(self.cardname)
                                  :addTo(self)
    self.hpposy=self.sprite:getPositionY()-10-self.sprite:getContentSize().height/2
    if self.myorene=='ene'then 
        self.hpposy=self.sprite:getPositionY()+10+self.sprite:getContentSize().height/2
    end
    self.hplabel=cc.ui.UILabel.new({text='hp'..self.hp,
                                   x=self.sprite:getPositionX(),
                                   y=self.hpposy,
                                   size=16})
                                 :align(display.CENTER)
                                 :addTo(self)
    self.sx=self.sprite:getPositionX()
    self.sy=self.sprite:getPositionY()
    self.hx=self.hplabel:getPositionX()
    self.hy=self.hplabel:getPositionY()
    self.status=1--活
   --scheduler.scheduleGlobal(self.update,0.1)
end

function CardBase:getMyorEne()
    return self.myorene
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
    end
end

function CardBase:showAttacked(hpchange)--显示被攻击
    self:setOpacity(255)
    if hpchange<0 then 
        self.hpchange=cc.ui.UILabel.new({text=hpchange,size=20,color=cc.c3b(255,0,0)})
    elseif hpchange>=0 then
        self.hpchange=cc.ui.UILabel.new({text='+'..hpchange,size=20,color=cc.c3b(0,255,0)})
    else
        return
    end
    if self.myorene =='my'then
        self.hpchange:pos(self.hx,self.sprite:getPositionY()-80)
    else
        self.hpchange:pos(self.hx,self.sprite:getPositionY()+80)
    end 
    self.hpchange:align(display.CENTER):addTo(self)
end

function CardBase:endAttacked()--结束被攻击
    self:setOpacity(150)
    if self.hpchange then
        self.hpchange:setVisible(false)
    end
end

function CardBase:showAttacking()--显示攻击
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
end

function CardBase:endAttacking()--结束攻击
    self:setOpacity(150)
    self.sprite:pos(self.sx,self.sy)
               :setScale(1)
    self.hplabel:pos(self.hx,self.hy)
end

function CardBase:getHp()
    return self.hp
end

function CardBase:getCardName()
    return self.cardname
end

function CardBase:setHp(hp,rate)
    self.hp=self.hp*rate+hp
    self.hplabel:setString('hp'..self.hp)
end

function CardBase:getType()
    return self.typ
end


return CardBase