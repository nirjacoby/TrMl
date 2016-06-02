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

Results = [trait' relation' gender' helpR' hindR' intent' observation'];

obs_by_t = zeros(2,2);
obs_by_tg = zeros(4,2);
obs_by_tgr = zeros(12,2);
for i = 1:nobs
    ti = trait(i);
    tgi = 2*(gender(i)-1)+ti;
    tgri = 4*(relation(i)-1)+tgi;
    obs_by_t(ti,observation(i)) = obs_by_t(ti,observation(i))+1;
    obs_by_tg(tgi,observation(i)) = obs_by_tg(tgi,observation(i))+1;
    obs_by_tgr(tgri,observation(i)) = obs_by_tgr(tgri,observation(i))+1;
end

% transform trait x context rows to conditional probabilities 
sum_tgr = sum(obs_by_tgr,2);
p_tgr = sum_tgr/sum(sum_tgr);
p_obs_by_tgr (:,1) = obs_by_tgr(:,1)./sum_tgr;
p_obs_by_tgr (:,2) = obs_by_tgr(:,2)./sum_tgr;