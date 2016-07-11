local Game = class("Game",function()
		return display.newLayer()
	end)
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")
local Solders=import(".Solders")
local CardBase=import('.CardBase')
local Battle=import('.Battle')
local scheduler = require("framework.scheduler")  

local map={
--�����ʼ��λ
-- MYHEADPOS=cc.p(200,100)
-- MYMIDPOS=cc.p(300,160)
-- MYFRONTPOS=cc.p(400,220)
 MYHEADPOS=cc.p(300,160),
 MYMIDPOS=cc.p(400,220),
 MYFRONTPOS=cc.p(500,280),
 ENEHEADPOS=cc.p(900,520),
 ENEMIDPOS=cc.p(800,460),
 ENEFRONTPOS=cc.p(700,400),
--�ҷ���սս����λ
-- MYCLOSEMIDPOS=cc.p(500,280)
-- MYCLOSELEFTPOS=cc.p(290,343)
-- MYCLOSEHALFLEFTPOS=cc.p(380,316)
-- MYCLOSERIGHTPOS=cc.p(710,217)
-- MYCLOSEHALFRIGHTPOS=cc.p(620,244)
 MYCLOSEMIDPOS=cc.p(600,340),
 MYCLOSELEFTPOS=cc.p(390,403),
 MYCLOSEHALFLEFTPOS=cc.p(480,376),
 MYCLOSERIGHTPOS=cc.p(810,277),
 MYCLOSEHALFRIGHTPOS=cc.p(720,304),
--�з���սս����λ
 ENECLOSEMIDPOS=cc.p(600,340),
 ENECLOSELEFTPOS=cc.p(390,403),
 ENECLOSEHALFLEFTPOS=cc.p(480,376),
 ENECLOSERIGHTPOS=cc.p(810,277),
 ENECLOSEHALFRIGHTPOS=cc.p(720,304),
--�ҷ�Զ��ս����λ
 MYLONGMIDPOS=cc.p(500,280),
-- MYLONGLEFTPOS=cc.p(190,283)
-- MYLONGHALFLEFTPOS=cc.p(280,256)
-- MYLONGRIGHTPOS=cc.p(610,157)
-- MYLONGHALFRIGHTPOS=cc.p(520,184)
 MYLONGLEFTPOS=cc.p(290,343),
 MYLONGHALFLEFTPOS=cc.p(380,316),
 MYLONGRIGHTPOS=cc.p(710,217),
 MYLONGHALFRIGHTPOS=cc.p(620,244),
--�з�Զ��ս����λ
 ENELONGMIDPOS=cc.p(700,400),
 ENELONGLEFTPOS=cc.p(490,463),
 ENELONGHALFLEFTPOS=cc.p(580,436),
 ENELONGRIGHTPOS=cc.p(910,339),
 ENELONGHALFRIGHTPOS=cc.p(820,364),
--���Ƶ�λ
 MYHEADCARDPOS=cc.p(50,display.height-50),
 MYMIDCARDPOS=cc.p(140,display.height-50),
 MYFRONTCARDPOS=cc.p(230,display.height-50),
 ENEHEADCARDPOS=cc.p(display.width-50,50),
 ENEMIDCARDPOS=cc.p(display.width-140,50),
 ENEFRONTCARDPOS=cc.p(display.width-230,50)
}

function Game:ctor()
    math.randomseed(os.time())
    self.cardkey={'myhead','mymid','myfront','enehead','enemid','enefront'}
