clc
clear
close all

% 由 MATLAB 自动生成于 2026/05/04 15:19:15
%% 初始化变量。
filename = "Case02.txt";
startRow = 4;
%% 将数据列作为文本读取:
% 有关详细信息，请参阅 TEXTSCAN 文档。
formatSpec = "%7s%5s%15s%13s%13s%s%[^\n\r]";
%% 打开文本文件。
fileID = fopen(filename,"r");
%% 根据格式读取数据列。
% 该调用基于生成此代码所用的文件的结构。如果其他文件出现错误，请尝试通过导入工具重新生成代码。
dataArray = textscan(fileID, formatSpec, "Delimiter", "", "WhiteSpace", "", "TextType", "string", "HeaderLines" ,startRow-1, "ReturnOnError", false, "EndOfLine", "\r\n");
%% 关闭文本文件。
fclose(fileID);
%% 将包含数值文本的列内容转换为数值。
% 将非数值文本替换为 NaN。
raw = repmat({""},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
for col=[1,2,3,4,5,6]
    % 将输入元胞数组中的文本转换为数值。已将非数值文本替换为 NaN。
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % 创建正则表达式以检测并删除非数值前缀和后缀。
        regexstr = "(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)";
        try
            result = regexp(rawData(row), regexstr, "names");
            numbers = result.numbers;
            % 在非千位位置中检测到逗号。
            invalidThousandsSeparator = false;
            if numbers.contains(",")
                thousandsRegExp = "^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$";
                if isempty(regexp(numbers, thousandsRegExp, "once"))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % 将数值文本转换为数值。
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ",", "")), "%f");
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end
%% 创建输出变量
data = cell2mat(raw);
%% 清除临时变量
clearvars filename startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp;

mode = data(:, 2); %模态编号
freq = data(:, 3); %频率
egvl = data(:, 4); %特征值
stif = data(:, 5); %广义刚度
mass = data(:, 6); %广义质量

f01 = figure(1);
f01.Position = [0, 0, 600, 450];
hold on
grid on
plot(freq, mode, "Color", "b", "LineWidth", 1);
title("Mode-Frequency Plot", "FontSize", 18, "FontWeight", "bold")
xlabel("Frequency", "FontSize", 12);
ylabel("Mode", "FontSize", 12);
legend("Mode", "Location", "southeast", "FontSize", 10)
set(gca, "FontName", "Times New Roman", "FontSize", 12);
exportgraphics(gcf, "C020101.png", "Resolution", 600);

f02 = figure(2);
f02.Position = [0, 0, 600, 450];
hold on
grid on
plot(mode, egvl, "Color", "b", "LineWidth", 1);
title("Eigenvalue-Mode Plot", "FontSize", 18, "FontWeight", "bold")
xlabel("Mode", "FontSize", 12);
ylabel("Eigenvalue", "FontSize", 12);
legend("Eigenvalue", "Location", "southeast", "FontSize", 10)
set(gca, "FontName", "Times New Roman", "FontSize", 12);
exportgraphics(gcf, "C020102.png", "Resolution", 600);

f03 = figure(3);
f03.Position = [0, 0, 600, 450];
hold on
grid on
plot(mode, stif, "Color", "b", "LineWidth", 1);
title("Stiffness-Mode Plot", "FontSize", 18, "FontWeight", "bold")
xlabel("Mode", "FontSize", 12);
ylabel("Stiffness", "FontSize", 12);
legend("Stiffness", "Location", "southeast", "FontSize", 10)
set(gca, "FontName", "Times New Roman", "FontSize", 12);
exportgraphics(gcf, "C020103.png", "Resolution", 600);


