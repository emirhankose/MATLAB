clc;
clear;
format long;
file=fopen('current1.dat','r');  %files have opened..
file2=fopen('current2.dat','r');
file3=fopen('current3.dat','r');
file4=fopen('current4.dat','r');
current1=fscanf(file,'%f %f',[2 inf]);   %files have read...
current2=fscanf(file2,'%f %f',[2 inf]);
current3=fscanf(file3,'%f %f',[2 inf]);
current4=fscanf(file4,'%f %f',[2 inf]);

%current1 forward-backward-midpoint
h=current1(1,2)-current1(1,1);  % change of time of current1.dat
fdrv1=[];                   
for i=2:size(current1,2)             % size(current1,2)=9   so i=1 from to 9;
  der=(current1(2,i)-current1(2,i-1))/h;
  fdrv1(i)=der;
end
fV_arr1=[];
L=0.98;
R=14.2;

for i=2:1:size(current1,2)
    Voltage=(L*fdrv1(i))+(R*current1(2,i-1));
    fV_arr1(i)=Voltage;
end
fprintf('voltages of forward difference (current1.dat)\n');
volt=fV_arr1';
time=current1(1,:)';
volt_t=table(time,volt);

h=current1(1,2)-current1(1,1);
bdrv1=[];
for i=2:size(current1,2)
  der=(current1(2,i)-current1(2,i-1))/h;
  bdrv1(i)=der;
end

bV_arr1=[];
L=0.98;
R=14.2;
for i=2:size(current1,2)
    Voltage=(L*bdrv1(i))+(R*current1(2,i));
    bV_arr1(i)=Voltage;
end
fprintf('voltages of backward difference (current1.dat)\n');
volt=bV_arr1';
time=current1(1,:)';
volt_t=table(time,volt)

h=current1(1,2)-current1(1,1);
mdrv1=[];
mdrv1(1)=(-(3*current1(2,1))+(4*current1(2,2))-current1(2,3))/(2*h);
mdrv1(size(current1,2))=(current1(2,1)-4*current1(2,2)+(3*current1(2,3)))/(2*h);
for i=2:size(current1,2)-1
    der=(current1(2,i+1)-current1(2,i-1))/(2*h);
    mdrv1(i)=der;
end
mV_arr1=[];
L=0.98;
R=14.2;
mV_arr1(1)=(L*mdrv1(1))+(R*current1(2,1));
mV_arr1(size(current1,2))=(L*mdrv1(size(current1,2)))+(R*current1(2,size(current1,2)));
for i=2:1:size(current1,2)-1
    Voltage=(L*mdrv1(i))+(R*current1(2,i));
    mV_arr1(i)=Voltage;
end
fprintf('voltages of midpoint (current1.dat)\n');

volt=mV_arr1';
time=current1(1,:)';
volt_t=table(volt,time);
figure (1)
plot(current1(1,2:end),fdrv1(2:end),current1(1,2:end),bdrv1(2:end),current1(1,1:end-1),mdrv1(1:end-1))
legend('forward cur','backward cur','midpoint');
figure (2)
loglog(current1(1,2:end),fV_arr1(2:end),current1(1,2:end),bV_arr1(2:end),current1(1,1:end-1),mV_arr1(1:end-1));
legend('forward','backward','midpoint');
grid on 
xlabel('time(t)');
ylabel('voltage');

% current2 forward-backward-midpoint
h=current2(1,2)-current2(1,1); %change of time of curren2.dat
fdrv2=[];

for i=2:size(current2,2)   %size(current2,2) gives you count of the currents.. so it is 13
  der=(current2(2,i)-current2(2,i-1))/h;   %derivative of current has calculated
  fdrv2(i)=der;
end
fV_arr2=[];
L=0.98;
R=14.2;
for i=2:1:size(current2,2)
    Voltage=(L*fdrv2(i))+(R*current2(2,i-1));  %voltage has calculated
    fV_arr2(i)=Voltage;
end
fprintf('voltages of forward difference (current2.dat)\n');
volt=fV_arr2';
time=current2(1,:)';
volt_t=table(time,volt)

h=current2(1,2)-current2(1,1);%0.05
bdrv2=[];

