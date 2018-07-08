slm.community <-
  function(g,
           e.weight = "weight",
           modularity = 1,
           resolution = 1,
           algorithm = 3,
           nrandom = 10,
           iterations = 10,
           randomseed = 0,
           print = 0,
           memory.size="–Xmx4000m",
           stack.size="-Xss1000") {
    require(igraph)

    if (is.directed(g)) {
      g <-
        as.undirected(g,
                      mode = "collapse",
                      edge.attr.comb = list(e.weight = "sum", "ignore"))
    }

    nodes <- as_data_frame(g, what = "vertices")
    edges <- as_data_frame(g, what = "edges")

    nodes$seq <- seq_along(nodes$name)

    edges$from <-
      nodes[edges$from, "seq"] - 1 # index of input file starts with 0
    edges$to <- nodes[edges$to, "seq"] - 1


    ifelse(!is.null(e.weight) &
             e.weight %in% colnames(edges),
           edges <-
             edges[, c("from", "to", e.weight)],
           edges <- edges[, c("from", "to")])

    #generate the input file of modulartiyoptimizer.jar

    input <- tempfile(pattern = "input", fileext = ".network")
    output <- tempfile(pattern = "output", fileext = ".cluster")

    write.table(
      edges,
      file = input,
      sep = "\t",
      row.names = FALSE,
      col.names = FALSE
    )

    installed_path <- installed.packages()["slm", "LibPath"]

    jar.path <-
      file.path(installed_path, "slm", "java", "ModularityOptimizer.jar")

    jar.path <- paste('"', jar.path, '"', sep = "")

    input.quote <- paste('"', input, '"', sep = "")
    output.quote <- paste('"', output, '"', sep = "")

    args <-
      c(memory.size,
        stack.size,
        "-jar",
        jar.path,
        input.quote,
        output.quote,
        modularity,
        resolution,
        algorithm,
        nrandom,
        iterations,
        randomseed,
        print
      )

    res <- sys::exec_wait(cmd = "java", args = args) #调用cmd模式运行java

    if (file.exists(input)) {
      #file.remove(input)
    }

    if (file.exists(output)) {
      #success
      member <- read.table(output, header = FALSE)[, 1]
      #file.remove(output)
    } else{
      #failed
      member <- (seq_along(nodes$name) - 1)
    }

    res <- NULL

    res$membership <- (member + 1)

    res$vcount <- vcount(g)
    res$names <- V(g)$name
    res$algorithm <-
      "Smart Local Moving by Ludo Waltman and Nees Jan van Eck"

    class(res) <- "communities"

    res

  }
