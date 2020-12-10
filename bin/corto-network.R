#!/labs/genut/bin/Rscript
suppressPackageStartupMessages(library("argparse"))
library(corto)

parser <- ArgumentParser()

parser$add_argument("-i", "--input", default = FALSE,
    help = "Expression matrix in .RDS format")
parser$add_argument("-l", "--list", default = FALSE,
    help = "Transcription factor list")
parser$add_argument("-b", "--bootstraps", type = "integer", default = 10,
    help = "Number of bootstraps (default 10)")
parser$add_argument("-p", "--pvalue", default = 1e-7,
    help = "Treshold p-value (default 1e-7)")
parser$add_argument("-t", "--threads", type = "integer", default = 2,
    help = "Number of threads (default 2)")
parser$add_argument("-o", "--out", type = "character", default = "no_out",
    help = "Output .RData")
args <- parser$parse_args()


inmat <- readRDS(args$input)
tfs <- read.table(args$list, stringsAsFactors = FALSE)[[1]]
centroids <- tfs[tfs %in% rownames(inmat)]

regulon <- corto(inmat,
    centroids = centroids,
    nbootstraps = args$bootstraps,
    p = args$pvalue,
    nthreads = args$threads)

if (args$out == "no_out") {
        out <- paste0("results/",
        gsub(".RDS", ".regulon.RData",
        basename(args$input)
        )
    )
} else {
        out <- args$out
        }
save(regulon, file = out)
