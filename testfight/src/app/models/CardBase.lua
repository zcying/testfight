--������
local CardBase = class("CardBase",function()
		return display.newSprite()
       	end)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
CardBase.SOLDER_TYPE_HORSE=1
CardBase.SOLDER_TYPE_ARCHER=2
CardBase.SOLDER_TYPE_INFANTRY=3

function CardBase:ctor(hp,cardname,cardtype)
    self.soldertype=nil
    self.hp=hp
    self.def=def
    self.atk=atk 
    self.sprite=display.newSprite(cardname)
                                  :addTo(self)
    self.hplabel=cc.ui.UILabel.new({text='hp'..self.hp,
                                   x=self.sprite:getPositionX(),
                                   y=self.sprite:getPositionY()-10-self.sprite:getContentSize().height/2,
                                   size=16})
                                 :align(display.CENTER)
                                 :addTo(self)
   --scheduler.scheduleGlobal(self.update,0.1)
end

function CardBase:getHp()
    return self.hp
end

function CardBase:setHp(hp,rate)
    self.hp=self.hp*rate+hp
    self.hplabel:setString('hp'..self.hp)
end

function CardBase:getType()
    return self.soldertype
end

return CardBase