--���ӷֲ���my/ene_closeͬһ��
--ENELONG      11   12   13 14    15
--MY/ENECLOSE  6    7    8   9    10
--MYLONG       1    2    3   4    5  
--           LEFT HALFL MID HALFR RIGHT   
    self.mapkey={{pos=map.MYLONGLEFTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYLONGHALFLEFTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYLONGMIDPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYLONGHALFRIGHTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYLONGRIGHTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYCLOSELEFTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYCLOSEHALFLEFTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYCLOSEMIDPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYCLOSEHALFRIGHTPOS,cardmy=nil,cardene=nil},
                 {pos=map.MYCLOSERIGHTPOS,cardmy=nil,cardene=nil},
                 {pos=map.ENELONGLEFTPOS,cardmy=nil,cardene=nil},
                 {pos=map.ENELONGHALFLEFTPOS,cardmy=nil,cardene=nil},
                 {pos=map.ENELONGMIDPOS,cardmy=nil,cardene=nil},
                 {pos=map.ENELONGHALFRIGHTPOS,cardmy=nil,cardene=nil},
                 {pos=map.ENELONGLEFTPOS,cardmy=nil,cardene=nil}
                }
    self.background=display.newSprite('background.jpg')
        :pos(display.cx,display.cy)
        :addTo(self)
    self.battle=Battle:new()
    self.report=self.battle:getReport()
    self:initCardsPara()
    self:initSoldersAndCards()
    scheduler.performWithDelayGlobal(
        function()
            self:toRect()
        end,0.2)
    scheduler.performWithDelayGlobal(
        function()
            self:getReady()
            scheduler.performWithDelayGlobal(
                function()
                    self:getBattle() 
                end,1) 
        end,1)
    --self:showTest()
end

function Game:onEnter()
    
end

function Game:initCardsPara()--��battle��ȡcard�ĳ�ʼ����
    for k,v in pairs(self.cardkey)do
        local myorene=string.sub(v,1,1)
        if myorene=='m' then 
            myorene='my'
        else 
            myorene='ene'
        end
        self[v]={cardpara=self.battle:getCardbyKey(v),card,solders,myorene=myorene}
    end
--    self.myhead={cardpara=self.battle:getCardbyKey('myhead'),card,solders,myorene='my'}--�Ҿ���Ӫ
--    self.mymid={cardpara=self.battle:getCardbyKey('mymid'),card,solders,myorene='my'}  --�о�
--    self.myfront={cardpara=self.battle:getCardbyKey('myfront'),card,solders,myorene='my'}--ǰ��
--    self.enehead={cardpara=self.battle:getCardbyKey('enehead'),card,solders,myorene='ene'}--�о�
--    self.enemid={cardpara=self.battle:getCardbyKey('enemid'),card,solders,myorene='ene'}  
--    self.enefront={cardpara=self.battle:getCardbyKey('enefront'),card,solders,myorene='ene'}
end

function Game:initSoldersAndCards()--��ʼ��card��solders
    self:addSoldersOnCard(self.myhead,map.MYHEADPOS,map.MYHEADCARDPOS)
    self:addSoldersOnCard(self.mymid,map.MYMIDPOS,map.MYMIDCARDPOS)
    self:addSoldersOnCard(self.myfront,map.MYFRONTPOS,map.MYFRONTCARDPOS)
    self:addSoldersOnCard(self.enehead,map.ENEHEADPOS,map.ENEHEADCARDPOS)
    self:addSoldersOnCard(self.enemid,map.ENEMIDPOS,map.ENEMIDCARDPOS)
    self:addSoldersOnCard(self.enefront,map.ENEFRONTPOS,map.ENEFRONTCARDPOS)
end

--���ݿ���������ӱ���
--����Ѫ�������������� 
--�������ͣ����֣��ٶȡ����������
--soc:solders on card,a table including cardparameter,solders,card and mapkey
function Game:addSoldersOnCard(soc,solderpos,cardpos)
    if soc.cardpara==nil then return end
    local myorene=soc.myorene
    local hp=soc.cardpara.hp
    local cardname=soc.cardpara.cardname
    local typ=soc.cardpara.typ
    soc.card=CardBase.new(hp,cardname,myorene,typ)
                    :pos(cardpos.x,cardpos.y)
                    :addTo(self)
    local soldernum=Game:getSolderNum(soc.card:getHp())
    --printLog(myorene)
    soc.solders=Solders.new(soldernum,myorene,soc.card:getType(),soc.card:getCardName())
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
    if hp==0 then
        return 0
    elseif hp>0 and hp<=10 then
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

--moveby����
function Game:getDis(posfrom,posto)
    return posto.x-posfrom.x, posto.y-posfrom.y
end

function Game:toRect()
    for k,v in pairs(self.cardkey)do
        if self[v].solders then
            self[v].solders:toRect()
        end
    end   
