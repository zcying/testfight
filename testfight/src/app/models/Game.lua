local Game = class("Game",function()
		return display.newLayer()
	end)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Solders=import(".Solders")
local CardBase=import('.CardBase')
local Battle=import('.Battle')

--兵阵初始点位
local MYHEADPOS=cc.p(200,100)
local MYMIDPOS=cc.p(300,160)
local MYFRONTPOS=cc.p(400,220)
local ENEHEADPOS=cc.p(900,520)
local ENEMIDPOS=cc.p(800,460)
local ENEFRONTPOS=cc.p(700,400)

--我方近战战斗点位
local MYCLOSEMIDPOS=cc.p(500,280)
local MYCLOSELEFTPOS=cc.p(290,343)
local MYCLOSEHALFLEFTPOS=cc.p(380,316)
local MYCLOSERIGHTPOS=cc.p(710,217)
local MYCLOSEHALFRIGHTPOS=cc.p(620,244)

--敌方近战战斗点位
local ENECLOSEMIDPOS=cc.p(600,340)
local ENECLOSELEFTPOS=cc.p(390,403)
local ENECLOSEHALFLEFTPOS=cc.p(480,376)
local ENECLOSERIGHTPOS=cc.p(810,277)
local ENECLOSEHALFRIGHTPOS=cc.p(720,304)

--我方远程战斗点位
local MYLONGMIDPOS=MYFRONTPOS
local MYLONGLEFTPOS=cc.p(190,283)
local MYLONGHALFLEFTPOS=cc.p(280,256)
local MYLONGRIGHTPOS=cc.p(610,157)
local MYLONGHALFRIGHTPOS=cc.p(520,184)

--敌方远程战斗点位
local ENELONGMIDPOS=ENEFRONTPOS
local ENELONGLEFTPOS=cc.p(490,463)
local ENELONGHALFLEFTPOS=cc.p(580,436)
local ENELONGRIGHTPOS=cc.p(910,339)
local ENELONGHALFRIGHTPOS=cc.p(820,364)

--卡牌点位
local MYHEADCARDPOS=cc.p(50,display.height-50)
local MYMIDCARDPOS=cc.p(150,display.height-50)
local MYFRONTCARDPOS=cc.p(250,display.height-50)
local ENEHEADCARDPOS=cc.p(display.width-50,50)
local ENEMIDCARDPOS=cc.p(display.width-150,50)
local ENEFRONTCARDPOS=cc.p(display.width-250,50)

