local Battle = class("Battle")

Battle.SOLDER_TYPE_HORSE=1
Battle.SOLDER_TYPE_ARCHER=2
Battle.SOLDER_TYPE_INFANTRY=3

function Battle:ctor()
    --卡牌
    self.battlecard={}
    --卡牌初始化
    self:initCard()

--战斗过程，共8回合
--round1~8,战斗回合
--round0，准备阶段
--attack1~6，攻击牌，每回合两边各3张，共6牌
--atkfrom，攻击牌名称
--atktype1~8，攻击/技能类型名，极端情况可以一张牌发动八次，普通攻击/技能
--atkto1~8，该次攻击/技能针对的目标，可以是全场，直接atktoi[x]可以代表卡牌
    self.bettlereport={
        round0={ifwin='win'},
        round1={
            attack1={atkfrom='mymid',atktype1='normal',atkto1={enefront=-487}},
            attack2={atkfrom='myhead',atktype1='normal',atkto1={enefront=-762}},
            attack3={atkfrom='myfront',atktype1='normal',atkto1={enemid=-398}},
            attack4={atkfrom='enefront',atktype1='normal',atkto1={myfront=-2555}},
            attack5={atkfrom='enehead',atktype1='normal',atkto1={myhead=-1333}}         
                },
        round2={
            attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enefront=-529,myhead=0,myfront=555},
                                     atktype2='normal',atkto2={enemid=-344}},
            attack2={atkfrom='myhead',atktype1='normal',atkto1={enefront=-762}},
            attack3={atkfrom='myfront',atktype1='normal',atkto1={enemid=-390}},
            attack4={atkfrom='enefront',atktype1='normal',atkto1={myfront=-2000}},
            attack5={atkfrom='enemid',atktype1='normal',atkto1={mymid=-1300}},
                },
        round3={
            attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enemid=-450,enefront=-524,myhead=0,myfront=200},
                                     atktype2='normal',atkto2={enemid=-345}},
            attack2={atkfrom='myhead',atktype1='jianlan',atkto1={enefront=-193,enemid=-891},
                                      atktype2='normal',atkto2={enemid=-439}},
            attack3={atkfrom='myfront',atktype1='normal',atkto1={enehead=-476}},
            attack4={atkfrom='enehead',atktype1='normal',atkto1={myfront=-1200}}
        },
        round4={
            attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enehead=-502,myhead=0,myfront=500},
                                     atktype2='baozha',atkto2={mymid=164},
                                     atktype3='normal',atkto3={enehead=-405}},
            attack2={atkfrom='myhead',atktype1='normal',atkto1={enehead=-555}},
            attack3={atkfrom='myfront',atktype1='qishe',atkto1={enehead=-371},
                                       atktype2='normal',atkto2={enehead=-469}},
            attack4={atkfrom='enehead',atktype1='normal',atkto1={myfront=-2100}}
        },
        round5={attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enehead=-479,myhead=0}}},
        round6=nil,
        round7=nil,
        round8=nil}
--    --战斗，生成战报
--    self:startBattle()
end

--初始化卡牌，my/ene_head/mid/front,我/敌_大营/中军/前锋，typ兵阵类型，hp，cardname卡图片文件名
function Battle:initCard()
    self.battlecard={myhead={typ=Battle.SOLDER_TYPE_ARCHER,hp=7100,cardname='mycard1.png',atk,def,pos,speed},
                     mymid={typ=Battle.SOLDER_TYPE_ARCHER,hp=7700,cardname='mycard2.png',atk,def,pos,speed},
                     myfront={typ=Battle.SOLDER_TYPE_HORSE,hp=6600,cardname='mycard3.png',atk,def,pos,speed},
                     enehead={typ=Battle.SOLDER_TYPE_HORSE,hp=3257,cardname='enecard1.png',atk,def,pos,speed},
                     enemid={typ=Battle.SOLDER_TYPE_INFANTRY,hp=3257,cardname='enecard2.png',atk,def,pos,speed},
                     enefront={typ=Battle.SOLDER_TYPE_HORSE,hp=3257,cardname='enecard3.png',atk,def,pos,speed}}    
end

function Battle:getCardbyKey(cardkey)
    return self.battlecard[cardkey]
end

--返回战报
function Battle:getReport()
    return self.bettlereport
end

return Battle