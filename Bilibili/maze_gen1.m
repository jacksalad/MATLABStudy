global n m g dir
[n,m] = deal(30,30);
g = zeros(n,m); % 迷宫数组
dir = {[1,0],[-1,0],[0,1],[0,-1]};
figure
axis square off
axis([1 n+1 1 m+1]);
hold on
% 画封闭迷宫
for i = 1:n
    for j = 1:m
        rectangle('position',[i j 1 1],'edgecolor','r','facecolor','w','linewidth',2)
    end
end
rectangle('position',[1 1 n m],'edgecolor','k','linewidth',3)
p = [1 1];
g(p(1),p(2)) = -1;
pass = {};
for t = 1:n*m-1
    % 确保非死角
    if ~alive(p)
        for i = 1:length(pass)
            p = pass{i};
            if alive(p)
                break
            end
        end
    end
    % 随机选取方向
    d = randi(4);
    % 确保可以拆墙
    while ~check(p+dir{d})
        d = randi(4);
    end
    p = p+dir{d};     % 移动位置
    g(p(1),p(2)) = d; % 标记位置
    pass{end+1} = p;
    draw(p)
    pause(0.03)
end
% 判断是否合法位置
function res = check(p)
global n m g
[i,j] = deal(p(1),p(2));
res = i > 0 && i <= n && j > 0 && j <= m && g(i,j) == 0;
end
% 判断非死角
function res = alive(p)
global dir
res = false;
for d = 1:4
    res = res || check(p+dir{d});
end
end
% 拆墙绘图
function draw(p)
global g
[i,j] = deal(p(1),p(2));
a = 0.05;
switch g(i,j)
    case 1
        plot([i,i],[j+a,j+1-a],'color','w','linewidth',2)
    case 2
        plot([i+1,i+1],[j+a,j+1-a],'color','w','linewidth',2)
    case 3
        plot([i+a,i+1-a],[j,j],'color','w','linewidth',2)
    case 4
        plot([i+a,i+1-a],[j+1,j+1],'color','w','linewidth',2)
end
end