function Game:ctor()
    math.randomseed(os.time())
    self.battle=Battle:new()
    self:initCardsPara()
    self:initSoldersAndCards()
    
    --testlable
    self.lable1=cc.ui.UILabel.new({--前进
        text='moveforward',
        x=display.width-300,
        y=display.height-100,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                local mfx=MYCLOSEMIDPOS.x-MYFRONTPOS.x
                                local mfy=MYCLOSEMIDPOS.y-MYFRONTPOS.y
                                local mmx=MYLONGHALFLEFTPOS.x-MYMIDPOS.x
                                local mmy=MYLONGHALFLEFTPOS.y-MYMIDPOS.y
                                local mhx=MYLONGHALFRIGHTPOS.x-MYHEADPOS.x
                                local mhy=MYLONGHALFRIGHTPOS.y-MYHEADPOS.y
                                local efx=ENECLOSEHALFLEFTPOS.x-ENEFRONTPOS.x
                                local efy=ENECLOSEHALFLEFTPOS.y-ENEFRONTPOS.y
                                local emx=ENECLOSEHALFRIGHTPOS.x-ENEMIDPOS.x
                                local emy=ENECLOSEHALFRIGHTPOS.y-ENEMIDPOS.y
                                local ehx=ENELONGMIDPOS.x-ENEHEADPOS.x
                                local ehy=ENELONGMIDPOS.y-ENEHEADPOS.y
                                if event.name=='ended' then
                                    self.myhead.solders:moveForward(mhx,mhy)
                                    self.mymid.solders:moveForward(mmx,mmy)
                                    self.myfront.solders:moveForward(mfx,mfy)
                                    self.enehead.solders:moveForward(ehx,ehy)
                                    self.enemid.solders:moveForward(emx,emy)
                                    self.enefront.solders:moveForward(efx,efy)
                                end
                                return true
                              end)
   self.lable2=cc.ui.UILabel.new({--攻击
        text='attack',
        x=display.width-300,
        y=display.height-150,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:attack()
                                    self.mymid.solders:attack()
                                    self.myfront.solders:attack()
                                    self.enehead.solders:attack()
                                    self.enemid.solders:attack()
                                    self.enefront.solders:attack()
                                end
                                return true
                              end)
   self.lable3=cc.ui.UILabel.new({--逃跑
        text='runaway',
        x=display.width-300,
        y=display.height-200,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:runaway(math.random(1,3))
                                    self.mymid.solders:runaway(math.random(1,3))
                                    self.myfront.solders:runaway(math.random(1,3))
                                    self.enehead.solders:runaway(math.random(1,3))
                                    self.enemid.solders:runaway(math.random(1,3))
                                    self.enefront.solders:runaway(math.random(1,3))
                                end
                                return true
                              end)
   self.lable4=cc.ui.UILabel.new({--死
        text='solderdie',
        x=display.width-300,
        y=display.height-250,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:die(math.random(1,3))
                                    self.mymid.solders:die(math.random(1,3))
                                    self.myfront.solders:die(math.random(1,3))
                                    self.enehead.solders:die(math.random(1,3))
                                    self.enemid.solders:die(math.random(1,3))
                                    self.enefront.solders:die(math.random(1,3))
                                end
                                return true
                              end)
   self.lable5=cc.ui.UILabel.new({--整队
        text='reformat',
        x=display.width-300,
        y=display.height-300,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:reformat()
                                    self.mymid.solders:reformat()
                                    self.myfront.solders:reformat()
                                    self.enehead.solders:reformat()
                                    self.enemid.solders:reformat()
                                    self.enefront.solders:reformat()
                                end
                                return true
                              end)
        self.lable6=cc.ui.UILabel.new({--变成方阵
         text='toRect',
         x=display.width-300,
         y=display.height-350,
         size=32})
         :addTo(self)
         :setTouchEnabled(true)
         :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:toRect()
                                    self.mymid.solders:toRect()
                                    self.myfront.solders:toRect()
                                    self.enehead.solders:toRect()
                                    self.enemid.solders:toRect()
                                    self.enefront.solders:toRect()
                                end
                                return true
                              end)
       self.lable6=cc.ui.UILabel.new({--变成楔形
        text='toWedge',
        x=display.width-300,
        y=display.height-400,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:toWedge()
                                    self.mymid.solders:toWedge()
                                    self.myfront.solders:toWedge()
                                    self.enehead.solders:toWedge()
                                    self.enemid.solders:toWedge()
                                    self.enefront.solders:toWedge()
                                end
                                return true
                              end)
--       self.lable7=cc.ui.UILabel.new({
--        text='runawayAll',
--        x=display.width-300,
--        y=display.height-450,
--        size=32})
--        :addTo(self)
--        :setTouchEnabled(true)
--        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
--                              function(event)
--                                if event.name=='ended' then
--                                    self.myhead.solders:runawayAll(math.random(1,3))
--                                    self.mymid.solders:runawayAll(math.random(1,3))
--                                    --self.myfront.solders:reformat()
--                                end
--                                return true
--                              end)
        self.lable8=cc.ui.UILabel.new({
            text='my1hurt25hp',
            x=display.width-500,
            y=display.height-100,
            size=32})
            :addTo(self)
            :setTouchEnabled(true)
            :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                                  function(event)
                                      if event.name=='ended'then
                                          local dienum=self:getSolderNum(self.myhead.card:getHp())
                                          self.myhead.card:setHp(-25,1)
                                          dienum=dienum-self:getSolderNum(self.myhead.card:getHp())
                                          printLog(self.myhead.card:getHp(),self:getSolderNum(self.myhead.card:getHp()))
                                          self.myhead.solders:die(dienum)
                                      end
                                      return true
                                  end)
            self.lable8=cc.ui.UILabel.new({
            text='my2hurt25hp',
            x=display.width-500,
            y=display.height-150,
            size=32})
            :addTo(self)
            :setTouchEnabled(true)
            :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                                  function(event)
                                      if event.name=='ended'then
                                          local dienum=self:getSolderNum(self.mymid.card:getHp())
                                          self.mymid.card:setHp(-25,1)
                                          dienum=dienum-self:getSolderNum(self.mymid.card:getHp())
                                          printLog(self.mymid.card:getHp(),self:getSolderNum(self.mymid.card:getHp()))
                                          self.mymid.solders:die(dienum)
                                      end
                                      return true
                                  end)
--   self.lable4=cc.ui.UILabel.new({
--        text='runaway2',
--        x=display.width-300,
--        y=display.height-400,
--        size=32})
--        :addTo(self)
--        :setTouchEnabled(true)
--        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
--                              function(event)
--                                if event.name=='ended' then
--                                    self.myhead.solders:solderrun(2)
--                                end
--                                return true
--                              end)
--    self.button1=cc.ui.UIPushButton.new("solder.png")
--        :pos(800,100)
--        :onButtonClicked(function (event)
--            --self.myfront.solders:moveForward(100,120)
--            --self.mymid.solders:moveForward(250,-120)
--            self.myhead.solders:moveForward(250,0)
--        end)
--        :addTo(self)
--    self.button2=cc.ui.UIPushButton.new('solder.png')
--        :pos(900,100)
--        :onButtonClicked(function(event)
--            self.myhead.solders:attack()
--        end)
--        :addTo(self)
--    self.label1=cc.ui.UILabel.new({
--        text='solders1 moveforward',
--        x=100,
--        y=100,
--        size=32})
--        :addTo(self)
--        :setTouchEnabled(true)
--        :addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
--            if event.name=='began'then
--                self._solders:moveForward()
--            end
--            if event.name=='ended'then
--                self._solders:stop()
--            end
--            return true
--        end)
end

