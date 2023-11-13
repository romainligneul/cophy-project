clear all

folder_stats_json='../stats';
%% t-test example
clear test
load stockreturns
x = stocks(:,3);
[test.h,test.p,test.ci,test.stats] = ttest(x);
% save the test as json
testname='ttest_stock';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

%% anova example
clear test
load hogg
hogg
[test.p,test.tbl,test.stats] = anova1(hogg,[],'off');

% save the test as json
testname='anova_hogg';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

%% anova example
% json is very flexible but it does not like the tables returned by
% matlab's anova functions (who does?), so we adjust a bit the output
clear test
load hogg
hogg
[test.p,tbl,test.stats] = anova1(hogg,[],'off');
test.stats.df1=cell2mat(tbl(2,3));
test.stats.F=cell2mat(tbl(2,5));

% save the test as json
testname='anova_hogg3';
encodedStats=jsonencode(test);
fid = fopen([folder_stats_json '\' testname '.json'],'w');
fprintf(fid,'%s',encodedStats);
fclose(fid);

% 
%  //var fstats = await d3.json(pathFile)
%     //const fstats = require("data_analysis/stats/anova_hogg.json");
%     /*
%     var outputStr='(F('+ fstats["stats"]["df"] + ')=' + tstats["stats"]["tstat"].toFixed(2) + ", " + "p=" + tstats["p"].toFixed(4) + ", CI["+tstats["ci"][0].toFixed(2)+','+tstats["ci"][1].toFixed(2)+'])'  
%     */  
%    /*
%    var outputStr
%       await fetch("./data_analysis/stats/anova_hogg.json")
%       .then(response => response.json())
%       .then(function(fstats){
%         outputStr=fstats.tbl
%         })
%       .catch(error => console.log(error));
%     return outputStr
%     */
