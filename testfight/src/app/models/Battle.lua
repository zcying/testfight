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
    self.bettlereport={{round=1,},
                       {round=2,},
                       {round=3,},
                       {round=4,},
                       {round=5,},
                       {round=6,},
                       {round=7,},
                       {round=8,}}
    --战斗，生成战报
    self:startBattle()
end

function Battle:initCard()
    self.battlecard={myhead={typ=Battle.SOLDER_TYPE_HORSE,hp=560,name='mycard1.png',atk,def,pos,speed},
                     mymid={typ=Battle.SOLDER_TYPE_HORSE,hp=600,name='mycard2.png',atk,def,pos,speed},
                     myfront={typ=Battle.SOLDER_TYPE_HORSE,hp=370,name='mycard3.png',atk,def,pos,speed},
                     enehead={typ,hp,atk,def,pos,speed},
                     enemid={typ,hp,atk,def,pos,speed},
                     enefront={typ=Battle.SOLDER_TYPE_HORSE,hp=580,name='enecard3.png',atk,def,pos,speed}}    
end

--战斗，生成战报
function Battle:startBattle()
    for _,bp in pairs(self.bettlereport)do
        
    end
end

function Battle:getCardbyKey(cardkey)
    return self.battlecard[cardkey]
end

--返回战报
function Battle:getReport()
    return self.bettlereport
end

return Battle