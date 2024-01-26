clear all
M_tot = []; %total mutual inductance
M12 = []; 
M14 = [];
M23 = [];
M34 = [];
m1 = 0.1; %height of coil 1
m2 = 0.1; %height of coil 2
l1 = 0.1; %lenght of coil 1
l2 = 0.1; %lenght of coil 2
spacing = 0.01; %spacing between central conductors
M12_separate = []; 
M14_separate = [];
M23_separate = [];
M34_separate = [];

lambda = 1.45;
for par_l = 0:0.0001:0.1 %see comment on this variable below
    %______________1.Lateral shift_______________________________
    M12 = m12(m1,m2,l1,lambda*l2,-m1+0.00001,-l1+par_l+(l1-lambda*l1)); %the coil 34 is moving relative to coil 12. Initial distance is fully overlapped + spacing
    M14 = -m12(m1,m2,l1,l2,-m1+0.00001,spacing+par_l);
    M23 = -m12(m1,m2,lambda*l1,lambda*l2,-m1+0.00001,-2*l1-spacing+par_l+(l1-lambda*l1)); 
    M34 = m12(m1,m2,lambda*l1,l2,-m1+0.00001,-l1+par_l);
    %_______________2.Side decrease_______________________________
    % M12 = m12(m1,m2,l1-par_l,l2,-l1+0.00001,-(l1-par_l)-2*spacing);
    % M14 = -m12(m1,m2,l1-par_l,l2-par_l,-l1+0.00001,par_l-spacing); 
    % M23 = -m12(m1,m2,l1,l2,-l1+0.00001,3*spacing); 
    % M34 = m12(m1,m2,l1,l2-par_l,-l1+0.00001,-(l1-par_l)-2*spacing);
    %___________________________________________________________
    M_tot(end+1) = M12+M14+M23+M34;
    M12_separate(end+1) = M12;
    M14_separate(end+1) = M14;
    M23_separate(end+1) = M23;
    M34_separate(end+1) = M34;  
end
par_l = [0:0.0001:0.1]; %This parameters plays a role of either a) lateral shift of one sFO8 coil relative to the other
                        %OR a linear decrease in the length of coils 2 and
                        %3 (be careful when converting linear decrease to
                        %lambda in 2.) 
figure(2)
plot(par_l*100, M12_separate*1e6, LineWidth=2) %our model has \mu H mutual order of mutual inductance, feel free to swap 1e6 to whatever you need, same for *100 (meters to cm)
grid on
xlabel('shift, m')
ylabel('Mutual coupling, \mu H')
hold on
plot(par_l*100, M14_separate*1e6, LineWidth=2, LineStyle="-.")
plot(par_l*100, M23_separate*1e6, LineWidth=2, LineStyle="--")
plot(par_l*100, M34_separate*1e6, LineWidth=2, LineStyle="--")
plot(par_l*100, M_tot*1e6, LineWidth=2) %for lateral shift
xlabel('shift, cm')
legend('M_1_2', 'M_1_4', 'M_2_3', 'M_3_4', 'M')
% plot((-par_l*1000+100)/100, M_tot*1e6, LineWidth=2) %for Side Decrease
% xlabel('\lambda')
ylabel('M, \mu H', 'FontSize',15)  
grid on

