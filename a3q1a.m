%% Galactose

model =  readCbModel ('yeast-GEM.xml');
model = changeRxnBounds(model,'r_1710', -3.983182,'l');
model = changeRxnBounds(model,'r_1709', 0,'l');
model = changeRxnBounds(model,'r_2058', 0,'l');
model = changeRxnBounds(model,'r_1714', 0,'l');
model = changeRxnBounds(model,'r_1650', 0,'l');
model = changeObjective(model,'r_4041');
FBAgal = optimizeCbModel(model,'max');

%% Sucrose

model =  readCbModel ('yeast-GEM.xml');
model = changeRxnBounds(model,'r_2058', -2.084552,'l');
model = changeRxnBounds(model,'r_1709', 0,'l');
model = changeRxnBounds(model,'r_1714', 0,'l');
model = changeRxnBounds(model,'r_1710', 0,'l');
model = changeRxnBounds(model,'r_1650', 0,'l');
model = changeObjective(model,'r_4041');
FBAsuc = optimizeCbModel(model,'max');

%% Trehalose

model =  readCbModel ('yeast-GEM.xml');
model = changeRxnBounds(model,'r_1650', -2.142704,'l');
model = changeRxnBounds(model,'r_1709', 0,'l');
model = changeRxnBounds(model,'r_2058', 0,'l');
model = changeRxnBounds(model,'r_1710', 0,'l');
model = changeRxnBounds(model,'r_1714', 0,'l');
model = changeObjective(model,'r_4041');
FBAtre = optimizeCbModel(model,'max');

%% Fructose

model =  readCbModel ('yeast-GEM.xml');
model = changeRxnBounds(model,'r_1709', -4.406842,'l');
model = changeRxnBounds(model,'r_1714', 0,'l');
model = changeRxnBounds(model,'r_2058', 0,'l');
model = changeRxnBounds(model,'r_1710', 0,'l');
model = changeRxnBounds(model,'r_1650', 0,'l');
model = changeObjective(model,'r_4041');
FBAfru = optimizeCbModel(model,'max');

%% Glucose

model =  readCbModel ('yeast-GEM.xml');
model = changeRxnBounds(model,'r_1714', -4.187956,'l');
model = changeRxnBounds(model,'r_1709', 0,'l');
model = changeRxnBounds(model,'r_2058', 0,'l');
model = changeRxnBounds(model,'r_1710', 0,'l');
model = changeRxnBounds(model,'r_1650', 0,'l');
model = changeObjective(model,'r_4041');
FBAglu = optimizeCbModel(model,'max');

