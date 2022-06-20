% frequencies range from 1 to 35
omega=ones(1,35);
x=ones(2,35); % reference signal
weights_mp=zeros(2,35); % preallocation to avoid dynamic sizing
weights_mv=zeros(2,35); % preallocation to avoid dynamic sizing

% constructing the reference signal
for i=1:35
    omega(1,i)=2*pi*i;
    x(1,i)=sin(omega(1,i)); % t=1
    x(2,i)=cos(omega(1,i));
end

y=zeros(1,121); % estimated signal (main)
z=zeros(1,121); % estimated mpv signal

for t=0:120
    x(1,:)=sin(omega(1,:)*t);
    x(2,:)=cos(omega(1,:)*t);
    % main signal
    mpv(1,t+1)=sin(t)+2*sin(2*t)+3*sin(3*t)+cos(t)+2*cos(2*t)+3*cos(3*t);
    mpi(1,t+1)=0.1*sin(30*t)+0.1*sin(35*t)+3*sin(3*t)+0.1*cos(30*t)+0.1*cos(35*t);
    mp(1,t+1)=mpv(1,t+1)+mpi(1,t+1);
    % estimated main and mpv signal
    y(1,t+1)=y(1,t+1)+sum(weights_mp(1,:).*x(1,:))+sum(weights_mp(2,:).*x(2,:));
    z(1,t+1)=z(1,t+1)+sum(weights_mv(1,:).*x(1,:))+sum(weights_mv(2,:).*x(2,:));
    % adapt weights (complete signal)
    weights_mp(1,:)=0.1*weights_mp(1,:)+2*0.01*x(1,:)*(mp(1,t+1)-y(1,t+1));
    weights_mp(2,:)=0.1*weights_mp(2,:)+2*0.01*x(2,:)*(mp(1,t+1)-y(1,t+1));
    % adapt weights (mpv)
    weights_mv(1,:)=0.1*weights_mv(1,:)+2*0.01*x(1,:)*(mpv(1,t+1)-z(1,t+1));
    weights_mv(2,:)=0.1*weights_mv(2,:)+2*0.01*x(2,:)*(mpv(1,t+1)-z(1,t+1));
end

t=0:120
subplot(1,2,1)
plot(t,y)
hold on
plot(t,mp)
legend('estimated','main signal')
title('estimated Main signal MP')
hold off
subplot(1,2,2)
%nexttile
plot(t,z)
hold on
plot(t,mpv)
legend('estimated mpv','main signal mpv')
title('estimated MPv signal ')
hold off




