local Battle = class("Battle")

Battle.SOLDER_TYPE_HORSE=1
Battle.SOLDER_TYPE_ARCHER=2
Battle.SOLDER_TYPE_INFANTRY=3

function Battle:ctor()
    --卡牌
    self.battlecard={}
    --卡牌初始化
    self:initCard()
    --战报，共8回合
    self.bettlereport={
        round0={},
        round1={
            attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enemid=-450,enefront=-524,myhead=0,myfront=60},
                                     atktype2='normal',atkto2={enemid=-345}},
            attack2={atkfrom='myhead',atktype1='jianlan',atkto1={enefront=-193,enemid=-891},
                                      atktype2='normal',atkto2={enemid=-439}},
            attack3={atkfrom='myfront',atktype1='normal',atkto1={enehead=-476}},
            attack4={atkfrom='enehead',atktype1='normal',atkto1={myhead=-212}},
            attack5=nil,
            attack6=nil
                },
        round2=nil,
        round3=nil,
        round4=nil,
        round5=nil,
        round6=nil,
        round7=nil,
        round8=nil}
--    --战斗，生成战报
--    self:startBattle()
end

function Battle:initCard()
    self.battlecard={myhead={typ=Battle.SOLDER_TYPE_HORSE,hp=4500,cardname='mycard1.png',atk,def,pos,speed},
                     mymid={typ=Battle.SOLDER_TYPE_INFANTRY,hp=5400,cardname='mycard2.png',atk,def,pos,speed},
                     myfront={typ=Battle.SOLDER_TYPE_ARCHER,hp=6300,cardname='mycard3.png',atk,def,pos,speed},
                     enehead={typ=Battle.SOLDER_TYPE_ARCHER,hp=3257,cardname='enecard1.png',atk,def,pos,speed},
                     enemid={typ=Battle.SOLDER_TYPE_ARCHER,hp=3257,cardname='enecard2.png',atk,def,pos,speed},
                     enefront={typ=Battle.SOLDER_TYPE_HORSE,hp=3257,cardname='enecard3.png',atk,def,pos,speed}}    
end

--战斗，生成战报
--function Battle:startBattle()
--    for _,bp in pairs(self.bettlereport)do

--    end
--end

function Battle:getCardbyKey(cardkey)
    return self.battlecard[cardkey]
end

--返回战报
function Battle:getReport()
    return self.bettlereport
end

return Battle