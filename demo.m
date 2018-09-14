clear all
clc

%% written by Muhammet Balcilar, France
% all rights reserved


% propeller rpm
rpm=1000;
% frame fps
fps=30;
% total frame number in video
nframe=100;


% pixel shutter time it shows how long does the pixel's taking light takes in unit of iteration.
pshutter=0.3*12520;
% pixel super resolution coef, how many step does the pixel light taking  divided
% in time, 
supres=50;
% initial propeller angle
ang=0;

% propeller image
pr=imread('Input/propeller.jpg');
% propeller center
center=[101 101] ;


m=size(pr,1);
n=size(pr,2);

FC=rpm/(60*fps);
vel=FC*2*pi/(m*n);

zmn=zeros(m,n,supres);

for iter=1:nframe
    iter    
    
    [X Y]=meshgrid(1:n,1:m);
    ocolor=[255 255 255];
    
    zmn(:,:,1)=mod(((Y-1)*n+(X-1))*vel +zmn(end,end,1),2*pi);
    for i=2:supres
        zmn(:,:,i)=zmn(:,:,1)+pshutter*vel/supres*(i-1);
    end       
    
    IMG=constructFrame(X,Y,ocolor,pr,center,zmn);  
    
    V{iter}=IMG;
    figure(1);imshow(uint8(round(IMG)))    
    pause(0.1)
    
end


v = VideoWriter('Output/demo.avi');

open(v)

for i=1:iter
    i
    writeVideo(v,uint8(V{i}));
end
close(v);

    








