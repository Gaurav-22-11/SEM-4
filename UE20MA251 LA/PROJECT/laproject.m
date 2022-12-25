function laproject(cmd)
%labyrinth for playing the  Maze game.
% In this game you will use the numeric keypad. Num Lock should be active
% before you start. You have to find your way to the maze's exit by
% pressing the right keys. You have to press the number in the square where
% you want to move. The player can only move up, down, left and right. If
% you get stuck, the game ends.
% The game consist of five different mazes which are created randomly. The
% game gets harder for each level, first level has 0-5 as options and the
% fifth level has 0-9 as options. The goal is to get to the exit as quick
% as possible with the least amount of keypresses.
% Every wrong keypress counts as three keypresses.
% You have 60 seconds and 100 keypresses on you to get to the exit of each
% maze. The score that is counted at the end is the sum of remaining
% seconds and remaining keypresses. At the end of the fifth maze you can
% your score is saved if it beats the highscore. Improve your results and
% be the numeric keypad master!
% Idea and text taken from <a href="http://www.platinagames.com/game5.html">http://www.platinagames.com</a>
if ~nargin
    eval([mfilename,'(''init'')'])
    return;
end
if ~(ischar(cmd)||isscalar(cmd))
    return;
end
switch cmd
    case 'init'
        scrsz = get(0,'ScreenSize');
        hFigure = figure( ...
            'Name','MATRIX LABYRINTH', ...
            'Menubar','none',...
            'NumberTitle','off', ...
            'KeyPressFcn',[mfilename,'(double(get(gcbf,''Currentcharacter'')))'], ...
            'Units','pixels', ...
            'Position',[(scrsz(3)-780)/2 (scrsz(4)-400)/2 780 400], ...
            'Color',[.95 .95 .95], ...
            'Colormap',[1 1 1;[0.2 0.3 0.5]], ...
            'Visible','on', ...
            'CloseRequestFcn',@closeRequestFcn);
        FileMenu = uimenu(hFigure,'Label','File');
        uimenu(FileMenu,'Label','New Game','Accelerator','N',...
            'Callback',[mfilename,'(''NewGame'')']);
        uimenu(FileMenu,'Label','Exit','Accelerator','Q',...
            'Separator','on','Callback',@closeRequestFcn);
        HelpMenu = uimenu(hFigure,'Label','Help');
        uimenu(HelpMenu,'Label','Help','Accelerator','H',...
            'Callback',['helpwin ',mfilename]);
        uimenu(HelpMenu,'Label','About',...
            'Callback',[mfilename,'(''About'')'],'Separator','on');
        setappdata(hFigure,'axes',axes( ...
            'Parent',hFigure, ...
            'Units','normalized', ...
            'Position',[-.05 0 1.05 1]));
        setappdata(hFigure,'surface',surface( ...
            zeros(11,20),zeros(10,19), ...
            'Parent',gca, ...
            'EdgeColor',[0.6,0.6,0.6], ...
            'LineWidth',1));
        axis off
        hold on
        patch([4.5,4.5,16.5,16.5,4.5],[10.5,10.9,10.9,10.5,10.5],[1,1,1],...
            'EdgeColor',[0,0,0],'FaceAlpha',0.4)
        setappdata(hFigure,'HighScoreText',text('Position',[5,10.5],...
            'String','','FontUnits','Normalized',...
            'HorizontalAlignment','left',...
            'VerticalAlignment','bottom','Color',[0,0,0]))
        setappdata(hFigure,'MazeText',text('Position',[7.8,10.5],...
            'String','','FontUnits','Normalized',...
            'HorizontalAlignment','left',...
            'FontWeight','bold',...
            'VerticalAlignment','bottom','Color',[0,0,0]))
        setappdata(hFigure,'ScoreText',text('Position',[9.6,10.5],...
            'String','','FontUnits','Normalized',...
            'HorizontalAlignment','left',...
            'VerticalAlignment','bottom','Color',[0,0,0]))
        setappdata(hFigure,'TimeText',text('Position',[11.6,10.5],...
            'String','','FontUnits','Normalized',...
            'HorizontalAlignment','left',...
            'VerticalAlignment','bottom','Color',[0,0,0]))
        setappdata(hFigure,'KeyPressesText',text('Position',[13.4,10.5],...
            'String','','FontUnits','Normalized',...
            'HorizontalAlignment','left',...
            'VerticalAlignment','bottom','Color',[0,0,0]))
        setappdata(hFigure,'timer',...
            timer('TimerFcn',@timerFcn,'Period',1,...
            'ExecutionMode','FixedRate','UserData',hFigure))
        [X,Y] = pol2cart(linspace(0,2*pi,100),ones(1,100)*.3);
        setappdata(hFigure,'Xpos',X+0.5)
        setappdata(hFigure,'Ypos',Y+0.5)
        setappdata(hFigure,'positionpatch',patch(1,1,[1,0.3,0.3],...
            'EdgeColor',[0.6,0.6,0.6]*0.5))
        if exist([mfilename,'.highscore'],'file')
            try
                setappdata(hFigure,'HighScore',...
                    getfield(load([mfilename,'.highscore'],'-mat'),'highscore')) 
            catch
                setappdata(hFigure,'HighScore',0)
            end
        else
            setappdata(hFigure,'HighScore',0)
        end
        eval([mfilename,'(''NewGame'')'])
    case 'NewGame'
        setappdata(gcf,'level',5)
        createLevel(5)
        drawCurrentPosition()
        setappdata(gcf,'Maze',1)
        setappdata(gcf,'Score',0)
        setappdata(gcf,'Time',0)
        setappdata(gcf,'KeyPresses',0)
        updateText()
        stop(getappdata(gcf,'timer'));
        setappdata(gcf,'start',clock)
        start(getappdata(gcf,'timer'));
    case 'About'
        ico = ones(13)*3; % create simple icon matrix
        ico(:,1:4:13) = 1;
        ico(1:4:13,:) = 1;
        ico(2:4,10:12) = 2;
        ico(6:8,2:4) = 2;
        ico(10:12,10:12) = 2;
        map = [0 0 0;0.2 0.3 0.5;1 1 1];
        msgbox(sprintf([...
            'Graphical User Interface for playing the Numeric Keypad Maze game.\n\n'...
            'Developed by Divija,Dhathri,Gaurav and Harshitha\n'...
            ]),...
            'About: Numeric Keypad Maze','custom',ico,map)
    case {48,49,50,51,52,53,54,55,56,57}
        if(strcmp(get(getappdata(gcf,'timer'),'Running'),'on'))
            if(getappdata(gcf,'KeyPresses')>=100)
                stop(getappdata(gcf,'timer'));
                msgbox(sprintf('Game Over, to many keypresses!\nPlease try again.'))
                return;
            end
            board = getappdata(gcf,'board');
            [i,j] = find(board==-1);
            iswitch = [-1 1 0 0];
            jswitch = [0 0 -1 1];
            for tmp=1:4
                iind = iswitch(tmp)+i;
                jind = jswitch(tmp)+j;
                if(jind>0 && board(iind,jind)==cmd-48)
                    board(i,j) = NaN;
                    board(iind,jind) = -1;
                    setappdata(gcf,'board',board)
                    delete(getappdata(gcf,['text',num2str(iind*19+jind)]))
                    setappdata(gcf,'KeyPresses',getappdata(gcf,'KeyPresses')+1)
                    updateText()
                    drawCurrentPosition()
                    if(jind==19)
                        ingoal()
                    end
                    return;
                end
            end
            setappdata(gcf,'KeyPresses',getappdata(gcf,'KeyPresses')+3)
            updateText()
            if(getappdata(gcf,'KeyPresses')>=100)
                stop(getappdata(gcf,'timer'));
                msgbox(sprintf('Game Over, to many keypresses!\nPlease try again.'))
                return;
            end
        end
