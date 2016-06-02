clear all

nobs = 10000;

traits = {'helper','hinderer'};
traitp = [0.5,0.5];
genders = {'male','female'};
genderp = [0.5,0.5];
relations = {'family','friend','stranger'};
relationp = [0.2, 0.3, 0.5];

tic
for i = 1:nobs
    tr = mnrnd(1, traitp);
    trait(i) = find(tr);
    gr = mnrnd(1, genderp);
    gender(i) = find(gr);
    rr = mnrnd(1, relationp);
    relation(i) = find(rr);
    
   [helpR(i), hindR(i), intent(i), observation(i)] = mentalModel(trait(i),[relation(i) gender(i)]);
end
toc

pHelp_HelperContext = length(find(observation(trait==1)))

