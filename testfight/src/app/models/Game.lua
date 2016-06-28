local Game = class("Game",function()
		return display.newLayer()
	end)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Solders=import(".Solders")
local CardBase=import('.CardBase')
local Battle=import('.Battle')

local MYHEADPOS=cc.p(200,100)
local MYMIDPOS=cc.p(300,160)
local MYFRONTPOS=cc.p(400,220)
local ENEHEADPOS
local ENEMIDPOS
local ENEFRONTPOS=cc.p(700,400)

local MYHEADCARDPOS=cc.p(50,display.height-50)
local MYMIDCARDPOS=cc.p(150,display.height-50)
local MYFRONTCARDPOS=cc.p(250,display.height-50)
local ENEHEADCARDPOS
local ENEMIDCARDPOS
local ENEFRONTCARDPOS=cc.p(display.width-250,50)

function Game:ctor()
    math.randomseed(os.time())
    self.battle=Battle:new()
    self:initCardsPara()
    self:initSoldersAndCards()
    
    --testlable
    self.lable1=cc.ui.UILabel.new({
        text='moveforward',
        x=display.width-300,
        y=display.height-100,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:moveForward(-10,183)
                                    self.mymid.solders:moveForward(310,-3)
                                    self.myfront.solders:moveForward(0,0)
                                    self.enefront.solders:moveForward(-100,-60)
                                end
                                return true
                              end)
   self.lable2=cc.ui.UILabel.new({
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
                                    self.enefront.solders:attack()
                                end
                                return true
                              end)
   self.lable3=cc.ui.UILabel.new({
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
                                    self.enefront.solders:runaway(math.random(1,3))
                                end
                                return true
                              end)
   self.lable4=cc.ui.UILabel.new({
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
                                    self.enefront.solders:die(math.random(1,3))
                                end
                                return true
                              end)
   self.lable5=cc.ui.UILabel.new({
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
                                    self.enefront.solders:reformat()
                                end
                                return true
                              end)
        self.lable6=cc.ui.UILabel.new({
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
                                    self.enefront.solders:toRect()
                                end
                                return true
                              end)
       self.lable6=cc.ui.UILabel.new({
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
    self.enehead={cardpara=self.battle:getCardbyKey('enehead')}--敌军
    self.enemid={cardpara=self.battle:getCardbyKey('enemid')}  
    self.enefront={cardpara=self.battle:getCardbyKey('enefront'),card,solders,myorene='ene'}
end

function Game:initSoldersAndCards()--初始化card和solders
    self:addSoldersOnCard(self.myhead,MYHEADPOS,MYHEADCARDPOS)
    self:addSoldersOnCard(self.mymid,MYMIDPOS,MYMIDCARDPOS)
    self:addSoldersOnCard(self.myfront,MYFRONTPOS,MYFRONTCARDPOS)
    self:addSoldersOnCard(self.enefront,ENEFRONTPOS,ENEFRONTCARDPOS)
end

--根据卡牌类别添加兵阵
--卡牌血量：兵量：阵型 
--卡牌类型：兵种：速度、攻击距离等
--soc:solders on card,a table including cardparameter,solders and card
function Game:addSoldersOnCard(soc,solderpos,cardpos)
    local myorene=soc.myorene
    local hp=soc.cardpara.hp
    local name=soc.cardpara.name
    soc.card=CardBase.new(hp,name,myorene)
                    :pos(cardpos.x,cardpos.y)
                    :addTo(self)
    local soldernum=Game:getSolderNum(soc.card:getHp())
    soc.solders=Solders.new(soldernum,myorene)
                    :pos(solderpos.x,solderpos.y)
                    :addTo(self)    
end

function Game:getSolderNum(cardhp)
    if math.ceil(cardhp/20)==cardhp/20 then
        return cardhp/20
    else
        return math.ceil(cardhp/20)
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