end
function ingoal()
stop(getappdata(gcf,'timer'));
level = getappdata(gcf,'level')+1;
setappdata(gcf,'Score',getappdata(gcf,'Score')+...
    100-getappdata(gcf,'KeyPresses')+...
    60-getappdata(gcf,'Time'))
setappdata(gcf,'Time',0)
setappdata(gcf,'KeyPresses',0)
updateText()
if level<10
    setappdata(gcf,'Maze',level-4)
    setappdata(gcf,'level',level)
    createLevel(level)
    drawCurrentPosition()
    setappdata(gcf,'start',clock)
    start(getappdata(gcf,'timer'));
else
    score = getappdata(gcf,'Score');
    highscore = getappdata(gcf,'HighScore');
    if score>highscore
        highscore = score;
        try %#ok<TRYNC>
            save([mfilename,'.highscore'],'highscore')
        end
        setappdata(gcf,'HighScore',highscore);
        updateText()
        msgbox(sprintf('Congratulations, we have a new High Score!'))
    else
        msgbox(sprintf('You didn''t beat the High Score\n Please try again.'))
    end
end
function createLevel(level)
delete(findobj(gcf,'tag','text'))
board = getNewBoard(level);
set(getappdata(gcf,'surface'),'CData',isnan(board)+1)
setappdata(gcf,'board',board);
for i=2:9
    for j=1:19
        if ~(isnan(board(i,j))||board(i,j)==-1)
            setappdata(gcf,['text',num2str(i*19+j)],text( ...
                'Position',[j i]+.5, ...
                'String',board(i,j), ...
                'Color',[0.2 0.3 0.5], ...
                'FontSize',12,...
                'Tag','text',...
                'FontUnits','Normalized',...
                'HorizontalAlignment','center'))
        end
    end
