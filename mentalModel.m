
function [helpR, hindR, action, outcome] = mentalModel(trait,context)
    [helpR, hindR] = computeState(trait,context);
    action = computeIntent(helpR,hindR);
    outcome = computeObservation(action);
end    

function [helpR, hindR] = computeState1(trait,context) %helper or hinderer, ignores context
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

function [helpR, hindR] = computeState2(trait,context) %helps family and friends, ignores trait
%    drawB = @(a,b) random(makedist('beta','a',a,'b',b));
%    drawB2 = @(a,b) betainv(rand,a,b);

    if context(1) <= 2 % relation is family or firend
        helpR = betainv(rand, 4,1); %drawB(4,1);
        hindR = betainv(rand, 1,4); %drawB(1,4);
    else 
        helpR = betainv(rand, 1,4); %drawB(1,4);
        hindR = betainv(rand, 4,1); %drawB(4,1);
    end
end

function [helpR, hindR] = computeState3(trait,context) % helps family and friends, ignores trait
    helpscore = 1; %at baseline, act randomly, trait and context can up modulate propensity to help
    helpscore = helpscore + (2 - trait); % add 1 points for helper, 0 for hinderer
    helpscore = helpscore + 0.5*(3 - context(1)); % add 1 points for family, 0.5 for friend and 0 for stranger
    helpscore = helpscore + 0.5*(context(2) - 1); % add 0.5 points for female, 0 for male
    
    helpR = betainv(rand, helpscore, 1); %drawB(4,1);
    hindR = betainv(rand, 1, helpscore); %drawB(1,4);
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
    competence = 1; %noise parameter
    outcome = rand<competence;
    if outcome
        outcome = action;
    else
        outcome = setdiff([1 2],action);
    end
end
