--兵阵（部队数量和兵种）初始化
local Solders = class("Solders",function()
		return display.newLayer()
       	end)

Solders.SOLDERS_TYPE_HORSE=1
Solders.SOLDERS_TYPE_ARCHER=2
Solders.SOLDERS_TYPE_INFANTRY=3

local SolderBase=import(".SolderBase")
local SolderHorse=import(".SolderHorse")
local SolderArcher=import(".SolderArcher")
local SolderInfantry=import(".SolderInfantry")
function Solders:ctor(soldernum,myorene,typ,cardname)
    self.soldernum=soldernum    --兵数量
    self.typ=typ                --兵种
    self.myorene=myorene        --我方敌方
    self.cardname=cardname
    self.solders={}             --兵阵
    self.solderspos={}          --单兵初始位置
    self.actionAtc=nil
    self.speed=nil
    self.walktime=nil
    self.atktime=nil
    self.steadytime=nil
    self.portrait=nil           --头像
    self.portpos=nil
    self.attackingcircle=display.newSprite('attacking.png'):align(display.CENTER):addTo(self):setVisible(false)
    self.attackedcircle=display.newSprite('attacked.png'):align(display.CENTER):addTo(self):setVisible(false)
    --self.originpos=nil
    self:initSoldersPos()--初始化点位
    self:initSolders()--初始化兵阵
    self:initPortrait()--初始化小头像
end

function Solders:getSoldernum()
    --self:stop()
    self.soldernum=#(self.solders)
end

function Solders:getType()
    return self.typ
end

function Solders:setOpacity(op)
    for _,k in pairs(self.solders)do 
        k:setOpacity(op)
    end
    self.portrait:setOpacity(op)
end

function Solders:initSoldersPos()
    if self.myorene=='my' then
        --我方方形,最多到32个
        self.rectpos={{0,0},{2,-1},{1,-2},{-1,-1},{-3,0},{-2,1},{-4,2},{-5,1},{-6,0},{-4,-1},
                      {-2,-2},{0,-3},{2,-4},{3,-3},{4,-2},{6,-3},{5,-4},{4,-5},{3,-6},{1,-5},
                      {-1,-4},{-3,-3},{-5,-2},{-7,-1},{-9,0},{-8,1},{-7,2},{-6,3},{-8,4},{-9,3},
                      {-10,2},{-11,1},{-12,0},{-10,-1},{-8,-2},{-6,-3},{-4,-4},{-2,-5},{0,-6},{2,-7},
                      {5,-7},{6,-6},{7,-5},{8,-4}}
        self.attackingcircle:pos(-60,-20):setRotation(30)
        self.attackedcircle:pos(-60,-20):setRotation(30)
    else 
        --敌方方形
        self.rectpos={{0,0},{2,-1},{3,0},{1,1},{-1,2},{-2,1},{-4,2},{-3,3},{-2,4},{0,3},
                      {2,2},{4,1},{6,0},{5,-1},{4,-2},{6,-3},{7,-2},{8,-1},{9,0},{7,1},
                      {5,2},{3,3},{1,4},{-1,5},{-3,6},{-4,5},{-5,4},{-6,3},{-8,4},{-7,5},
                      {-6,6},{-5,7},{-4,8},{-2,7},{0,6},{2,5},{4,4},{6,3},{8,2},{10,1},
                      {11,-1},{10,-2},{9,-3},{8,-4}}
        self.attackingcircle:pos(30,40):setRotation(30)
        self.attackedcircle:pos(30,40):setRotation(30)
    end
    for i=1,#self.rectpos do
        self.rectpos[i][1]=self.rectpos[i][1]*15
        self.rectpos[i][2]=self.rectpos[i][2]*9
    end

    if self.myorene=='my'then
        --我方楔形，最多到32个
        self.wedgepos={{0,0},{1,-2},{0,-3},{-1,-1},{-4,-1},{-3,0},{-6,0},{-7,-1},{-8,-2},{-5,-2},
                       {-2,-2},{-1,-4},{0,-6},{1,-5},{2,-4},{3,-6},{2,-7},{1,-8},{0,-9},{-1,-7},
                       {-2,-5},{-3,-3},{-6,-3},{-9,-3},{-12,-3},{-11,-2},{-10,-1},{-9,0},{-12,0},{-13,-1},
                       {-14,-2},{-15,-3},{-16,-4},{-13,-4},{-10,-4},{-7,-4},{-4,-4},{-3,-6},{-2,-8},{-1,-10},
                       {1,-11},{2,-10},{3,-9},{4,-8}}
    else
        --敌方楔形
        self.wedgepos={{0,0},{3,0},{4,1},{1,1},{0,3},{-1,2},{-2,4},{-1,5},{0,6},{1,4},
                       {2,2},{5,2},{8,2},{7,1},{6,0},{9,0},{10,1},{11,2},{12,3},{9,3},
                       {6,3},{3,3},{2,5},{1,7},{0,9},{-1,8},{-2,7},{-3,6},{-4,8},{-3,9},
                       {-2,10},{-1,11},{0,12},{1,10},{2,8},{3,6},{4,4},{7,4},{10,4},{13,4},
                       {15,3},{14,2},{13,1},{12,0}}
    end
    for i=1,#self.wedgepos do
        self.wedgepos[i][1]=self.wedgepos[i][1]*15
        self.wedgepos[i][2]=self.wedgepos[i][2]*9 
    end  

    --钳形
    self.pincer={}