for i=2:size(current2,2)
  der=(current2(2,i)-current2(2,i-1))/h;
  bdrv2(i)=der;
end
bV_arr2=[];
L=0.98;
R=14.2;
for i=2:1:size(current2,2)
    Voltage=(L*bdrv2(i))+(R*current2(2,i));
    bV_arr2(i)=Voltage;
end
fprintf('voltages of backward difference (current2.dat)\n');
volt=bV_arr2';
time=current2(1,:)';
volt_t=table(time,volt)

h=0.050;
mdrv2=[];
mdrv2(1)=(-(3*current2(2,1))+(4*current2(2,2))-current2(2,3))/(2*h);
mdrv2(size(current2,2))=(current2(2,1)-4*current2(2,2)+3*current2(2,3))/(2*h);
for i=2:size(current2,2)-1
    der=(current2(2,i+1)-current2(2,i-1))/(2*h);
    mdrv2(i)=der;
end
mV_arr2=[];
L=0.98;
R=14.2;
mV_arr2(1)=(L*mdrv2(1))+(R*current2(2,1));
mV_arr2(size(current2,2))=(L*mdrv2(size(current2,2)))+(R*current2(2,size(current2,2)));
for i=2:size(current2,2)-1
    Voltage=(L*mdrv2(i))+(R*current2(2,i));
    mV_arr2(i)=Voltage;
end
fprintf('voltages of midpoint difference (current2.dat)\n');
volt=mV_arr2';
time=current2(1,:)';
volt_t=table(time,volt);
disp(mV_arr2)
figure (3)
plot(current2(1,2:end),fdrv2(2:end),current2(1,2:end),bdrv2(2:end),current2(1,1:end-1),mdrv2(1:end-1))
legend('forward cur','backward cur','midpoint');
figure(4)
loglog(current2(1,2:end),fV_arr2(2:end),current2(1,2:end),bV_arr2(2:end),current2(1,1:end-1),mV_arr2(1:end-1))
legend('forward','backward','midpoint');
grid on 
xlabel('time(t)');
ylabel('voltage');

%current3.dat
h=current3(1,2)-current3(1,1);
fdrv3=[];

for i=2:size(current3,2)
  der=(current3(2,i)-current3(2,i-1))/h;
  fdrv3(i)=der;
end

fV_arr3=[];
L=0.98;
R=14.2;
for i=2:1:size(current3,2)
    Voltage=(L*fdrv3(i))+(R*current3(2,i-1));
    fV_arr3(i)=Voltage;
end
fprintf('voltages of forward difference (current3.dat)\n');
volt=fV_arr3';
time=current3(1,:)';
volt_t=table(time,volt);

%current3.dat
h=current3(1,2)-current3(1,1); %change of time of current2.dat
bdrv3=[];

for i=2:size(current3,2) %size(current3,2) gives you count of currents..
  der=(current3(2,i)-current3(2,i-1))/h;
  bdrv3(i)=der;
end

bV_arr3=[];
L=0.98;
R=14.2;
for i=2:size(current3,2)
    Voltage=(L*bdrv3(i))+(R*current3(2,i));
    bV_arr3(i)=Voltage;
end
fprintf('voltages of backward difference (current3.dat)\n');
volt=bV_arr3';
time=current3(1,:)';
volt_t=table(time,volt)

h=0.025;
mdrv3=[];
mdrv3(1)=((4*current3(2,2))-(3*current3(2,1))-current3(2,3))/(2*h);
mdrv3(size(current3,2))=((current3(2,1))-(4*current3(2,2))+(3*current3(2,3)))/(2*h);
for i=2:size(current3,2)-1
    der=(current3(2,i+1)-current3(2,i-1))/(2*h);
    mdrv3(i)=der;
end

mV_arr3=[];
L=0.98;
R=14.2;
mV_arr3(1)=(L*mdrv3(1))+(R*current3(2,1));
mV_arr3(size(current3,2))=(L*mdrv3(size(current3,2)))+(R*current3(2,size(current3,2)));
for i=2:size(current3,2)-1
    Voltage=(L*mdrv3(i))+(R*current3(2,i));
    mV_arr3(i)=Voltage;
