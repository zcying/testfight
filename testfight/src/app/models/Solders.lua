--���󣨲��������ͱ��֣���ʼ��
local Solders = class("Solders",function()
		return display.newLayer()
       	end)
Solders.SOLDERS_TYPE_HORSE=1
Solders.SOLDERS_TYPE_ARCHER=2
Solders.SOLDERS_TYPE_INFANTRY=3

local SolderBase=import(".SolderBase")
local SolderHorse=import(".SolderHorse")
function Solders:ctor(soldernum)
    self.soldernum=soldernum    --������
    self.solders={}             --����
    self.solderspos={}          --����ʽ���㵥����ʼλ��
    self.speed=nil
    self.solderstype=Solders.SOLDERS_TYPE_HORSE --�������
    self:initSoldersPos()
    self:initSolders()--��ʼ������
    
end

function Solders:getSoldernum()
    --self:stop()
    self.soldernum=#(self.solders)
end

function Solders:getType()
    return self.solderstype
end

function Solders:initSoldersPos()
    --����,��ൽ32��
    self.rectpos={{0,0},{2,-1},{1,-2},{-1,-1},{-3,0},{-2,1},{-4,2},{-5,1},{-6,0},{-4,-1},
                   {-2,-2},{0,-3},{2,-4},{3,-3},{4,-2},{6,-3},{5,-4},{4,-5},{3,-6},{1,-5},
                   {-1,-4},{-3,-3},{-5,-2},{-7,-1},{-9,0},{-8,1},{-7,2},{-6,3},{-8,4},{-9,3},
                   {-10,2},{-11,1}}
    for i=1,#self.rectpos do
        self.rectpos[i][1]=self.rectpos[i][1]*20
        self.rectpos[i][2]=self.rectpos[i][2]*20
    end

    --Ш�Σ���ൽ32��
    self.wedgepos={{0,0},{1,-2},{0,-3},{-1,-1},{-4,-1},{-3,0},{-6,0},{-7,-1},{-8,-2},{-5,-2},
                  {-2,-2},{-1,-4},{0,-6},{1,-5},{2,-4},{3,-6},{2,-7},{1,-8},{0,-9},{-1,-7},
                  {-2,-5},{-3,-3},{-6,-3},{-9,-3},{-12,-3},{-11,-2},{-10,-1},{-9,0},{-12,0},{-13,-1},
                  {-14,-2},{-15,-3}}
    for i=1,#self.wedgepos do
        self.wedgepos[i][1]=self.wedgepos[i][1]*20
        self.wedgepos[i][2]=self.wedgepos[i][2]*20  
    end  

    --ǯ��
    self.pincer={}


end

--��ʼ������ȡ�ó�ʼ��λ
function Solders:initSolders()
    for i=1,self.soldernum do
        --self.solders[i]=display.newSprite(SolderBase:getSolderName())
        self.solders[i]=SolderHorse.new()
        :align(display.CENTER)

--        --����ʽ�Ų�
--        local x=-30*(1+(math.ceil((i+2)/4-1)%2))
--        local y=30*(1-2*(i%2))*(math.ceil((i+4)/4)-1)

--        --��Ш����
--        local x=self.wedgepos[i][1]
--        local y=self.wedgepos[i][2]
        --��������
        local x=self.rectpos[i][1]
        local y=self.rectpos[i][2]
        self.solders[i]:pos(x,y)
                       :addTo(self)
                       :walk()
--        local x=self.wedgepos[i][1]
--        local y=self.wedgepos[i][2]
--        local x=self.rectpos[i][1]
--        local y=self.rectpos[i][2]
        self.solderspos[i]=cc.p(x,y)
    end
    self.speed=self.solders[1]:getSpeed()
end

--ÿ�غϽ�������������±�ӣ���ԭ������
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
--                             onComplete=function()
--                                 self.solders[i]:stop()
--                             end
                            })
    end
end

function Solders:toRect()
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
--                             onComplete=function()
--                                 self.solders[i]:stop()
--                             end
                            })   
    end
end

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
--                             onComplete=function()
--                                 self.solders[i]:stop()
--                             end
                            })   
    end
end

