\name{slm.community}
\alias{slm_community}
\title{smart local moving}
\usage{
slm.community(g, e.weight="weight", modularity = 1, resolution = 1, algorithm = 3, nrandom = 10, iterations = 10, randomseed = 0, print = 0)
}
\description{
smart local moving (SLM) algorithm is an algorithm for community detection (or clustering) in large networks. The SLM algorithm maximizes a so-called modularity function. The algorithm has been successfully applied to networks with tens of millions of nodes and hundreds of millions of edges. The details of the algorithm are documented in a paper (Waltman & Van Eck, 2013)
}

\arguments{
\item{g}{An \code{igraph} object as returned by \code{\link{igraph}}.}

\item{e.weight}{Vertex Attribute Name of weight}

\item{modularity}{Modularity function (1 = standard; 2 = alternative)}

\item{resolution}{Value of the resolution parameter}

\item{algorithm}{Algorithm for modularity optimization (1 = original Louvain algorithm; 2 = Louvain algorithm with multilevel refinement; 3 = SLM algorithm)}

\item{nrandom}{Number of random starts}

\item{iterations}{Number of iterations per random start}

\item{randomseed}{	Seed of the random number generator}

\item{print}{Whether or not to print output to the console (0 = no; 1 = yes)}

\item{memory.size}{When using VOSviewer with large amounts of data, the memory requirements may be substantial. If there is not enough memory available, an out of memory error will occur. }

\item{stack.size}{When working with large amounts of data, it is also possible that a stack overflow error will occur. The stack size then needs to be increased. }
}

\examples{
library(igraph)
library(igraphdata)
data("karate")

slm<-slm.community(karate)
plot(slm,karate)
}