end
function updateText()
set(getappdata(gcf,'HighScoreText'),'String',...
    sprintf('High Score: %d',getappdata(gcf,'HighScore')))
set(getappdata(gcf,'MazeText'),'String',...
    sprintf('Maze: %d',getappdata(gcf,'Maze')))
set(getappdata(gcf,'ScoreText'),'String',...
    sprintf('Score: %3d',getappdata(gcf,'Score')))
set(getappdata(gcf,'KeyPressesText'),'String',...
    sprintf('Keypresses: %3d',getappdata(gcf,'KeyPresses')))
function drawCurrentPosition()
board = getappdata(gcf,'board');
set(getappdata(gcf,'surface'),'CData',isnan(board)+1)
[i,j] = find(board==-1);
set(getappdata(gcf,'positionpatch'),...
    'XData',getappdata(gcf,'Xpos')+j,...
    'YData',getappdata(gcf,'Ypos')+i)
function timerFcn(varargin)
hFigure = get(varargin{1},'UserData');
setappdata(hFigure,'Time',floor(etime(clock,getappdata(hFigure,'start'))))
set(getappdata(hFigure,'TimeText'),...
    'String',sprintf('Time: %d',getappdata(hFigure,'Time')))
if(getappdata(hFigure,'Time')>=60)
    stop(getappdata(hFigure,'timer'));
    msgbox(sprintf('Game Over, time is up!\nPlease try again.'))
end
function closeRequestFcn(varargin)
htimer = getappdata(gcf,'timer');
% stop the timer
try %#ok<TRYNC>
    stop(htimer)
    delete(htimer)
end
% close the figure window
closereq
function board = getNewBoard(level)
levelrand = @()(ceil(rand*(level+1))-1);
board = zeros(10,19)-1;
board(2,2) = levelrand();
for i=3:9
    r = levelrand();
    while(board(i-2,2)==r)
        r = levelrand();
    end
    board(i,2) = r;
end
for j=3:19
    for i=2:9
        r = levelrand();
        while(isempty(setdiff(r,[board(i,j-2),board(i-1,j-1),...
                board(i+1,j-1),board(i-1,j),board(max(1,i-2),j)])))
            r = levelrand();
        end
        board(i,j) = r;
    end
end
endpos = 1:10;
endpos(ceil(8*rand)+1) = [];
board(endpos,19) = NaN;
board(:,1) = NaN;
board([1,10],:) = NaN;
for i=3:2:17
    bricks = randperm(8)+1;
    board(bricks(1:3),i) = NaN;
end
board(bricks(8),1) = -1;