clc
clear
close all

% Case06.m — 瞬态响应分析后处理
% 读取 1.csv, 2.csv, 3.csv (Optistruct 瞬态分析位移结果)
% 省略中间稳态过程 (约2s–300s)，仅保留有较明显变化的初始瞬态与最终卸载阶段

%% 读取数据
data1 = readmatrix("1.csv");
data2 = readmatrix("2.csv");
data3 = readmatrix("3.csv");

t1 = data1(:, 1);   d1 = data1(:, 2);
t2 = data2(:, 1);   d2 = data2(:, 2);
t3 = data3(:, 1);   d3 = data3(:, 2);

%% 提取初始瞬态阶段 (0–2 s)
idx_init1 = t1 <= 2;
idx_init2 = t2 <= 2;
idx_init3 = t3 <= 2;

t1_init = t1(idx_init1);   d1_init = d1(idx_init1);
t2_init = t2(idx_init2);   d2_init = d2(idx_init2);
t3_init = t3(idx_init3);   d3_init = d3(idx_init3);

%% 提取最终卸载阶段 (300–305.5 s)
idx_final1 = t1 >= 300;
idx_final2 = t2 >= 300;
idx_final3 = t3 >= 300;

t1_final = t1(idx_final1);   d1_final = d1(idx_final1);
t2_final = t2(idx_final2);   d2_final = d2(idx_final2);
t3_final = t3(idx_final3);   d3_final = d3(idx_final3);

%% 图1：初始瞬态响应
f01 = figure(1);
f01.Position = [0, 0, 600, 450];
hold on
grid on
plot(t1_init, d1_init, "Color", "r", "LineWidth", 1);
plot(t2_init, d2_init, "Color", "g", "LineWidth", 1);
plot(t3_init, d3_init, "Color", "b", "LineWidth", 1);
title("Initial Transient Response (0–2 s)", "FontSize", 18, "FontWeight", "bold")
xlabel("Time (s)", "FontSize", 12);
ylabel("Displacement (mm)", "FontSize", 12);
legend("1.csv", "2.csv", "3.csv", "Location", "northeast", "FontSize", 10)
set(gca, "FontName", "Times New Roman", "FontSize", 12);
exportgraphics(gcf, "21_Event2.png", "Resolution", 600);

%% 图2：最终卸载响应
f02 = figure(2);
f02.Position = [0, 0, 600, 450];
hold on
grid on
plot(t1_final, d1_final, "Color", "r", "LineWidth", 1);
plot(t2_final, d2_final, "Color", "g", "LineWidth", 1);
plot(t3_final, d3_final, "Color", "b", "LineWidth", 1);
title("Final Unloading Response (300–305.5 s)", "FontSize", 18, "FontWeight", "bold")
xlabel("Time (s)", "FontSize", 12);
ylabel("Displacement (mm)", "FontSize", 12);
legend("1.csv", "2.csv", "3.csv", "Location", "northeast", "FontSize", 10)
set(gca, "FontName", "Times New Roman", "FontSize", 12);
exportgraphics(gcf, "21_Event3.png", "Resolution", 600);

