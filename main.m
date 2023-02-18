
clear all;
OAR=xlsread('OAR.csv'); %OAR
VC=xlsread('VC.csv'); %Targets
param=xlsread('param2.csv'); %BMI & age
format long;


%% Config matrix for Targets
%1 3D_PTVSein_D98   // 14 VMAT_PTVSein_D98      // 27 Hybrid_PTVSein_D98
%2 3D_PTVSein_D2    // 15 VMAT_PTVSein_D2       // 28 Hybrid_PTVSein_D2
%3 3D_PTVSein_D50   // 16 VMAT_PTVSein_D50      // 29 Hybrid_PTVSein_D50
%4 3D_PTVSein_HI    // 17 VMAT_PTVSein_HI       // 30 Hybrid_PTVSein_HI
%5 3D_Vol_PTV50Eval // 18 VMAT_Vol_PTV50Eval    // 31 Hybrid_Vol_PTV50Eval
%6 3D_Vol_iso95     // 19 VMAT_Vol_iso95        // 32 Hybrid_Vol_iso95
%7 3D_vol_intersec  // 20 VMAT_vol_intersec     // 33 Hybrid_vol_intersec
%8 3D_PTVSein_CI    // 21 VMAT_PTVSein_CI       // 34 Hybrid_PTVSein_CI
%9 3D_PTVSein_V107  // 22 VMAT_PTVSein_V107     // 35 Hybrid_PTVSein_V107
%10 3D_PTVSein_V95  // 23 VMAT_PTVSein_V95      // 36 Hybrid_PTVSein_V95
%11 3D_PTVSein_V98  // 24 VMAT_PTVSein_V98      // 37 Hybrid_PTVSein_V98
%12 3D_PTVNodes_V95 // 25 VMAT_PTVNodes_V95     // 38 Hybrid_PTVNodes_V95
%13 3D_PTVNodes_V98 // 26 VMAT_PTVNodes_V98     // 39 Hybrid_PTVNodes_V98

%% Config matrix for OAR
%1 3D_PoumonHomo_Dmean     // 16 VMAT_PoumonHomo_Dmean      // 31 Hybrid_PoumonHomo_Dmean
%2 3D_PoumonHomo_V20       // 17 VMAT_PoumonHomo_V20        // 32 Hybrid_PoumonHomo_V20
%3 3D_PoumonHomo_V30       // 18 VMAT_PoumonHomo_V30        // 33 Hybrid_PoumonHomo_V30
%4 3D_PoumonHomo_NTCP      // 19 VMAT_PoumonHomo_NTCP       // 34 Hybrid_PoumonHomo_NTCP
%5 3D_PoumonContro_Dmean   // 20 VMAT_PoumonContro_Dmean    // 35 Hybrid_PoumonContro_Dmean
%6 3D_PoumonHomoContro_V5  // 21 VMAT_PoumonHomoContro_V5   // 36 Hybrid_PoumonHomoContro_V5
%7 3D_Coeur_Dmean          // 22 VMAT_Coeur_Dmean           // 37 Hybrid_Coeur_Dmean
%8 3D_Coeur_V25            // 23 VMAT_Coeur_V25             // 38 Hybrid_Coeur_V25
%9 3D_IVA_V30              // 24 VMAT_IVA_V30               // 39 Hybrid_IVA_V30
%10 3D_Foie_V5             // 25 VMAT_Foie_V5               // 40 Hybrid_Foie_V5
%11 3D_SeinContro_Dmean    // 26 VMAT_SeinContro_Dmean      // 41 Hybrid_SeinContro_Dmean
%12 3D_TH_Dmean            // 27 VMAT_TH_Dmean              // 42 Hybrid_TH_Dmean
%13 3D_PRVMoelle_Dmax      // 28 VMAT_PRVMoelle_Dmax        // 43 Hybrid_PRVMoelle_Dmax
%14 3D_Oeso_V35            // 29 VMAT_Oeso_V35              // 44 Hybrid_Oeso_V35
%15 3D_Trachee_V35         // 30 VMAT_Trachee_V35           // 45 Hybrid_Trachee_V35

%% Indices to use

VC_Index_3D=[1:13]'; % for targets
VC_Index_VMAT=VC_Index_3D+13;
VC_Index_Hybrid=VC_Index_3D+26;
N_VC=size(VC_Index_3D);

OAR_Index_3D=[1:15]'; % for OAR
OAR_Index_VMAT=[16:30]';
OAR_Index_Hybrid=[31:45]';
N_OAR=size(OAR_Index_3D);

%% Means for Breasts R&L : 3D // VMAT // Hybrid 


Param_OAR=["LungIL-Dmean","LungIL-V20","LungIL-V30","LungIL-NTCP","LungCL-Dmean","LungIL&CL-V5","Heart-Dmean","Heart-V25","AIV-V30","Liver-V5","BreastCL-Dmean","HH-Dmean","PRVSP-Dmax","Eso-V35","Trachea-V35"];
Param_VC=["PTV50-D98","PTV50-D2","PTV50-D50","PTV50-HI","Vol-PTV50","Vol-iso95","vol-intersec","PTV50-CI","PTV50-V107","PTV50-V95","PTV50-V98","PTV47-V95","PTV47-V98"];   