function Game:onEnter()
    
end

function Game:initCardsPara()--从battle获取card的初始参数
    self.myhead={cardpara=self.battle:getCardbyKey('myhead'),card,solders,myorene='my'}--我军大本营
    self.mymid={cardpara=self.battle:getCardbyKey('mymid'),card,solders,myorene='my'}  --中军
    self.myfront={cardpara=self.battle:getCardbyKey('myfront'),card,solders,myorene='my'}--前锋
    self.enehead={cardpara=self.battle:getCardbyKey('enehead'),card,solders,myorene='ene'}--敌军
    self.enemid={cardpara=self.battle:getCardbyKey('enemid'),card,solders,myorene='ene'}  
    self.enefront={cardpara=self.battle:getCardbyKey('enefront'),card,solders,myorene='ene'}
end

function Game:initSoldersAndCards()--初始化card和solders
    self:addSoldersOnCard(self.myhead,MYHEADPOS,MYHEADCARDPOS)
    self:addSoldersOnCard(self.mymid,MYMIDPOS,MYMIDCARDPOS)
    self:addSoldersOnCard(self.myfront,MYFRONTPOS,MYFRONTCARDPOS)
    self:addSoldersOnCard(self.enehead,ENEHEADPOS,ENEHEADCARDPOS)
    self:addSoldersOnCard(self.enemid,ENEMIDPOS,ENEMIDCARDPOS)
    self:addSoldersOnCard(self.enefront,ENEFRONTPOS,ENEFRONTCARDPOS)
end

--根据卡牌类别添加兵阵
--卡牌血量：兵量：阵型 
--卡牌类型：兵种：速度、攻击距离等
--soc:solders on card,a table including cardparameter,solders and card
function Game:addSoldersOnCard(soc,solderpos,cardpos)
    local myorene=soc.myorene
    local hp=soc.cardpara.hp
    local cardname=soc.cardpara.cardname
    local typ=soc.cardpara.typ
    soc.card=CardBase.new(hp,cardname,myorene,typ)
                    :pos(cardpos.x,cardpos.y)
                    :addTo(self)
    local soldernum=Game:getSolderNum(soc.card:getHp())
    soc.solders=Solders.new(soldernum,myorene,soc.card:getType())
                    :pos(solderpos.x,solderpos.y)
                    :addTo(self)    
end

function Game:getSolderNum(cardhp)
--    if math.ceil(cardhp/20)==cardhp/20 then
--        return cardhp/20
--    else
--        return math.ceil(cardhp/20)
--    end
    local hp=cardhp
    if hp>0 and hp<=10 then
        return 1
    elseif hp>10 and hp<=100 then
        return math.ceil(hp/10)
    elseif hp>100 and hp<=1000 then
        return math.ceil(hp/60)+9
    elseif  hp>1000 and hp<=2000 then
        return math.ceil(hp/100)+15
    elseif hp>2000 and hp<=10000 then
        return math.ceil(hp/1000)+33
    else return 44
    end        
end

function Game:getMyHeadpos()

end

function Game:getMyMidpos()

end

function Game:getMyFirstpos()

end

function Game:getEneHeadpos()

end

function Game:getEneMidpos()

end

function Game:getEneFirstpos()

end

return Game