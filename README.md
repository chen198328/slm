# slm
smart local moving (SLM) algorithm is an algorithm for community detection (or clustering) in large networks

# usage

``` r
devtools::install_github("chen198328/slm")

library(igraph)
library(igraphdata)
library(slm)

data("karate")

slm<-slm.community(karate)
plot(slm.karate)
```
