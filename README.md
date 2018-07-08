# slm
smart local moving (SLM) algorithm is an algorithm for community detection (or clustering) in large networks

# usage

the package is based on the jar file, so the system require java 1.8+ 

``` r
devtools::install_github("chen198328/slm")

library(igraph)
library(igraphdata)
library(slm)

data("karate")

slm<-slm.community(karate)
plot(slm.karate)
```

# plot
![image from host](http://ludowaltman.nl/slm/network.png)
