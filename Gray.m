clc;               %a*exp(-(x-xo)^2/(2*sigmax^2)-(y-yo)^2/(2*sigmay^2))
clear all;
close all;
format long

pic=imread('160309_Indonesia_3.png');
pic_gray=rgb2gray(pic);
imshow(pic_gray)

pause %find star  
close

prompt = {'x pixel:','y pixel:', 'x length', 'y length'}; 
dlg_title = 'Crop';
num_lines = 1;
defaultans = {'125','112','4','4'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
coo_x=str2num(answer{1});
coo_y=str2num(answer{2});
len_x=str2num(answer{3});
len_y=str2num(answer{4});

star=imcrop(pic_gray,[coo_x coo_y len_x len_y]);

R=star(:,:,:); 

[x,y]=size(R); 
[X,Y]=meshgrid(1:x,1:y);

X=X(:);
Y=Y(:); 
Z=R(:); 

mean_column=mean(star(:,:,:));
a=mean_column(1);
b=mean_column(y);

mean_row=mean(star(1:x,2:y-1,:),2);
c=mean_row(1);
d=mean_row(x);

bg=(a+b+c+d)/4

cftool(X,Y,Z) 

pause() %fit gaussian equation, remember xo's , yo's       
 
prompt = {'Enter xo:','Enter yo:'}; %give output of cftool to calculate x
dlg_title = 'Input results';
num_lines = 1;
defaultans = {'1.1','3.7'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
x=str2double(answer{1});
y=str2double(answer{2});

x_fin=x+coo_x-1 %final results, original photo
y_fin=y+coo_y-1
