
function [helpR, hindR, action, outcome] = mentalModel(trait,context)
    [helpR, hindR] = computeState(trait,context);
    action = computeIntent(helpR,hindR);
    outcome = computeObservation(action);
end    

function [helpR, hindR] = computeState(trait,context)
%    drawB = @(a,b) random(makedist('beta','a',a,'b',b));
%    drawB2 = @(a,b) betainv(rand,a,b);

    if trait == 1 % helper
        helpR = betainv(rand, 4,1); %drawB(4,1);
        hindR = betainv(rand, 1,4); %drawB(1,4);
    else 
        helpR = betainv(rand, 1,4); %drawB(1,4);
        hindR = betainv(rand, 4,1); %drawB(4,1);
    end
end

function intent = computeIntent(helpR, hindR)
    tao = 0.01;  %noise parameter
    pHelp = exp(helpR/tao)/(exp(helpR/tao)+exp(hindR/tao));
    act = rand<pHelp;
    if act
        intent = 1; % help;
    else
        intent = 2; % hinder;
    end
end

function outcome = computeObservation(action)
    competence = 1;
    outcome = rand<competence;
    if outcome
        outcome = action;
    else
        outcome = setdiff([1 2],action);
    end
end
