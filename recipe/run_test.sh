#!/usr/bin/env bash
set -e

# A few test commands, borrowed from https://github.com/cms-analysis/HiggsAnalysis-CombinedLimit/blob/main/.github/workflows/cvmfs-ci.yml
text2workspace.py  HiggsAnalysis/CombinedLimit/data/tutorials/multiDim/toy-hgg-125.txt -m 125 -P HiggsAnalysis.CombinedLimit.PhysicsModel:floatingXSHiggs --PO modes=ggH,qqH
combine -M MultiDimFit HiggsAnalysis/CombinedLimit/data/tutorials/multiDim/toy-hgg-125.root  --setParameterRanges r=-1,1
text2workspace.py HiggsAnalysis/CombinedLimit/data/tutorials/CAT23001/datacard-3-parametric-analysis.txt -o ws_parametric-analysis.root --mass 125
combine -M MultiDimFit ws_parametric-analysis.root  --algo singles --setParameterRanges r=-2,1