end

--初始化兵阵，取得初始点位
function Solders:initSolders()
    for i=1,self.soldernum do
        if self.typ==Solders.SOLDERS_TYPE_HORSE then
            --printLog(self.myorene)
            self.solders[i]=SolderHorse.new(self.myorene)
        elseif self.typ==Solders.SOLDERS_TYPE_ARCHER then 
            self.solders[i]=SolderArcher.new(self.myorene)
        else
            self.solders[i]=SolderInfantry.new(self.myorene)
        end
--        --按公式排布
--        local x=-30*(1+(math.ceil((i+2)/4-1)%2))
--        local y=30*(1-2*(i%2))*(math.ceil((i+4)/4)-1)

        --按楔形排
        local x=self.wedgepos[i][1]
        local y=self.wedgepos[i][2]
        --按方形排
--        local x=self.rectpos[i][1]
--        local y=self.rectpos[i][2]
        if self.myorene=='my' then
            self.solders[i]:align(display.RIGHT_CENTER)
        else 
            self.solders[i]:align(display.CENTER_BOTTOM)
        end
        self.solders[i]:pos(x,y)
                       :addTo(self)
                       :steady()
--        local x=self.wedgepos[i][1]
--        local y=self.wedgepos[i][2]
        local x=self.rectpos[i][1]
        local y=self.rectpos[i][2]
        self.solderspos[i]=cc.p(x,y)
    end
    self.speed=self.solders[1]:getSpeed()
    self.walktime=self.solders[1].walktime
    self.atktime=self.solders[1].atktime
    self.steadytime=self.solders[1].steadytime
end

function Solders:initPortrait()
    self.portrait=display.newSprite(self.cardname)
                  :scale(0.4)
                  :pos(-40,0)
                  :addTo(self)
    if self.myorene=='ene' then
        self.portrait:pos(0,40)
    end
    self.portpos=cc.p(self.portrait:getPosition())      
end

function Solders:showAttacking()--显示攻击
    self:portraitUp()
    self.attackingcircle:setVisible(true)
    self:setOpacity(255)
end

function Solders:endAttacking()--结束攻击
    self:portraitDown()
    self.attackingcircle:setVisible(false)
    self:setOpacity(150)
end

