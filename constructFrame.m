function ocolor=constructFrame(X,Y,color,P,center,angle)
%% written by Muhammet Balcilar, France
% all rights reserved

my=center(1);
mx=center(2);

N=size(P,1);
M=size(P,2);

R=color(1)*ones(size(angle));
G=color(2)*ones(size(angle));
B=color(3)*ones(size(angle));

%ocolor=repmat(color,[size(angle,1) 1]);
PR=P(:,:,1);
PG=P(:,:,2);
PB=P(:,:,3);


yxY =Y-my;
yxX =X-mx;

dist=sqrt(yxY.^2+yxX.^2);
ang=atan2(yxY,yxX)-angle;
yyxY=sin(ang).*dist;
yyxX=cos(ang).*dist;

yyxY=round(yyxY+my);
yyxX=round(yyxX+mx);

yI=(yyxX-1)*N+yyxY;

I=find(yyxY>0 & yyxY<=M & yyxX>0 & yyxX<=N);

II=find(PB(yI(I))<100);

R(I(II))=PR(yI(I(II)));
G(I(II))=PG(yI(I(II)));
B(I(II))=PB(yI(I(II)));

R=mean(R,3);
G=mean(G,3);
B=mean(B,3);

ocolor=R;
ocolor(:,:,2)=G;
ocolor(:,:,3)=B;

