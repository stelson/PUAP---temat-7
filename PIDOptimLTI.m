function y = PIDOptimLTI(x)

    assignin('base','P',x(1));
    assignin('base','I',x(2));
    assignin('base','D',x(3));
    assignin('base','N',x(4));
    tic
    [t,xx,yy] = sim('ModelLTI.slx', 50);
    toc
    y = yy(size(yy, 1),1);