function Solders:showAttacked(v)--显示被攻击
    self:portraitUp()
    self.attackedcircle:setVisible(true)
    self:setOpacity(255)
    local atk=v.atk
    if atk then
        local atklabel=cc.ui.UILabel.new({
            x=self.portpos.x,
            y=self.portpos.y,
            font = 'Arial',
            size=20
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

function Solders:endAttacked()--结束被攻击
    self:portraitDown()
    self.attackedcircle:setVisible(false)
    self:setOpacity(150)
end

function Solders:showBuff()

end

function Solders:endBuff()

end

--返回一次走路时间
function Solders:getWalktime()
    return self.walktime
end

--返回一次攻击时间
function Solders:getAtktime()
    return self.atktime
end

--返回一次待命动画时间
function Solders:getSteadytime()
    return self.steadytime
end

--每回合结束兵阵可以重新编队，向原点收缩
function Solders:reformat()
    self:getSoldernum()
--    if self.soldernum<=1 then
--        return
--    end
    for i=1,self.soldernum do
        local oldposx,oldposy=self.solders[i]:getPosition()
        local newposx=self.solderspos[i].x
        local newposy=self.solderspos[i].y
        local distance=math.sqrt((oldposx-newposx)*(oldposx-newposx)+(oldposy-newposy)*(oldposy-newposy))
        self.solders[i]:walk()
        transition.moveTo(self.solders[i],{time=distance/self.speed,
                             x=newposx,
                             y=newposy,
                             onComplete=function()
                                 self.solders[i]:steady()
                             end
                            })
    end
end

function Solders:portraitUp()
    self.portrait:scale(0.5)
end

function Solders:portraitDown()
    self.portrait:scale(0.4)
end

--变方形并待命
function Solders:toRect()
    if self:getSoldernum()==0 then return end
    for i=1,self.soldernum do
        local oldposx,oldposy=self.solders[i]:getPosition()
        local newposx=self.rectpos[i][1]
        local newposy=self.rectpos[i][2]
        local distance=math.sqrt((oldposx-newposx)*(oldposx-newposx)+(oldposy-newposy)*(oldposy-newposy))
        self.solders[i]:walk()
        transition.moveTo(self.solders[i],{time=distance/self.speed,
                             x=newposx,
                             y=newposy,
                             onComplete=function()
                                 self.solders[i]:steady()
                             end
                            })   
    end
end

--变方形并永远攻击
function Solders:toRectandAtk(posfrom,posto)
    self:getSoldernum()
    for i=1,self.soldernum do
        local oldposx,oldposy=self.solders[i]:getPosition()
        local newposx=self.rectpos[i][1]
        local newposy=self.rectpos[i][2]
        local distance=math.sqrt((oldposx-newposx)*(oldposx-newposx)+(oldposy-newposy)*(oldposy-newposy))
        self.solders[i]:walk()
        transition.moveTo(self.solders[i],{time=distance/self.speed,
                             x=newposx,
                             y=newposy,
                             onComplete=function()
                                 self.solders[i]:attackForever()
                             end
                            })   
    end
end

--变楔形
function Solders:toWedge()
    self:getSoldernum()
    for i=1,self.soldernum do
        local oldposx,oldposy=self.solders[i]:getPosition()
        local newposx=self.wedgepos[i][1]
        local newposy=self.wedgepos[i][2]
        local distance=math.sqrt((oldposx-newposx)*(oldposx-newposx)+(oldposy-newposy)*(oldposy-newposy))
        self.solders[i]:walk()
        transition.moveTo(self.solders[i],{time=distance/self.speed,
                             x=newposx,
                             y=newposy,
                             onComplete=function()
                                 self.solders[i]:steady()
                             end
                            })   
    end
end

--兵阵前进
function Solders:moveForward(px,py,posfrom,posto)
    --if self.handle==nil then
        --self:reformat()
        for _,k in pairs(self.solderspos) do--修正原始点位
            k.x=k.x+px
            k.y=k.y+py
        end
        for i=1,#self.rectpos do
            self.rectpos[i][1]=self.rectpos[i][1]+px
            self.rectpos[i][2]=self.rectpos[i][2]+py
            self.wedgepos[i][1]=self.wedgepos[i][1]+px
            self.wedgepos[i][2]=self.wedgepos[i][2]+py
        end
        local ltime=math.sqrt(px*px+py*py)/self.speed
        transition.moveBy(self.portrait,{time=ltime,x=px,y=py,onComplete=function()
                    self.portpos=cc.p(self.portrait:getPosition())
                    --printLog('portraitpos',self.portpos.x..','..self.portpos.y)
        end})
        for _,k in pairs(self.solders) do--整体前进
            k:walk()
            k.moveAciton=transition.moveBy(k,{time=ltime,
                                              x=px,y=py,
                                              onComplete=function()
                                                 k:attackForever()
                                              end
                                             })
                :setTag(1)
        end
        transition.moveBy(self.attackedcircle,{time=ltime,x=px,y=py})
        transition.moveBy(self.attackingcircle,{time=ltime,x=px,y=py})
end

function Solders:getPortPos()
    self.portpos=cc.p(self.portrait:getPosition())   
    return self.portpos
end

--停止所有动作
function Solders:stop()
    for _,k in pairs(self.solders) do
        k:stop()
        k:stopActionByTag(1)
    end
end

--待命
function Solders:steady()
    for _,k in pairs(self.solders) do
        k:steady()
    end
end

--一次攻击
function Solders:attack(posfrom,posto)
    for _,k in pairs(self.solders)do
        k:attack(posfrom,posto)
    end
end

--永远攻击动作
function Solders:attackForever()
    for _,k in pairs(self.solders)do
        k:attackForever()
    end
end

--死兵，随机位置死
function Solders:die(deadnum)
    if deadnum<=0 then
        return
    end
    self:getSoldernum()
    if self.soldernum-deadnum<0 then
        return
    end
    local deadkeys=self:getDeadkey(deadnum)
    for i=deadnum,1,-1 do
        local deadsolder=self.solders[deadkeys[i]]
        local sprite=display.newSprite(deadsolder:getDeadName())
        if self.typ==Solders.SOLDERS_TYPE_HORSE then
            sprite:scale(0.5)
        end
        sprite:pos(deadsolder:getPosition())
              :addTo(self)
        self:removeChild(self.solders[deadkeys[i]])
        transition.fadeOut(sprite,{time=0.5,
                                   delay=0.5,
                                   onComplete=function()
                                       sprite:removeSelf()
                                       if self.soldernum==deadnum then
                                           self.portrait:setVisible(false)
                                       end
                                       --table.remove(self.solders,deadkeys[i])
                                       --self.soldernum=#(self.solders)
                                       --printLog(self.soldernum)
                                   end})
    table.remove(self.solders,deadkeys[i])
    end
end

--逃兵，逃最后两个意思一下，其余逃兵按死亡展现
function Solders:runaway(num)
    self:getSoldernum()
    if self.soldernum-num<=0 or num<=0 then
        return
    end
    local runx=-30
    local runy=-50
    if self.myorene=='ene'then
        runx=30
        runy=50
    end
    if num==1 then
        self.solders[self.soldernum]:runaway()
        transition.moveBy(self.solders[self.soldernum],{time=65/self.solders[self.soldernum].speed,
                                           x=runx,
                                           y=runy,
                                           onComplete=function()
                                               self:removeChild(self.solders[self.soldernum])
                                               table.remove(self.solders,self.soldernum)
                                               --transition.fadeOut(self.solders[runkey],{time=1})
                                           end})
    else
        self.solders[self.soldernum]:runaway()
        self.solders[self.soldernum-1]:runaway()
        transition.moveBy(self.solders[self.soldernum],{time=65/self.solders[self.soldernum].speed,
                                           x=runx,
                                           y=runy,
                                           onComplete=function()
                                               self:removeChild(self.solders[self.soldernum])
                                               table.remove(self.solders,self.soldernum)
                                               --transition.fadeOut(self.solders[runkey],{time=1})
                                           end})
        transition.moveBy(self.solders[self.soldernum-1],{time=65/self.solders[self.soldernum-2].speed,
                                           x=runx,
                                           y=runy,
                                           onComplete=function()
                                               self:removeChild(self.solders[self.soldernum-1])
                                               table.remove(self.solders,self.soldernum-1)
                                               --self.soldernum=#(self.solders)
                                               --printLog(self.soldernum)
                                               self:die(num-2)
                                               --transition.fadeOut(self.solders[runkey],{time=1})
                                           end})    
    end
end

--英雄不朽
function Solders:solderNeverDie(num)
    self:getSoldernum()
    for i=self.soldernum+1,self.soldernum+num do
        if self.typ==Solders.SOLDERS_TYPE_HORSE then
            self.solders[i]=SolderHorse.new(self.myorene)
        elseif self.typ==Solders.SOLDERS_TYPE_ARCHER then 
            self.solders[i]=SolderArcher.new(self.myorene)
        else
            self.solders[i]=SolderInfantry.new(self.myorene)
        end
        local x=self.rectpos[i][1]
        local y=self.rectpos[i][2]
        self.solders[i]:align(display.CENTER)
                       :pos(x,y)
                       :addTo(self)
                       :attackForever()
--        local x=self.wedgepos[i][1]
--        local y=self.wedgepos[i][2]
--        local x=self.rectpos[i][1]
--        local y=self.rectpos[i][2]
        self.solderspos[i]=cc.p(x,y)
    end
end

--根据死兵数随机产生相应数量的死兵点位
function Solders:getDeadkey(dienum)
    self:getSoldernum()
    local allsolders={}
    local deadkeys={}
    --math.randomseed(os.time())
    for i=1,self.soldernum do
        allsolders[i]=i
    end
    for i=1,dienum do
        local key=math.random(1,#allsolders)
        deadkeys[i]=allsolders[key]
        table.remove(allsolders,key)
    end
    table.sort(deadkeys)
    return deadkeys
end

return Solders