%% Load model

model =  readCbModel ('yeast-GEM.xml');
% printConstraints(model,-1000,1000)

%% Applying given constraints 

glu = -6;
O2max = -5;
model = changeRxnBounds(model,'r_1714', glu,'b');
model = changeRxnBounds(model,'r_1992', O2max, 'l');

%% Find theoretical maximum of ethanol production

model = changeObjective(model,'r_1761');
FBAethanol = optimizeCbModel(model,'max');
ethanolmax = getfield(FBAethanol , 'f' );

%% Performing FSEOF

model = changeObjective(model,'r_4041');
r = 4058;
fseof = zeros(r, 11);
for i = 1:11
    constraint = ((i-1)/10)*ethanolmax;
    model = changeRxnBounds(model,'r_1761', constraint,'b');
    FBAi = optimizeCbModel(model, 'max');
    vi = getfield(FBAi , 'v' );
    fseof(:, i) = vi;
end

%% Overexpression and knockout determined by FSEOF

overexpress = [];
knockout = [];
for i = 1:r
    diff = zeros(1, 9);
    for j = 2:10
        diff(1, j-1) = fseof(i,j) - fseof(i, j-1) ;
    if all(diff> 0) 
        overexpress = [overexpress,model.rxnNames(i)];
        model.rxnNames(i)
    end
    if all(diff < 0)     
        knockout = [knockout,model.rxnNames(i)];
    end
    end
end


 
    