--����ǰ��
function Solders:moveForward(px,py)
    --if self.handle==nil then
        self:reformat()
        for _,k in pairs(self.solderspos) do--����ԭʼ��λ
            k.x=k.x+px
            k.y=k.y+py
        end
        for i=1,#self.rectpos do
            self.rectpos[i][1]=self.rectpos[i][1]+px
            self.rectpos[i][2]=self.rectpos[i][2]+py
            self.wedgepos[i][1]=self.wedgepos[i][1]+px
            self.wedgepos[i][2]=self.wedgepos[i][2]+py
        end
        for _,k in pairs(self.solders) do--����ǰ��
            k.moveAciton=transition.moveBy(k,{time=math.sqrt(px*px+py*py)/self.speed,
                                              x=px,y=py,
--                                              onComplete=function()
--                                                 k:stop()
--                                              end
                                             })
                :setTag(1)
            k:walk()
        end
    --end
end

--ֹͣ���ж���
function Solders:stop()
    for _,k in pairs(self.solders) do
        k:stop()
        k:stopActionByTag(1)
    end
end

function Solders:attack()
    for _,k in pairs(self.solders)do
        k:attack()
    end
end

--���������λ����
function Solders:die(deadnum)
    if deadnum<=0 then
        return
    end
    self:getSoldernum()
    if self.soldernum-deadnum<=0 then
        return
    end
    local deadkeys=self:getDeadkey(deadnum)
    for i=deadnum,1,-1 do
        local deadsolder=self.solders[deadkeys[i]]
        local sprite=display.newSprite(deadsolder:getDeadName())
                     :pos(deadsolder:getPosition())
                     :addTo(self)
        self:removeChild(self.solders[deadkeys[i]])
        transition.fadeOut(sprite,{time=0.5,
                                   delay=0.5,
                                   onComplete=function()
                                       sprite:removeSelf()
                                       --table.remove(self.solders,deadkeys[i])
                                       --self.soldernum=#(self.solders)
                                       --printLog(self.soldernum)
                                   end})
    table.remove(self.solders,deadkeys[i])
    end
end



--��ʵ����������һ����
function Solders:runawayAll(runnum)
    if runnum<=0 then
        return
    end
--    self:getSoldernum()
--    if self.soldernum-runnum<=0 then
--        return
--    end
--    local runkeys=self:getDeadkey(runnum)
--    local sprite={}
--    for i=runnum,1,-1 do
--        local x,y=self.solders[runkeys[i]]:getPosition()
--        self:removeChild(self.solders[runkeys[i]])
--        sprite[i]=SolderHorse.new()
--                     :align(display.CENTER,x,y)
--                     :walk()
--        transition.moveBy(sprite[i],{time=65/sprite[i].getSpeed(),
--                                           x=-30,
--                                           y=-60,
--                                           onComplete=function()
--                                               sprite[i]:removeSelf()
--                                               table.remove(self.solders,runkeys[i])
--                                               --transition.fadeOut(self.solders[runkey],{time=1})
--                                           end})
--    end
end

--�ӱ��������������˼һ�£������ӱ�������չ��
function Solders:runaway(num)
    self:getSoldernum()
    if self.soldernum-num<=0 or num<=0 then
        return
    end
    if num==1 then
        self.solders[self.soldernum]:runaway()
        transition.moveBy(self.solders[self.soldernum],{time=65/self.solders[self.soldernum].speed,
                                           x=-30,
                                           y=-60,
                                           onComplete=function()
                                               self:removeChild(self.solders[self.soldernum])
                                               table.remove(self.solders,self.soldernum)
                                               --transition.fadeOut(self.solders[runkey],{time=1})
                                           end})
    else
        self.solders[self.soldernum]:runaway()
        self.solders[self.soldernum-1]:runaway()
        transition.moveBy(self.solders[self.soldernum],{time=65/self.solders[self.soldernum].speed,
                                           x=-30,
                                           y=-60,
                                           onComplete=function()
                                               self:removeChild(self.solders[self.soldernum])
                                               table.remove(self.solders,self.soldernum)
                                               --transition.fadeOut(self.solders[runkey],{time=1})
                                           end})
        transition.moveBy(self.solders[self.soldernum-1],{time=65/self.solders[self.soldernum-2].speed,
                                           x=-30,
                                           y=-60,
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

--�������������������Ӧ������������λ
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