end

--����ʼվλ
--���ӷֲ���my/ene_closeͬһ��
--ENELONG      11   12   13 14    15
--MY/ENECLOSE  6    7    8   9    10
--MYLONG       1    2    3   4    5  
--           LEFT HALFL MID HALFR RIGHT  
function Game:getReady()
    local mfx,mfy,mmx,mmy,mhx,mhy,efx,efy,emx,emy,ehx,ehy,mf,mm,mh,ef,em,eh--6����ʼ�ƶ�����
    local mf=self.myfront.card:getType()--��ȡ�������ı�������
    local mm=self.mymid.card:getType()
    local mh=self.myhead.card:getType()
    local ef=self.enefront.card:getType()
    local em=self.enemid.card:getType()
    local eh=self.enehead.card:getType()
--��ս/Զ�����ֱ�����Ӫ/�о�/ǰ��������ʼλ�ã���/�ң�2^3*2��16�ֳ�ʼվλ,���һ����������3�Ż�û����
    if mf==2 and mm==2 and mh==2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYLONGMIDPOS)
        self.myfront.mapkey=3
        self.mapkey[3].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYLONGRIGHTPOS)
        self.mymid.mapkey=5
        self.mapkey[5].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYLONGLEFTPOS)
        self.myhead.mapkey=1
        self.mapkey[1].cardmy='myhead'
    elseif mf==2 and mm~=2 and mh==2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYLONGHALFRIGHTPOS)
        self.myfront.mapkey=4
        self.mapkey[4].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYCLOSEMIDPOS)
        self.mymid.mapkey=8
        self.mapkey[8].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYLONGHALFLEFTPOS)
        self.myhead.mapkey=2
        self.mapkey[2].cardmy='myhead'
    elseif mf==2 and mm==2 and mh~=2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYLONGHALFRIGHTPOS)
        self.myfront.mapkey=4
        self.mapkey[4].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYLONGHALFLEFTPOS)
        self.mymid.mapkey=2
        self.mapkey[2].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYCLOSEMIDPOS)
        self.myhead.mapkey=8
        self.mapkey[8].cardmy='myhead'
    elseif mf==2 and mm~=2 and mh~=2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYLONGMIDPOS)
        self.myfront.mapkey=3
        self.mapkey[3].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYCLOSEHALFRIGHTPOS)
        self.mymid.mapkey=9
        self.mapkey[9].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYCLOSEHALFLEFTPOS)
        self.myhead.mapkey=7
        self.mapkey[7].cardmy='myhead'
    elseif mf~=2 and mm==2 and mh==2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYCLOSEMIDPOS)
        self.myfront.mapkey=8
        self.mapkey[8].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYLONGHALFRIGHTPOS)
        self.mymid.mapkey=4
        self.mapkey[4].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYLONGHALFLEFTPOS)
        self.myhead.mapkey=2
        self.mapkey[2].cardmy='myhead'
    elseif mf~=2 and mm~=2 and mh==2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYCLOSEHALFRIGHTPOS)
        self.myfront.mapkey=9
        self.mapkey[9].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYCLOSEHALFLEFTPOS)
        self.mymid.mapkey=7
        self.mapkey[7].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYLONGMIDPOS)
        self.myhead.mapkey=3
        self.mapkey[3].cardmy='myhead'
    elseif mf~=2 and mm==2 and mh~=2 then
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYCLOSEHALFRIGHTPOS)
        self.myfront.mapkey=9
        self.mapkey[9].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYLONGMIDPOS)
        self.mymid.mapkey=3
        self.mapkey[3].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYCLOSEHALFLEFTPOS)
        self.myhead.mapkey=7
        self.mapkey[7].cardmy='myhead'
    else
        mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYCLOSEMIDPOS)
        self.myfront.mapkey=8
        self.mapkey[8].cardmy='myfront'
        mmx,mmy=self:getDis(map.MYMIDPOS,map.MYCLOSERIGHTPOS)
        self.mymid.mapkey=10
        self.mapkey[10].cardmy='mymid'
        mhx,mhy=self:getDis(map.MYHEADPOS,map.MYCLOSELEFTPOS)
        self.myhead.mapkey=6
        self.mapkey[6].cardmy='myhead'
    end
    if eh==2 and em==2 and ef==2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENELONGRIGHTPOS)
        self.enehead.mapkey=15
        self.mapkey[15].cardene='enehead'
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENELONGLEFTPOS)
        self.enemid.mapkey=11
        self.mapkey[11].cardene='enemid'
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENELONGMIDPOS)
        self.enefront.mapkey=13
        self.mapkey[13].cardene='enefront'
    elseif eh==2 and em~=2 and ef==2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENELONGHALFRIGHTPOS)
        self.enehead.mapkey=14
        self.mapkey[14].cardene='enehead'        
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENECLOSEMIDPOS)
        self.enemid.mapkey=8
        self.mapkey[8].cardene='enemid'        
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENELONGHALFLEFTPOS)
        self.enefront.mapkey=12
        self.mapkey[12].cardene='enefront'    
    elseif eh==2 and em==2 and ef~=2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENELONGHALFRIGHTPOS)
        self.enehead.mapkey=14
        self.mapkey[14].cardene='enehead'        
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENELONGHALFLEFTPOS)
        self.enemid.mapkey=12
        self.mapkey[12].cardene='enemid'      
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENECLOSEMIDPOS)
        self.enefront.mapkey=8
        self.mapkey[8].cardene='enefront'    
    elseif eh==2 and em~=2 and ef~=2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENELONGMIDPOS)
        self.enehead.mapkey=13
        self.mapkey[13].cardene='enehead'   
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENECLOSEHALFRIGHTPOS)
        self.enemid.mapkey=9
        self.mapkey[9].cardene='enemid'      
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENECLOSEHALFLEFTPOS)
        self.enefront.mapkey=7
        self.mapkey[7].cardene='enefront'     
    elseif eh~=2 and em==2 and ef==2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENECLOSEMIDPOS)
        self.enehead.mapkey=8
        self.mapkey[8].cardene='enehead'      
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENELONGHALFRIGHTPOS)
        self.enemid.mapkey=14
        self.mapkey[14].cardene='enemid'     
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENELONGHALFLEFTPOS)
        self.enefront.mapkey=12
        self.mapkey[12].cardene='enefront'   
    elseif eh~=2 and em~=2 and ef==2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENECLOSEHALFRIGHTPOS)
        self.enehead.mapkey=9
        self.mapkey[9].cardene='enehead'     
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENECLOSEHALFLEFTPOS)
        self.enemid.mapkey=7
        self.mapkey[7].cardene='enemid'    
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENELONGMIDPOS)
        self.enefront.mapkey=13
        self.mapkey[13].cardene='enefront'    
    elseif eh~=2 and em==2 and ef~=2 then
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENECLOSEHALFRIGHTPOS)
        self.enehead.mapkey=9
        self.mapkey[9].cardene='enehead'     
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENELONGMIDPOS)
        self.enemid.mapkey=13
        self.mapkey[13].cardene='enemid'     
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENECLOSEHALFLEFTPOS)
        self.enefront.mapkey=7
        self.mapkey[7].cardene='enefront'     
    else
        ehx,ehy=self:getDis(map.ENEHEADPOS,map.ENECLOSERIGHTPOS)
        self.enehead.mapkey=10
        self.mapkey[10].cardene='enehead'    
        emx,emy=self:getDis(map.ENEMIDPOS,map.ENECLOSELEFTPOS)
        self.enemid.mapkey=6
        self.mapkey[6].cardene='enemid'       
        efx,efy=self:getDis(map.ENEFRONTPOS,map.ENECLOSEMIDPOS)
        self.enefront.mapkey=8
        self.mapkey[8].cardene='enefront'     
    end
    self.myfront.solders:moveForward(mfx,mfy)
    self.mymid.solders:moveForward(mmx,mmy)
    self.myhead.solders:moveForward(mhx,mhy)
    self.enefront.solders:moveForward(efx,efy)
    self.enemid.solders:moveForward(emx,emy)
    self.enehead.solders:moveForward(ehx,ehy)
 