end
figure (5)
plot(current3(1,2:end),fdrv3(2:end),current3(1,2:end),bdrv3(2:end),current3(1,1:end-1),mdrv3(1:end-1))
legend('forward cur','backward cur','midpoint');
figure(6)
loglog(current3(1,2:end),fV_arr3(2:end),current3(1,2:end),bV_arr3(2:end),current3(1,1:end-1),mV_arr3(1:end-1))
legend('forward','backward','midpoint');
grid on 
xlabel('time(t)');
ylabel('voltage');

fprintf('voltages of midpoint (current3.dat)\n');
volt=mV_arr3';
time=current3(1,:)';
volt_t=table(time,volt)

%current4.dat
h=current4(1,2)-current4(1,1);
fdrv4=[];

for i=2:size(current4,2)
  der=(current4(2,i)-current4(2,i-1))/h;
  fdrv4(i)=der;
end


fV_arr4=[];
L=0.98;
R=14.2;
for i=2:1:size(current4,2)
    Voltage=(L*fdrv4(i))+(R*current4(2,i-1));
    fV_arr4(i)=Voltage;
end
fprintf('voltages of forward difference (current4.dat)\n');
volt=fV_arr4';
time=current4(1,:)';
volt_t=table(time,volt)

h=current4(1,2)-current4(1,1);
bdrv4=[];

for i=2:size(current4,2)
  der=(current4(2,i)-current4(2,i-1))/h;
  bdrv4(i)=der;
end

bV_arr4=[];
L=0.98;
R=14.2;
for i=2:1:size(current4,2)
    Voltage=(L*bdrv4(i))+(R*current4(2,i));
    bV_arr4(i)=Voltage;
end
fprintf('voltages of backward difference (current4.dat)\n');
volt=bV_arr4';
time=current4(1,:)';
volt_t=table(time,volt)
h=0.010;
mdrv4=[];
mdrv4(1)=((4*current4(2,2))-(3*current4(2,1))-current4(2,3))/(2*h);
mdrv4(size(current4,2))=((current4(2,1))-(4*current4(2,2))+(3*current4(2,3)))/(2*h);
for i=2:size(current4,2)-1
    der=(current4(2,i+1)-current4(2,i-1))/(2*h);
    mdrv4(i)=der;
end

mV_arr4=[];
L=0.98;
R=14.2;
mV_arr4(1)=(L*mdrv4(1))+(R*current4(2,1));
mV_arr4(size(current4,2))=(L*mdrv4(size(current4,2)))+(R*current4(2,size(current4,2)));
for i=2:size(current4,2)-1
    Voltage=(L*mdrv4(i))+(R*current4(2,i));
    mV_arr4(i)=Voltage;
end
fprintf('voltages of midpoint (current3.dat)\n');
volt=mV_arr4';
time=current4(1,:)';
volt_t=table(time,volt)
figure (4)
plot(current4(1,2:end),fdrv4(2:end),current4(1,2:end),bdrv4(2:end),current4(1,1:end-1),mdrv4(1:end-1))
legend('forward cur','backward cur','midpoint');
% 
figure (5)
loglog(current4(1,2:end),fV_arr4(2:end),current4(1,2:end),bV_arr4(2:end),current4(1,1:end-1),mV_arr4(1:end-1))
legend('forward','backward','midpoint');
grid on 
xlabel('time(t)');
ylabel('voltage');
% 
% 
%errors

error_forward_1=norm(fV_arr1-12)/norm(fV_arr1);
error_backward_1=norm(bV_arr1-12)/norm(bV_arr1);
error_midpoint_1=norm(mV_arr1-12)/norm(mV_arr1);
error_forward_2=norm(fV_arr2-12)/norm(fV_arr2);
error_backward_2=norm(bV_arr2-12)/norm(bV_arr2);
error_midpoint_2=norm(mV_arr2-12)/norm(mV_arr2);
error_forward_3=norm(fV_arr3-12)/norm(fV_arr3);
error_backward_3=norm(bV_arr3-12)/norm(bV_arr3);
error_midpoint_3=norm(mV_arr3-12)/norm(mV_arr3);
error_forward_4=norm(fV_arr4-12)/norm(fV_arr4);
error_backward_4=norm(bV_arr4-12)/norm(bV_arr4);
error_midpoint_4=norm(mV_arr2-12)/norm(mV_arr4);