mean_OAR_3D=mean(OAR(:,1:15));
mean_OAR_VMAT=mean(OAR(:,16:30));
mean_OAR_Hybrid=mean(OAR(:,31:45));
mean_VC_3D=mean(VC(:,1:13));
mean_VC_VMAT=mean(VC(:,14:26));
mean_VC_Hybrid=mean(VC(:,27:39));
b_mean_OAR=[Param_OAR;mean_OAR_3D;mean_OAR_VMAT;mean_OAR_Hybrid];
b_mean_VC=[Param_VC;mean_VC_3D;mean_VC_VMAT;mean_VC_Hybrid];

fprintf('Paramètre // 3DCRT // VMAT // Hybrid \n')
fprintf('%s // %7.4g // %7.4g // %7.4g \n',b_mean_VC)
fprintf('%s // %7.4g // %7.4g // %7.4g \n',b_mean_OAR)

%% OAR :  regression plots  between VMAT and Hybrid only if linear determination coefficient is different than 1

for l=1:15;
tt=corr([OAR(:,l+15),OAR(:,l+30)]);
if tt(1,2)^2 < 0.8
figure;
plot(OAR(1:15,l+15),OAR(1:15,l+30),'or', 'MarkerSize', 10);
hold on;
plot(OAR(16:30,l+15),OAR(16:30,l+30),'xb', 'MarkerSize', 10);
title([num2str(Param_OAR(l),1),' R^2= ', num2str(tt(1,2)^2)]);
        hold on; axis square; grid on; xlabel('VMAT','FontSize',16); ylabel('Hybrid','FontSize',16);
        plot([min(OAR(:,l+15)) max(OAR(:,l+15))],[min(OAR(:,l+15)) max(OAR(:,l+15))], '-k', 'LineWidth', 0.5);
        hold on
        plot([min(OAR(:,l+15)) max(OAR(:,l+15))],[0.95*min(OAR(:,l+15)) 0.95*max(OAR(:,l+15))],'LineStyle',':');
        hold on
        plot([min(OAR(:,l+15)) max(OAR(:,l+15))],[1.05*min(OAR(:,l+15)) 1.05*max(OAR(:,l+15))],'LineStyle',':');
        X=[min(OAR(:,l+15)) min(OAR(:,l+15)) max(OAR(:,l+15)) max(OAR(:,l+15))];
        Y=[0.95*min(OAR(:,l+15)) 1.05*min(OAR(:,l+15)) 1.05*max(OAR(:,l+15)) 0.95*max(OAR(:,l+15))];
        C=[0 10 10 0];
        patch(X,Y,C,'FaceAlpha','0.5');
        legend({'R','L'})
        set(gca, 'fontsize', 16)
end
end

%% Targets : regression plots between VMAT and Hybrid only if linear determination coefficient is different than 1

for l=1:13;
tt=corr([VC(:,l+13),VC(:,l+26)]);
if tt(1,2)^2 < 0.8
figure;
plot(VC(1:15,l+13),VC(1:15,l+26),'or', 'MarkerSize', 10);
hold on;
plot(VC(16:30,l+13),VC(16:30,l+26),'xb', 'MarkerSize', 10);
title([num2str(Param_VC(l),1),' R^2= ', num2str(tt(1,2)^2)]);
        hold on; axis square; grid on; xlabel('VMAT','FontSize',16); ylabel('Hybrid','FontSize',16);
        plot([min(VC(:,l+13)) max(VC(:,l+13))],[min(VC(:,l+13)) max(VC(:,l+13))], '-k', 'LineWidth', 0.5);
        hold on
        plot([min(VC(:,l+13)) max(VC(:,l+13))],[0.95*min(VC(:,l+13)) 0.95*max(VC(:,l+13))],'LineStyle',':');
        hold on
        plot([min(VC(:,l+13)) max(VC(:,l+13))],[1.05*min(VC(:,l+13)) 1.05*max(VC(:,l+13))],'LineStyle',':');
        X=[min(VC(:,l+13)) min(VC(:,l+13)) max(VC(:,l+13)) max(VC(:,l+13))];
        Y=[0.95*min(VC(:,l+13)) 1.05*min(VC(:,l+13)) 1.05*max(VC(:,l+13)) 0.95*max(VC(:,l+13))];
        C=[0 10 10 0];
        patch(X,Y,C,'FaceAlpha','0.5');
        legend({'R','L'})
        set(gca, 'fontsize', 16)
end
end


%% Non Parametric Tests of Wilcoxon (Wilcoxon Rank Sum Test) for Breasts R&L

for i=1:N_OAR(1,1)
p_OAR_DG_3D_Vs_VMAT(i,1)=ranksum(OAR(:,OAR_Index_3D(i,1)),OAR(:,OAR_Index_VMAT(i,1))); 
p_OAR_DG_3D_Vs_Hybrid(i,1)=ranksum(OAR(:,OAR_Index_3D(i,1)),OAR(:,OAR_Index_Hybrid(i,1))); 
p_OAR_DG_VMAT_Vs_Hybrid(i,1)=ranksum(OAR(:,OAR_Index_VMAT(i,1)),OAR(:,OAR_Index_Hybrid(i,1)));
end 
for i=1:N_VC(1,1)
p_VC_DG_3D_Vs_VMAT(i,1)=ranksum(VC(:,VC_Index_3D(i,1)),VC(:,VC_Index_VMAT(i,1))); 
p_VC_DG_3D_Vs_Hybrid(i,1)=ranksum(VC(:,VC_Index_3D(i,1)),VC(:,VC_Index_Hybrid(i,1))); 
p_VC_DG_VMAT_Vs_Hybrid(i,1)=ranksum(VC(:,VC_Index_VMAT(i,1)),VC(:,VC_Index_Hybrid(i,1)));
end