end

--����ս������
function Game:getBattle()
    local torecttime=0--���������
    local action={} 
    local roundlabel=display.newTTFLabel({
        text='ROUND1',
        size=50,
        font = 'Arial'
    }):align(display.CENTER):pos(display.cx,display.height-50):addTo(self)
    for n,m in pairs(self.cardkey) do--ȫ����
        self[m].card:endAttacked()
        self[m].solders:endAttacked()
    end
    for i=1,8 do --8�غ�
        local round=self.report['round'..i]--��ʾ�غ���
        if round==nil then
            break 
        end
        for j=1,6 do --ÿ�غ����߸������ƹ�������6�ƹ���
            local attack=round['attack'..j]
            if attack==nil then break end
            for l=1,8 do    --�������һ���˿��Թ���8�Σ�һ������
                if  attack['atktype'..l]==nil then break end
                action[#action+1]=transition.sequence({--���涯��
                    cc.CallFunc:create(function()
                        roundlabel:setString('ROUND'..i)
                        self[attack.atkfrom].card:showAttacking()--��ʾ����
                        self[attack.atkfrom].solders:showAttacking()
                        --printLog(attack.atkfrom,self[attack.atkfrom].solders:getPortPos().x..','..self[attack.atkfrom].solders:getPortPos().y)
                        for k,v in pairs(attack['atkto'..l])do --����Ŀ�꣬�ɹ��������������ˣ��Լ����ļ�ѪҲ��
                            local beforhp=self[k].card:getHp()
                            local hpchange
                            self[k].solders:showAttacked()--��ʾ������
                            self[k].card:showAttacked(v)
                            scheduler.performWithDelayGlobal(--��������Ч���Ķ�ʱ��
                                function()
                                    self[k].card:setHp(v,1)--��Ѫ
                                    local afterhp=self[k].card:getHp()
                                    if v<0 then
                                        self[k].solders:die(self:getSolderNum(beforhp)-self:getSolderNum(afterhp))--��������
                                    else
                                        self[k].solders:solderNeverDie(self:getSolderNum(afterhp)-self:getSolderNum(beforhp))--��������
                                    end
                                    self[attack.atkfrom].card:endAttacking ()--��������
                                    self[attack.atkfrom].solders:endAttacking()
                                    self[k].solders:endAttacked()--����������
                                    self[k].card:endAttacked()
                                    if afterhp==0 and self[k].card:getState() then
                                        self[k].card:die()
                                        torecttime=torecttime+1
                                    end
                                end,
                                self[attack.atkfrom].solders:getAtktime()+0.8--����Ч����ʾʱ��
                            )    
                        end
                    end
                ),
                cc.DelayTime:create(2), --ÿ���Ƶ��ι���ʱ����     
                cc.CallFunc:create(function()--ÿ�ι���������б����������ȫ�����ӣ�����������λ��
                    if self:whoWin() then--�ж��Ƿ���һ������
                        roundlabel:setString(self:whoWin())
                        for k,v in pairs(self.cardkey) do
                            if self[v].card:getState() then
                                self[v].solders:toRect()
                            end
                        end
                    else                    
                        for n,m in pairs(self.cardkey) do
                            if self[m].card:getState()==nil and torecttime>0 then
                                torecttime=torecttime-1
                                self:moveSolders(m)
--                              for o,p in pairs(self.cardkey)do 
--                                  if self[p].card:getState() then
--                                      self[p].solders:toRectandAtk()
--                                  end
--                              end
                            end
                        end
                    end            
                end),
                cc.DelayTime:create(0.5)         
                })
            end
        end
    end
    self:runAction(transition.sequence(action)) 
