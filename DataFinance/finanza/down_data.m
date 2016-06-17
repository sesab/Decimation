% download stock data from a list imported from data.
%

savefolder='DATA';

filename='IBB_holdings.csv';
datastart=12;
dataend=202;
list1=importfile(filename,datastart,dataend);

filename='SPsmallcup_holdings.csv';
datastart=10;
dataend=608;
list2=importfile(filename,datastart,dataend);

filename='SP500_holdings.csv';
datastart=10;
dataend=518;
list3=importfile(filename,datastart,dataend);


listtmp=union(list1,list2);
list=union(listtmp,list3);

save lista.txt list -ascii
%save(fullfile(savefolder,'lista.mat'),list);

list=list1;


savefolder='DATA';
% Initialize websites and companies
website={'yahoo'};
Tickers=[];
Tickers.RNAi.(website{1})=list;
% Tickers.RNAi.(website{2})={'ISIS','ALNY','Tkmr','ARWR','Mrna','SRPT','RXII'};
% Tickers.RNAi.(website{2})={'NASDAQ:ISIS','NASDAQ:ALNY','NASDAQ:Tkmr','NASDAQ:ARWR',...
%     'NASDAQ:Mrna','NASDAQ:SRPT','NASDAQ:RXII'};
Tickers.Indices={'all'};
d1.yahoo='May 31, 2010';
d2.yahoo='May 31, 2016';
% d1.google='01-Jan-2012';
% d2.google='15-Mar-2014';
stock=[]; url.RNAi=[];



w=1;        
for i=1:numel(Tickers.RNAi.(website{w}))
            tick=Tickers.RNAi.(website{w}){i};
            if( strcmp(tick,'BRKB') ~=1)
                fprintf('\n---downloading(%s)---%s\n',website{w},tick);
%             stock.RNAi.(tick) = get_yahoo_stockdata2(tick,d1.(website{w}),d2.(website{w}),'d',false);
                stock{i} = get_yahoo_stockdata2(tick,d1.(website{w}),d2.(website{w}),'d',false);
            end
end
            

filename='Historical_data.mat';
save(fullfile(savefolder,filename),'stock','d1','d2','Tickers','website');
