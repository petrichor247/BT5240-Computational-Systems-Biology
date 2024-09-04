%% Load model

tbmodel = loadBiGGModel('iEK1008', 'sbml');

%% Single Gene Deletion to check for essential genes

genelist = {'Rv3804c', 'Rv1857', 'Rv2246', 'Rv1662', 'Rv0467', 'Rv3496c', 'Rv2383c'};
[grRatio, grRateKO, grRateWT, delRxns, fluxSolution] = singleGeneDeletion(tbmodel, geneList = genelist);

%% Double Gene Deletion to check for synthetic lethal pairs

[grRatioDble, grRateKODble, grRateWTDble] = doubleGeneDeletion(tbmodel, geneList1 = genelist);

%% Finding reactions and metabolites associated with the given genes

tbmodel = creategrRulesField(tbmodel);
tbmodel = buildRxnGeneMat(tbmodel);
[results, listresults]= findRxnsFromGenes(tbmodel,genelist, ListResultsFlag = 1);
[metList, stoich] = findMetsFromRxns(tbmodel, listresults(:,1));
rxns = cell2table(listresults);
metabolites = cell2table(metList);
