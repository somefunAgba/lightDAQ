% Author: Somefun Oluwasegun
% Email: oasomefun@ieee.org
%
% Dept: EEE/CPE, FUTA
% c/f: EEE 826- DATA ACQUISITION PROJECT
%
% Light Intensity DAQ
% Automatic Dimmer Function
% 
clc; clear all;close all; %#ok<*CLALL>
% a=arduino('COM4','Uno');
% a=arduino();

i = 1; % point
maxpts = 100; % maximum points per view
% initialize animated figure and handles
figure(10);
% sensor axes
ax1=subplot(211);
h = animatedline(ax1,'LineStyle','-','Marker','.','MarkerSize',10,'MarkerEdgeColor','b',...
    'Color','k','MaximumNumPoints',maxpts);
% lamp axes
ax2=subplot(212);
l = animatedline(ax2,'LineStyle','-','Marker','.','MarkerSize',10,'MarkerEdgeColor','b',...
    'Color',[0.7 0.75 0.7],'MaximumNumPoints',maxpts);
dx = 0;
xticks([0+dx maxpts+dx])

% main algorithm function
% creating a mapping for the analog voltage values
% to a fine range of digital pulse 0 and 1
% to  function as dimming when analog is HIGH
bits = 10;
resolution = 2^(bits); % 1024
x = (0:(1/resolution):5)';
y = zmf(x,[1.0 4.0]);% extremes-> 1.0 Volts and 4.0 Volts
% dummy data
% x = 0 + 5.*rand(1000,1);
% y = zmf(x,[1.0 4.0]);

to = tic; % start timer
counts = 1;
% operational loop
while true
    ldr_val = readVoltage(a,'A4');
%     ldr_val = x(i);
    tchk = toc(to); % check timer
    
   if tchk > (1/5) % update after every 30-seconds has elapsed
        
        % map sensor-reading to parametrized z-shaped fuzzy number
        lkup = find(abs(x-ldr_val)<1e-2);
        lmp_val = y(lkup(1));
        % writePWMDutyCycle(a,'D9',lmp_val);
        % writePWMDutyCycle(a,'D10',lmp_val);

        % display acquired readings 
        fprintf('LDR Sensor Reading:%g\n',ldr_val);
        fprintf('Lamp Reading:%g\n', lmp_val);
        
        % animate graph visualization
        addpoints(h,i,ldr_val);        
        xlabel(ax1,'time,t')
        ylabel(ax1,'Light-Sensor Reading')
        grid(ax1,'on');
        
        addpoints(l,i,lmp_val);
        xlabel(ax2,'time,t')
        ylabel(ax2,'Lamp Brightness Voltage-Level')
        grid(ax2,'on');
        xlim(ax1,[0+dx maxpts+dx]);
%         ylim(ax1,[0-0.05 5+0.05]);
        xticks(ax1,0+dx:10:maxpts+dx)
        xlim(ax2,[0+dx maxpts+dx]);
%         ylim(ax2,[0-0.05 1+0.05]);
        xticklabels(ax1,'auto')
        xticks(ax2,0+dx:10:maxpts+dx)
        xticklabels(ax2,'auto')
        drawnow limitrate; % update screen after 1/30 seconds
        
        to = tic; % reset timer after update
        i = i+1;
        
   end
%     drawnow
    counts = counts + 1;
    if (counts - (maxpts+dx)) == 1
%         fprintf('counts:%g\n',counts)
        dx = counts - maxpts; %count-10
%         fprintf('dx:%g\n',dx)
%     else
%         dx = 0;
    end
end
