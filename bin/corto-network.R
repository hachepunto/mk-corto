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
parser$add_argument("-p", "--pvalue", type = "character", default = 1e-7,
    help = "Treshold p-value (default 1e-7)")
parser$add_argument("-t", "--threads", type = "integer", default = 2,
    help = "Number of threads (default 2)")
parser$add_argument("-o", "--out", type = "character", default = FALSE,
    help = "Output .RDS file")
args <- parser$parse_args()


inmat <- readRDS(args$input)
tfs <- read.table(args$list, stringsAsFactors = FALSE)[[1]]
centroids <- tfs[tfs %in% rownames(inmat)]

regulon <- corto(inmat,
    centroids = centroids,
    nbootstraps = as.numeric(args$bootstraps),
    p = as.numeric(args$pvalue),
    nthreads = as.numeric(args$threads),
    verbose = TRUE)

print("Saving")
saveRDS(regulon, file = args$out)
