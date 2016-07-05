--¿¨»ùÀà
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
    self.sprite=display.newSprite(self.cardname)
                                  :addTo(self)
    local hpposy=self.sprite:getPositionY()-10-self.sprite:getContentSize().height/2
    if self.myorene=='ene'then 
        hpposy=self.sprite:getPositionY()+10+self.sprite:getContentSize().height/2
    end
    self.hplabel=cc.ui.UILabel.new({text='hp'..self.hp,
                                   x=self.sprite:getPositionX(),
                                   y=hpposy,
                                   size=16})
                                 :align(display.CENTER)
                                 :addTo(self)
    self.sx=self.sprite:getPositionX()
    self.sy=self.sprite:getPositionY()
    self.hx=self.hplabel:getPositionX()
    self.hy=self.hplabel:getPositionY()
   --scheduler.scheduleGlobal(self.update,0.1)
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

function CardBase:attack()
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

function CardBase:back()
    self.sprite:pos(self.sx,self.sy)
               :setScale(1)
    self.hplabel:pos(self.hx,self.hy)
end

return CardBase