n_OAR_DG_3D_Vs_VMAT=find(p_OAR_DG_3D_Vs_VMAT<0.05);
n_OAR_DG_3D_Vs_Hybrid=find(p_OAR_DG_3D_Vs_Hybrid<0.05);
n_OAR_DG_VMAT_Vs_Hybrid=find(p_OAR_DG_VMAT_Vs_Hybrid<0.05);
b_OAR_DG_3D_Vs_VMAT=[Param_OAR(n_OAR_DG_3D_Vs_VMAT);p_OAR_DG_3D_Vs_VMAT(n_OAR_DG_3D_Vs_VMAT)'];
b_OAR_DG_3D_Vs_Hybrid=[Param_OAR(n_OAR_DG_3D_Vs_Hybrid);p_OAR_DG_3D_Vs_Hybrid(n_OAR_DG_3D_Vs_Hybrid)'];
b_OAR_DG_VMAT_Vs_Hybrid=[Param_OAR(n_OAR_DG_VMAT_Vs_Hybrid);p_OAR_DG_VMAT_Vs_Hybrid(n_OAR_DG_VMAT_Vs_Hybrid)'];

n_VC_DG_3D_Vs_VMAT=find(p_VC_DG_3D_Vs_VMAT<0.05);
n_VC_DG_3D_Vs_Hybrid=find(p_VC_DG_3D_Vs_Hybrid<0.05);
n_VC_DG_VMAT_Vs_Hybrid=find(p_VC_DG_VMAT_Vs_Hybrid<0.05);
b_VC_DG_3D_Vs_VMAT=[Param_VC(n_VC_DG_3D_Vs_VMAT);p_VC_DG_3D_Vs_VMAT(n_VC_DG_3D_Vs_VMAT)'];
b_VC_DG_3D_Vs_Hybrid=[Param_VC(n_VC_DG_3D_Vs_Hybrid);p_VC_DG_3D_Vs_Hybrid(n_VC_DG_3D_Vs_Hybrid)'];
b_VC_DG_VMAT_Vs_Hybrid=[Param_VC(n_VC_DG_VMAT_Vs_Hybrid);p_VC_DG_VMAT_Vs_Hybrid(n_VC_DG_VMAT_Vs_Hybrid)'];

%3D Vs VMAT
fprintf('Les Param VC Signific entre 3D et VMAT sont %s (p_value=%7.4g) \n',b_VC_DG_3D_Vs_VMAT)
fprintf('Les Param OAR Signific entre 3D et VMAT sont %s (p_value=%7.4g) \n',b_OAR_DG_3D_Vs_VMAT)

%3D Vs Hybrid
fprintf('Les Param VC Signific entre 3D et Hybrid sont %s (p_value=%7.4g) \n',b_VC_DG_3D_Vs_Hybrid)
fprintf('Les Param OAR Signific entre 3D et Hybrid sont %s (p_value=%7.4g) \n',b_OAR_DG_3D_Vs_Hybrid)

%Hybrid Vs VMAT
fprintf('Les Param VC Signific entre VMAT et Hybrid sont %s (p_value=%7.4g) \n',b_VC_DG_VMAT_Vs_Hybrid)
fprintf('Les Param OAR Signific entre VMAT et Hybrid sont %s (p_value=%7.4g) \n',b_OAR_DG_VMAT_Vs_Hybrid)

%% Means for Breasts R : 3D // VMAT // Hybrid 

clear p_* n_* b_* mean_*;

mean_OAR_3D=mean(OAR(1:15,1:15));
mean_OAR_VMAT=mean(OAR(1:15,16:30));
mean_OAR_Hybrid=mean(OAR(1:15,31:45));
mean_VC_3D=mean(VC(1:15,1:13));
mean_VC_VMAT=mean(VC(1:15,14:26));
mean_VC_Hybrid=mean(VC(1:15,27:39));
b_mean_OAR=[Param_OAR;mean_OAR_3D;mean_OAR_VMAT;mean_OAR_Hybrid];
b_mean_VC=[Param_VC;mean_VC_3D;mean_VC_VMAT;mean_VC_Hybrid];

fprintf('Paramètre // 3DCRT // VMAT // Hybrid \n')
fprintf('%s // %7.4g // %7.4g // %7.4g \n',b_mean_VC)
fprintf('%s // %7.4g // %7.4g // %7.4g \n',b_mean_OAR)

%% Non Parametric Tests of Wilcoxon (Wilcoxon Rank Sum Test) for Breast R

for i=1:N_OAR(1,1)
p_OAR_DG_3D_Vs_VMAT(i,1)=ranksum(OAR(1:15,OAR_Index_3D(i,1)),OAR(1:15,OAR_Index_VMAT(i,1))); 
p_OAR_DG_3D_Vs_Hybrid(i,1)=ranksum(OAR(1:15,OAR_Index_3D(i,1)),OAR(1:15,OAR_Index_Hybrid(i,1))); 
p_OAR_DG_VMAT_Vs_Hybrid(i,1)=ranksum(OAR(1:15,OAR_Index_VMAT(i,1)),OAR(1:15,OAR_Index_Hybrid(i,1)));
end 
for i=1:N_VC(1,1)
p_VC_DG_3D_Vs_VMAT(i,1)=ranksum(VC(1:15,VC_Index_3D(i,1)),VC(1:15,VC_Index_VMAT(i,1))); 
p_VC_DG_3D_Vs_Hybrid(i,1)=ranksum(VC(1:15,VC_Index_3D(i,1)),VC(1:15,VC_Index_Hybrid(i,1))); 
p_VC_DG_VMAT_Vs_Hybrid(i,1)=ranksum(VC(1:15,VC_Index_VMAT(i,1)),VC(1:15,VC_Index_Hybrid(i,1)));
end


n_OAR_DG_3D_Vs_VMAT=find(p_OAR_DG_3D_Vs_VMAT<0.05);
n_OAR_DG_3D_Vs_Hybrid=find(p_OAR_DG_3D_Vs_Hybrid<0.05);
n_OAR_DG_VMAT_Vs_Hybrid=find(p_OAR_DG_VMAT_Vs_Hybrid<0.05);
b_OAR_DG_3D_Vs_VMAT=[Param_OAR(n_OAR_DG_3D_Vs_VMAT);p_OAR_DG_3D_Vs_VMAT(n_OAR_DG_3D_Vs_VMAT)'];
b_OAR_DG_3D_Vs_Hybrid=[Param_OAR(n_OAR_DG_3D_Vs_Hybrid);p_OAR_DG_3D_Vs_Hybrid(n_OAR_DG_3D_Vs_Hybrid)'];
b_OAR_DG_VMAT_Vs_Hybrid=[Param_OAR(n_OAR_DG_VMAT_Vs_Hybrid);p_OAR_DG_VMAT_Vs_Hybrid(n_OAR_DG_VMAT_Vs_Hybrid)'];

n_VC_DG_3D_Vs_VMAT=find(p_VC_DG_3D_Vs_VMAT<0.05);
n_VC_DG_3D_Vs_Hybrid=find(p_VC_DG_3D_Vs_Hybrid<0.05);
n_VC_DG_VMAT_Vs_Hybrid=find(p_VC_DG_VMAT_Vs_Hybrid<0.05);
b_VC_DG_3D_Vs_VMAT=[Param_VC(n_VC_DG_3D_Vs_VMAT);p_VC_DG_3D_Vs_VMAT(n_VC_DG_3D_Vs_VMAT)'];
b_VC_DG_3D_Vs_Hybrid=[Param_VC(n_VC_DG_3D_Vs_Hybrid);p_VC_DG_3D_Vs_Hybrid(n_VC_DG_3D_Vs_Hybrid)'];
b_VC_DG_VMAT_Vs_Hybrid=[Param_VC(n_VC_DG_VMAT_Vs_Hybrid);p_VC_DG_VMAT_Vs_Hybrid(n_VC_DG_VMAT_Vs_Hybrid)'];

%3D Vs VMAT
fprintf('Les Param VC Signific entre 3D et VMAT sont %s (p_value=%7.4g) \n',b_VC_DG_3D_Vs_VMAT)
fprintf('Les Param OAR Signific entre 3D et VMAT sont %s (p_value=%7.4g) \n',b_OAR_DG_3D_Vs_VMAT)

%3D Vs Hybrid
fprintf('Les Param VC Signific entre 3D et Hybrid sont %s (p_value=%7.4g) \n',b_VC_DG_3D_Vs_Hybrid)
fprintf('Les Param OAR Signific entre 3D et Hybrid sont %s (p_value=%7.4g) \n',b_OAR_DG_3D_Vs_Hybrid)

%Hybrid Vs VMAT
fprintf('Les Param VC Signific entre VMAT et Hybrid sont %s (p_value=%7.4g) \n',b_VC_DG_VMAT_Vs_Hybrid)
fprintf('Les Param OAR Signific entre VMAT et Hybrid sont %s (p_value=%7.4g) \n',b_OAR_DG_VMAT_Vs_Hybrid)


%% Means for Breasts L : 3D // VMAT // Hybrid 
clear p_* n_* b_* mean_*;

mean_OAR_3D=mean(OAR(16:30,1:15));
mean_OAR_VMAT=mean(OAR(16:30,16:30));
mean_OAR_Hybrid=mean(OAR(16:30,31:45));
mean_VC_3D=mean(VC(16:30,1:13));
mean_VC_VMAT=mean(VC(16:30,14:26));
mean_VC_Hybrid=mean(VC(16:30,27:39));
b_mean_OAR=[Param_OAR;mean_OAR_3D;mean_OAR_VMAT;mean_OAR_Hybrid];
b_mean_VC=[Param_VC;mean_VC_3D;mean_VC_VMAT;mean_VC_Hybrid];

fprintf('Paramètre // 3DCRT // VMAT // Hybrid \n')
fprintf('%s // %7.4g // %7.4g // %7.4g \n',b_mean_VC)
fprintf('%s // %7.4g // %7.4g // %7.4g \n',b_mean_OAR)


%% Non Parametric Tests of Wilcoxon (Wilcoxon Rank Sum Test) for Breasts L

clear p_* n_* b_*;

for i=1:N_OAR(1,1)
p_OAR_DG_3D_Vs_VMAT(i,1)=ranksum(OAR(16:30,OAR_Index_3D(i,1)),OAR(16:30,OAR_Index_VMAT(i,1))); 
p_OAR_DG_3D_Vs_Hybrid(i,1)=ranksum(OAR(16:30,OAR_Index_3D(i,1)),OAR(16:30,OAR_Index_Hybrid(i,1))); 
p_OAR_DG_VMAT_Vs_Hybrid(i,1)=ranksum(OAR(16:30,OAR_Index_VMAT(i,1)),OAR(16:30,OAR_Index_Hybrid(i,1)));
end 
for i=1:N_VC(1,1)
p_VC_DG_3D_Vs_VMAT(i,1)=ranksum(VC(16:30,VC_Index_3D(i,1)),VC(16:30,VC_Index_VMAT(i,1))); 
p_VC_DG_3D_Vs_Hybrid(i,1)=ranksum(VC(16:30,VC_Index_3D(i,1)),VC(16:30,VC_Index_Hybrid(i,1))); 
p_VC_DG_VMAT_Vs_Hybrid(i,1)=ranksum(VC(16:30,VC_Index_VMAT(i,1)),VC(16:30,VC_Index_Hybrid(i,1)));
end

n_OAR_DG_3D_Vs_VMAT=find(p_OAR_DG_3D_Vs_VMAT<0.05);
n_OAR_DG_3D_Vs_Hybrid=find(p_OAR_DG_3D_Vs_Hybrid<0.05);
n_OAR_DG_VMAT_Vs_Hybrid=find(p_OAR_DG_VMAT_Vs_Hybrid<0.05);
b_OAR_DG_3D_Vs_VMAT=[Param_OAR(n_OAR_DG_3D_Vs_VMAT);p_OAR_DG_3D_Vs_VMAT(n_OAR_DG_3D_Vs_VMAT)'];
b_OAR_DG_3D_Vs_Hybrid=[Param_OAR(n_OAR_DG_3D_Vs_Hybrid);p_OAR_DG_3D_Vs_Hybrid(n_OAR_DG_3D_Vs_Hybrid)'];
b_OAR_DG_VMAT_Vs_Hybrid=[Param_OAR(n_OAR_DG_VMAT_Vs_Hybrid);p_OAR_DG_VMAT_Vs_Hybrid(n_OAR_DG_VMAT_Vs_Hybrid)'];

n_VC_DG_3D_Vs_VMAT=find(p_VC_DG_3D_Vs_VMAT<0.05);
n_VC_DG_3D_Vs_Hybrid=find(p_VC_DG_3D_Vs_Hybrid<0.05);
n_VC_DG_VMAT_Vs_Hybrid=find(p_VC_DG_VMAT_Vs_Hybrid<0.05);
b_VC_DG_3D_Vs_VMAT=[Param_VC(n_VC_DG_3D_Vs_VMAT);p_VC_DG_3D_Vs_VMAT(n_VC_DG_3D_Vs_VMAT)'];
b_VC_DG_3D_Vs_Hybrid=[Param_VC(n_VC_DG_3D_Vs_Hybrid);p_VC_DG_3D_Vs_Hybrid(n_VC_DG_3D_Vs_Hybrid)'];
b_VC_DG_VMAT_Vs_Hybrid=[Param_VC(n_VC_DG_VMAT_Vs_Hybrid);p_VC_DG_VMAT_Vs_Hybrid(n_VC_DG_VMAT_Vs_Hybrid)'];

%3D Vs VMAT
fprintf('Les Param VC Signific entre 3D et VMAT sont %s (p_value=%7.4g) \n',b_VC_DG_3D_Vs_VMAT)
fprintf('Les Param OAR Signific entre 3D et VMAT sont %s (p_value=%7.4g) \n',b_OAR_DG_3D_Vs_VMAT)

%3D Vs Hybrid
fprintf('Les Param VC Signific entre 3D et Hybrid sont %s (p_value=%7.4g) \n',b_VC_DG_3D_Vs_Hybrid)
fprintf('Les Param OAR Signific entre 3D et Hybrid sont %s (p_value=%7.4g) \n',b_OAR_DG_3D_Vs_Hybrid)

%Hybrid Vs VMAT
fprintf('Les Param VC Signific entre VMAT et Hybrid sont %s (p_value=%7.4g) \n',b_VC_DG_VMAT_Vs_Hybrid)
fprintf('Les Param OAR Signific entre VMAT et Hybrid sont %s (p_value=%7.4g) \n',b_OAR_DG_VMAT_Vs_Hybrid)

%% Violin Plots for OAR

figure; %% 
for n=0:3
subplot(4,1,n+1)
al_goodplot(OAR(:,1+n),1,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,16+n),2,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,31+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_OAR(1+n))
Input=[OAR(:,1+n),OAR(:,16+n),OAR(:,31+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3])
xticklabels({'3DCRT', 'VMAT','Hybrid'})

figure; %% 
for n=0:3
subplot(4,1,n+1)
al_goodplot(OAR(:,5+n),1,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,20+n),2,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,35+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_OAR(5+n))
Input=[OAR(:,5+n),OAR(:,20+n),OAR(:,35+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3])
xticklabels({'3DCRT', 'VMAT','Hybrid'})

figure; %% 
for n=0:3
subplot(4,1,n+1)
al_goodplot(OAR(:,9+n),1,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,24+n),2,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,39+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_OAR(9+n))
Input=[OAR(:,9+n),OAR(:,24+n),OAR(:,39+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3])
xticklabels({'3DCRT', 'VMAT','Hybrid'})

figure; %% 
for n=0:1
subplot(4,1,n+1)
al_goodplot(OAR(:,13+n),1,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,28+n),2,0.3,[],[],[],[],0.2);
al_goodplot(OAR(:,43+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_OAR(13+n))
Input=[OAR(:,13+n),OAR(:,28+n),OAR(:,43+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3])
xticklabels({'3DCRT', 'VMAT','Hybrid'})



%% Violin Plots for Targets

figure; %% 
for n=0:3
subplot(4,1,n+1)
al_goodplot(VC(:,1+n),1,0.3,[],[],[],[],0.2);
al_goodplot(VC(:,14+n),2,0.3,[],[],[],[],0.2);
al_goodplot(VC(:,27+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_VC(1+n))
Input=[VC(:,1+n),VC(:,14+n),VC(:,27+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3])
xticklabels({'3DCRT', 'VMAT','Hybrid'})

figure; %% 
for n=0:3
subplot(4,1,n+1)
al_goodplot(VC(:,5+n),1,0.3,[],[],[],[],0.2);
al_goodplot(VC(:,18+n),2,0.3,[],[],[],[],0.2);
al_goodplot(VC(:,31+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_VC(5+n))
Input=[VC(:,5+n),VC(:,18+n),VC(:,31+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3])
xticklabels({'3DCRT', 'VMAT','Hybrid'})

figure; %% 
for n=0:4
subplot(5,1,n+1)
al_goodplot(VC(:,9+n),1,0.3,[],[],[],[],0.2);
al_goodplot(VC(:,22+n),2,0.3,[],[],[],[],0.2);
al_goodplot(VC(:,35+n),3,0.3,[],[],[],[],0.2);
xticks([])
grid 
set(gca,'FontSize',7)
ylabel(Param_VC(9+n))
Input=[VC(:,9+n),VC(:,22+n),VC(:,35+n)];
p=kruskalwallis(Input,[],'off'); %%Test de Kruskal-Wallis non parametrique
title(['pValue= ' num2str(p,4)])
hold on;
end
xticks([1 2 3]);
xticklabels({'3DCRT', 'VMAT','Hybrid'});

%% Spearman correlation Study

figure;
subplot(2,2,3)%pour le 3D
clear c
% en Rouge les Corrélations significatives
[RHO,PVAL] = corr([VC(:,1:13) OAR(:,1:15)],'Type','Spearman');
PVAL(PVAL==1)=0;
imagesc(PVAL);
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
m=100; % set max value
c=zeros(m,3); % start with all 0's
c(1:5,1)=1; %
c(1:5,2)=0.5;
c(5:end,:)=1; %
colorbar('Ticks',[0 0.05 0.99],'XTickLabel',{'Sign','Threshold','No-Sign'});
colormap(c);
title('3DCRT')
set(colorbar,'visible','off');
set(gca,'FontSize',7)

subplot(2,2,4)%pour le VMAT
clear c
[RHO,PVAL] = corr([VC(:,14:26) OAR(:,16:30)],'Type','Spearman');
PVAL(PVAL==1)=0;
imagesc(PVAL);
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28]);
m=100; % set max value
c=zeros(m,3); % start with all 0's
c(1:5,1)=1; %
c(1:5,2)=0.5;
c(5:end,:)=1; %
colorbar('Ticks',[0 0.05 0.99],'XTickLabel',{'Sign','Threshold','No-Sign'});
colormap(c);
set(colorbar,'visible','off');
title('VMAT');
set(gca,'FontSize',7);

subplot(2,2,[1 2])%pour l'Hybrid
clear c
[RHO,PVAL] = corr([VC(:,27:39) OAR(:,31:45)],'Type','Spearman');
PVAL(PVAL==1)=0;
imagesc(PVAL);
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28])
xticklabels([Param_VC Param_OAR])
xtickangle(45)
yticks([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28])
yticklabels([Param_VC Param_OAR])
m=100; % set max value
c=zeros(m,3); % start with all 0's
c(1:5,1)=1; %
c(1:5,2)=0.5;
c(5:end,:)=1; %
colorbar('Ticks',[0 0.05 0.99],'XTickLabel',{'Sign','Threshold (p=0.05)','No-Sign'});
colormap(c)
title('Hybrid');
set(gca,'FontSize',7);

%% ROC analyze Breasts R&L

param(:,3)=VC(:,5);
for Input=1:3;   % 1=IMC 2=Age 3=VolPTV50-Eval
    Input_Name=["BMI","Age","Vol-PTV50"];
    for Mode=1:3;%1=3D 2=VMAT 3=Hybrid
        Mode_Name = ["3DCRT","VMAT","Hybrid"];
        for Output_OAR=1:15; % paramètres étudiés dans les OAR & Clinical  :
CG_OAR(1,1)=15;  %1 PoumonHomo_Dmean 
CG_OAR(2,1)=30;  %2 PoumonHomo_V20                                   
CG_OAR(3,1)=20;  %3 PoumonHomo_V30
CG_OAR(4,1)=5;   %4 PoumonHomo_NTCP 
CG_OAR(5,1)=5;   %5 PoumonContro_Dmean
CG_OAR(6,1)=50;  %6 PoumonHomoContro_V5
CG_OAR(7,1)=5;   %7 Coeur_Dmean
CG_OAR(8,1)=10;  %8 Coeur_V25 
CG_OAR(9,1)=30;  %9 IVA_V30 
CG_OAR(10,1)=100;%10 Foie_V5
CG_OAR(11,1)=5;  %11 SeinContro_Dmean
CG_OAR(12,1)=20; %12 TH_Dmean 
CG_OAR(13,1)=20; %13 PRVMoelle_Dmax
CG_OAR(14,1)=5;  %14 Oeso_V35
CG_OAR(15,1)=5;  %15 Trachee_V35
       
Sensitivity=ones(1000,1);Specificity=zeros(1000,1);distance=ones(1000,1);
FN=zeros(1000,1);

for i=1:30
    if OAR(i,Output_OAR+(Mode-1)*15)<CG_OAR(Output_OAR)
        diff(i,1)=0;
    else diff(i,1)=1;
    end
end

Threshold(1,1)=min(param(:,Input));
Delta_Threshold=(max(param(:,Input))-min(param(:,Input)))/1000;
for j=2:1000
    Threshold(j,1)=Delta_Threshold+Threshold(j-1,1);
    obj_pos=find(param(:,Input) >= Threshold(j,1));
    obj_neg=find(param(:,Input) < Threshold(j,1));
    TP(j,1)=sum(diff(obj_pos,1));
    FP(j,1)=length(obj_pos)-TP(j,1);
    FN(j,1)=sum(diff(obj_neg,1));
    TN(j,1)=length(obj_neg)-FN(j,1);
    Sensitivity(j,1)=TP(j,1)/(TP(j,1) + FN(j,1));
    Specificity(j,1)=TN(j,1)/(TN(j,1) + FP(j,1));
    distance(j,:)= sqrt((1-Sensitivity(j,1))^2+(Specificity(j,1)-1)^2);
    
end
        [~, opt] = min(distance);
        AUC=abs(trapz(1-Specificity,Sensitivity));
        if AUC > 0.7
        figure;
        hold on; plot(1-Specificity(opt,1), Sensitivity(opt,1), 'or', 'MarkerSize', 10);
        hold on; plot(1-Specificity(opt,1), Sensitivity(opt,1), 'xr', 'MarkerSize', 12);
        hold on; axis square; grid on; xlabel('1 - specificity'); ylabel('sensibility');
        plot(1-Specificity,Sensitivity, '-b', 'LineWidth', 2);
        set(gca, 'fontsize', 13)
        title(['AROC-AUC = ' num2str(AUC) ' , ' num2str(Input_Name(Input)) '='  num2str(Threshold(opt)) ' , ' num2str(Mode_Name(Mode)) ' , ' num2str(Param_OAR(Output_OAR))]);
        clear diff obj_* TP FP FN TN Sensitivity Specificity distance;
        end
        end
    end
end

%% ROC analyze Breast R

param(:,3)=VC(:,5);
for Input=1:3;   % 1=IMC 2=Age 3=VolPTV50-Eval
    Input_Name=["BMI","Age","Vol-PTV50"];
    for Mode=1:3;%1=3D 2=VMAT 3=Hybrid
        Mode_Name = ["3DCRT","VMAT","Hybrid"];
        for Output_OAR=1:15; % paramètres étudiés dans les OAR & Clinical  :
CG_OAR(1,1)=15;  %1 PoumonHomo_Dmean 
CG_OAR(2,1)=30;  %2 PoumonHomo_V20                                   
CG_OAR(3,1)=20;  %3 PoumonHomo_V30
CG_OAR(4,1)=5;   %4 PoumonHomo_NTCP 
CG_OAR(5,1)=5;   %5 PoumonContro_Dmean
CG_OAR(6,1)=50;  %6 PoumonHomoContro_V5
CG_OAR(7,1)=5;   %7 Coeur_Dmean
CG_OAR(8,1)=10;  %8 Coeur_V25 
CG_OAR(9,1)=30;  %9 IVA_V30 
CG_OAR(10,1)=100;%10 Foie_V5
CG_OAR(11,1)=5;  %11 SeinContro_Dmean
CG_OAR(12,1)=20; %12 TH_Dmean 
CG_OAR(13,1)=20; %13 PRVMoelle_Dmax
CG_OAR(14,1)=5;  %14 Oeso_V35
CG_OAR(15,1)=5;  %15 Trachee_V35
       
Sensitivity=ones(1000,1);Specificity=zeros(1000,1);distance=ones(1000,1);
FN=zeros(1000,1);

for i=1:15
    if OAR(i,Output_OAR+(Mode-1)*15)<CG_OAR(Output_OAR)
        diff(i,1)=0;
    else diff(i,1)=1;
    end
end

Threshold(1,1)=min(param(1:15,Input));
Delta_Threshold=(max(param(1:15,Input))-min(param(1:15,Input)))/1000;
for j=2:1000
    Threshold(j,1)=Delta_Threshold+Threshold(j-1,1);
    obj_pos=find(param(1:15,Input) >= Threshold(j,1));
    obj_neg=find(param(1:15,Input) < Threshold(j,1));
    TP(j,1)=sum(diff(obj_pos,1));
    FP(j,1)=length(obj_pos)-TP(j,1);
    FN(j,1)=sum(diff(obj_neg,1));
    TN(j,1)=length(obj_neg)-FN(j,1);
    Sensitivity(j,1)=TP(j,1)/(TP(j,1) + FN(j,1));
    Specificity(j,1)=TN(j,1)/(TN(j,1) + FP(j,1));
    distance(j,:)= sqrt((1-Sensitivity(j,1))^2+(Specificity(j,1)-1)^2);
        
end
        [~, opt] = min(distance);
        AUC=abs(trapz(1-Specificity,Sensitivity));
        if AUC > 0.7
        figure;
        hold on; plot(1-Specificity(opt,1), Sensitivity(opt,1), 'or', 'MarkerSize', 10);
        hold on; plot(1-Specificity(opt,1), Sensitivity(opt,1), 'xr', 'MarkerSize', 12);
        hold on; axis square; grid on; xlabel('1 - specificity'); ylabel('sensibility');
        plot(1-Specificity,Sensitivity, '-b', 'LineWidth', 2);
        set(gca, 'fontsize', 13)
        title(['AROC-AUC = ' num2str(AUC) ' , ' num2str(Input_Name(Input)) '='  num2str(Threshold(opt)) ' , ' num2str(Mode_Name(Mode)) ' , ' num2str(Param_OAR(Output_OAR))]);
        clear diff obj_* TP FP FN TN Sensitivity Specificity distance; 
        end
        end
    end
end

%% ROC analyze Breast L

param(:,3)=VC(:,5);
for Input=1:3;   % 1=IMC 2=Age 3=VolPTV50-Eval
    Input_Name=["BMI","Age","Vol-PTV50"];
    for Mode=1:3;%1=3D 2=VMAT 3=Hybrid
        Mode_Name = ["3DCRT","VMAT","Hybrid"];
        for Output_OAR=1:15; % paramètres étudiés dans les OAR & Clinical  :
CG_OAR(1,1)=15;  %1 PoumonHomo_Dmean 
CG_OAR(2,1)=30;  %2 PoumonHomo_V20                                   
CG_OAR(3,1)=20;  %3 PoumonHomo_V30
CG_OAR(4,1)=5;   %4 PoumonHomo_NTCP 
CG_OAR(5,1)=5;   %5 PoumonContro_Dmean
CG_OAR(6,1)=50;  %6 PoumonHomoContro_V5
CG_OAR(7,1)=5;   %7 Coeur_Dmean
CG_OAR(8,1)=10;  %8 Coeur_V25 
CG_OAR(9,1)=30;  %9 IVA_V30 
CG_OAR(10,1)=100;%10 Foie_V5
CG_OAR(11,1)=5;  %11 SeinContro_Dmean
CG_OAR(12,1)=20; %12 TH_Dmean 
CG_OAR(13,1)=20; %13 PRVMoelle_Dmax
CG_OAR(14,1)=5;  %14 Oeso_V35
CG_OAR(15,1)=5;  %15 Trachee_V35
       
Sensitivity=ones(1000,1);Specificity=zeros(1000,1);distance=ones(1000,1);
FN=zeros(1000,1);

for i=16:30
    if OAR(i,Output_OAR+(Mode-1)*15)<CG_OAR(Output_OAR)
        diff(i,1)=0;
    else diff(i,1)=1;
    end
end

Threshold(1,1)=min(param(16:30,Input));
Delta_Threshold=(max(param(16:30,Input))-min(param(16:30,Input)))/1000;
for j=2:1000
    Threshold(j,1)=Delta_Threshold+Threshold(j-1,1);
    obj_pos=find(param(16:30,Input) >= Threshold(j,1));
    obj_neg=find(param(16:30,Input) < Threshold(j,1));
    TP(j,1)=sum(diff(obj_pos,1));
    FP(j,1)=length(obj_pos)-TP(j,1);
    FN(j,1)=sum(diff(obj_neg,1));
    TN(j,1)=length(obj_neg)-FN(j,1);
    Sensitivity(j,1)=TP(j,1)/(TP(j,1) + FN(j,1));
    Specificity(j,1)=TN(j,1)/(TN(j,1) + FP(j,1));
    distance(j,:)= sqrt((1-Sensitivity(j,1))^2+(Specificity(j,1)-1)^2);
        
end
        [~, opt] = min(distance);
        AUC=abs(trapz(1-Specificity,Sensitivity));
        if AUC > 0.7
        figure;
        hold on; plot(1-Specificity(opt,1), Sensitivity(opt,1), 'or', 'MarkerSize', 10);
        hold on; plot(1-Specificity(opt,1), Sensitivity(opt,1), 'xr', 'MarkerSize', 12);
        hold on; axis square; grid on; xlabel('1 - specificity'); ylabel('sensibility');
        plot(1-Specificity,Sensitivity, '-b', 'LineWidth', 2);
        set(gca, 'fontsize', 13)
        title(['AROC-AUC = ' num2str(AUC) ' , ' num2str(Input_Name(Input)) '='  num2str(Threshold(opt)) ' , ' num2str(Mode_Name(Mode)) ' , ' num2str(Param_OAR(Output_OAR))]);
        clear diff obj_* TP FP FN TN Sensitivity Specificity distance; 
        end
        end
    end
end