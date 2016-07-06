local Battle = class("Battle")

Battle.SOLDER_TYPE_HORSE=1
Battle.SOLDER_TYPE_ARCHER=2
Battle.SOLDER_TYPE_INFANTRY=3

function Battle:ctor()
    --����
    self.battlecard={}
    --���Ƴ�ʼ��
    self:initCard()

--ս�����̣���8�غ�
--round1~8,ս���غ�
--round0��׼���׶�
--attack1~6�������ƣ�ÿ�غ����߸�3�ţ���6��
--atkfrom������������
--atktype1~8������/�����������������������һ���Ʒ����˴Σ���ͨ����/����
--atkto1~8���ôι���/������Ե�Ŀ�꣬������ȫ����ֱ��atktoi[x]���Դ�����
    self.bettlereport={
        round0={},
        round1={
            attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enemid=-250,enefront=-124,myhead=200,myfront=120},
                                     atktype2='normal',atkto2={enemid=-145}},
            attack2={atkfrom='myhead',atktype1='jianlan',atkto1={enefront=-293,enemid=-391},
                                      atktype2='normal',atkto2={enemid=-539}},
            attack3={atkfrom='myfront',atktype1='normal',atkto1={enehead=-976}},
            attack4={atkfrom='enehead',atktype1='normal',atkto1={myhead=-688}},
            attack5={atkfrom='enefront',atktype1='normal',atkto1={myfront=-288}},
            attack6={atkfrom='enemid',atktype1='normal',atkto1={mymid=-488}}
                },
        round2={
            attack1={atkfrom='mymid',atktype1='diewuhonglian',atkto1={enemid=-250,enefront=-124,myhead=200,myfront=120},
                                     atktype2='normal',atkto2={enemid=-145}},
            attack2={atkfrom='myhead',atktype1='jianlan',atkto1={enefront=-293,enemid=-391},
                                      atktype2='normal',atkto2={enemid=-539}},
            attack3={atkfrom='myfront',atktype1='normal',atkto1={enehead=-276}},
            attack4={atkfrom='enehead',atktype1='normal',atkto1={mymid=-588}},
            attack5={atkfrom='enefront',atktype1='normal',atkto1={myhead=-888}},
            attack6={atkfrom='enemid',atktype1='normal',atkto1={mymid=-488}}
        },
        round3=nil,
        round4=nil,
        round5=nil,
        round6=nil,
        round7=nil,
        round8=nil}
--    --ս��������ս��
--    self:startBattle()
end

--��ʼ�����ƣ�my/ene_head/mid/front,��/��_��Ӫ/�о�/ǰ�棬typ�������ͣ�hp��cardname��ͼƬ�ļ���
function Battle:initCard()
    self.battlecard={myhead={typ=Battle.SOLDER_TYPE_ARCHER,hp=2700,cardname='mycard1.png',atk,def,pos,speed},
                     mymid={typ=Battle.SOLDER_TYPE_ARCHER,hp=2100,cardname='mycard2.png',atk,def,pos,speed},
                     myfront={typ=Battle.SOLDER_TYPE_HORSE,hp=1400,cardname='mycard3.png',atk,def,pos,speed},
                     enehead={typ=Battle.SOLDER_TYPE_HORSE,hp=1900,cardname='enecard1.png',atk,def,pos,speed},
                     enemid={typ=Battle.SOLDER_TYPE_ARCHER,hp=2888,cardname='enecard2.png',atk,def,pos,speed},
                     enefront={typ=Battle.SOLDER_TYPE_INFANTRY,hp=1500,cardname='enecard3.png',atk,def,pos,speed}}    
end

function Battle:getCardbyKey(cardkey)
    return self.battlecard[cardkey]
end

--����ս��
function Battle:getReport()
    return self.bettlereport
end

return Battle