end

--�б��������ƶ�ʣ�µı���
--diekey,����ı����cardkey��mymid\myfront\enehead...
--self[diekey].mapkey,���ӱ��
--���ӷֲ���my/ene_closeͬһ��
--ENELONG      11   12   13 14    15
--MY/ENECLOSE  6    7    8   9    10
--MYLONG       1    2    3   4    5  
--           LEFT HALFL MID HALFR RIGHT  
function Game:moveSolders(diekey)
    local mapkey=self[diekey].mapkey--1,2,3,4....15
    local num=mapkey % 5
    local movefrom={}--���
    local moveto={}
    local myorene
    local eneormy
    if string.sub(diekey,1,1)=='m' then
        myorene='my'
        eneormy='ene'
    else
        myorene='ene'
        eneormy='my'
    end
    if num==1 then--left die��mid moveto halfleft,right moveto halfright
        movefrom[1]=mapkey+2
        moveto[1]=mapkey+1
        movefrom[2]=mapkey+4
        moveto[2]=mapkey+3
    elseif num==2 then
        movefrom[1]=mapkey+2
        moveto[1]=mapkey+1       
    elseif num==4 then
        movefrom[1]=mapkey-2
        moveto[1]=mapkey-1
    elseif num==0 then
        movefrom[1]=mapkey-4
        moveto[1]=mapkey-3
        movefrom[2]=mapkey-2
        moveto[2]=mapkey-1
    else--�м�һ����������������߻����ˣ����м��ƶ����������û���ˣ������Զ��λ��û����������ڽ���λ�ã��з���ս������ǰ��
        if self.mapkey[mapkey+2]['card'..myorene]~=nil then
            movefrom[1]=mapkey+2
            moveto[1]=mapkey+1
            movefrom[2]=mapkey-2
            moveto[2]=mapkey-1
        else
            if mapkey==8 then
                if myorene=='my'then--myclosemid��������eneclose�ƶ���mylong��1��2��3��4��5
                    for i=1,5 do
                        movefrom[i]=i+5
                        moveto[i]=i
                    end
                else                              --eneclosemid��������myclose��ǰ�Ƶ�enelong��11��12��13��14��15
                    for i=1,5 do
                        movefrom[i]=i+5
                        moveto[i]=i+10
                    end
                end
            end
        end
    end

    if  mapkey==8 and self.mapkey[mapkey+2]['card'..myorene]==nil then
        for i=1,#movefrom do
            if self.mapkey[movefrom[i]]['card'..eneormy]~=nil then
                self[self.mapkey[movefrom[i]]['card'..eneormy]].mapkey=moveto[i]
                self[self.mapkey[movefrom[i]]['card'..eneormy]].solders:moveForward(self:getDis(self.mapkey[movefrom[i]].pos,self.mapkey[moveto[i]].pos))
                self.mapkey[moveto[i]]['card'..eneormy]=self.mapkey[movefrom[i]]['card'..eneormy]
                self.mapkey[movefrom[i]]['card'..eneormy]=nil


                printLog(diekey,self[diekey].mapkey)
                printLog('movefrom'..i,self.mapkey[moveto[i]]['card'..eneormy]..'from'..movefrom[i])
                printLog('moveto'..i,moveto[i])
            end
        end             
    else
        for i=1,#movefrom do 
            if self.mapkey[movefrom[i]]['card'..myorene]~=nil then
                self[self.mapkey[movefrom[i]]['card'..myorene]].mapkey=moveto[i]
                self[self.mapkey[movefrom[i]]['card'..myorene]].solders:moveForward(self:getDis(self.mapkey[movefrom[i]].pos,self.mapkey[moveto[i]].pos))                
                self.mapkey[moveto[i]]['card'..myorene]=self.mapkey[movefrom[i]]['card'..myorene]
                self.mapkey[movefrom[i]]['card'..myorene]=nil

                printLog(diekey,self[diekey].mapkey)
                printLog('movefrom'..i,self.mapkey[moveto[i]]['card'..myorene]..'from'..movefrom[i])
                printLog('moveto'..i,moveto[i])
            end            
        end
    end
