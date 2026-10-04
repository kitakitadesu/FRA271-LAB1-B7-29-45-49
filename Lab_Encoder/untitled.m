%Considered From Choices-Based Problems in The Exam Sheet.

tiledlayout(1, 2);
nexttile;

content_ratio = [37.04, 37.04, 22.22, 22.22];
content_list = ["Electrostatics", "Electromagnetism", "DC Current", "AC Current"];

pattern_ratio = [66.67, 22.22, 11.11];
pattern_list = ["Calculation", "Integration", "Theory"];

piechart(content_ratio, content_list);
title("A-Level Average Electrics Content Ratio");
colororder sail;
nexttile;

piechart(pattern_ratio, pattern_list);
title("A-Level Average Electrics Problem Pattern Ratio");
colororder meadow;