end

function Game:whoWin()
    if self.mymid.card:getState()==nil and
       self.myhead.card:getState()==nil and
       self.myfront.card:getState()==nil then
           return 'LOSE'
    end
    if self.enemid.card:getState()==nil and
       self.enehead.card:getState()==nil and
       self.enefront.card:getState()==nil  then
           return 'WIN'
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

function Game:showTest()
    self.lable1=cc.ui.UILabel.new({--ǰ��
        text='moveforward',
        x=display.width-300,
        y=display.height-100,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
--                                local mfx=map.MYCLOSEMIDPOS.x-map.MYFRONTPOS.x
--                                local mfy=map.MYCLOSEMIDPOS.y-map.MYFRONTPOS.y
                                local mfx,mfy=self:getDis(map.MYFRONTPOS,map.MYCLOSEMIDPOS)
                                local mmx=map.MYLONGHALFLEFTPOS.x-map.MYMIDPOS.x
                                local mmy=map.MYLONGHALFLEFTPOS.y-map.MYMIDPOS.y
                                local mhx=map.MYLONGHALFRIGHTPOS.x-map.MYHEADPOS.x
                                local mhy=map.MYLONGHALFRIGHTPOS.y-map.MYHEADPOS.y
                                local efx=map.ENECLOSEHALFLEFTPOS.x-map.ENEFRONTPOS.x
                                local efy=map.ENECLOSEHALFLEFTPOS.y-map.ENEFRONTPOS.y
                                local emx=map.ENECLOSEHALFRIGHTPOS.x-map.ENEMIDPOS.x
                                local emy=map.ENECLOSEHALFRIGHTPOS.y-map.ENEMIDPOS.y
                                local ehx=map.ENELONGMIDPOS.x-map.ENEHEADPOS.x
                                local ehy=map.ENELONGMIDPOS.y-map.ENEHEADPOS.y
                                if event.name=='ended' then
                                    --transition.moveTo(self.myhead.solders,{time=math.sqrt(mhx*mhx+mhy*mhy)/self.myhead.solders.speed,x=map.MYLONGHALFRIGHTPOS.x,y=map.MYLONGHALFRIGHTPOS.y})
                                    self.myhead.solders:moveForward(mhx,mhy)
                                    self.mymid.solders:moveForward(mmx,mmy)
                                    self.myfront.solders:moveForward(mfx,mfy)
                                    self.enehead.solders:moveForward(ehx,ehy)
                                    self.enemid.solders:moveForward(emx,emy)
                                    self.enefront.solders:moveForward(efx,efy)
                                end
                                return true
                              end)

   self.lable2=cc.ui.UILabel.new({--����
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
                                    self.myfront.solders:attack(self.myfront.solders:getPortPos(),self.enefront.solders:getPortPos())
                                    self.enehead.solders:attack()
                                    self.enemid.solders:attack()
                                    self.enefront.solders:attack(self.enefront.solders:getPortPos(),self.myfront.solders:getPortPos())
                                end
                                return true
                              end)

   self.lable3=cc.ui.UILabel.new({--����
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

   self.lable4=cc.ui.UILabel.new({--��
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

   self.lable5=cc.ui.UILabel.new({--����
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

        self.lable6=cc.ui.UILabel.new({--��ɷ���
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

       self.lable6=cc.ui.UILabel.new({--���Ш��
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

        self.lable9=cc.ui.UILabel.new({
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

       self.lable10=cc.ui.UILabel.new({--���Ш��
        text='solderneverdie',
        x=display.width-300,
        y=display.height-450,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self.myhead.solders:solderNeverDie(math.random(1,3))
                                    self.mymid.solders:solderNeverDie(math.random(1,3))
                                    self.myfront.solders:solderNeverDie(math.random(1,3))
                                    self.enehead.solders:solderNeverDie(math.random(1,3))
                                    self.enemid.solders:solderNeverDie(math.random(1,3))
                                    self.enefront.solders:solderNeverDie(math.random(1,3))
                                end
                                return true
                              end)

        self.button1=cc.ui.UIPushButton.new("solder.png")
        :pos(display.width-300,display.height-500)
        :onButtonPressed(function (event)
            self.myhead.card:attack()
            self.enefront.card:attack()
            --return true
        end)
        :onButtonRelease(function(event)
            self.myhead.card:back()
            self.enefront.card:back()
            
        end)
        :addTo(self)

       self.lable10=cc.ui.UILabel.new({
        text='getready',
        x=display.width-300,
        y=display.height-550,
        size=32})
        :addTo(self)
        :setTouchEnabled(true)
        :addNodeEventListener(cc.NODE_TOUCH_EVENT,
                              function(event)
                                if event.name=='ended' then
                                    self:getReady()
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

return Game