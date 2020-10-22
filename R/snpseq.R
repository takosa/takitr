
#' @export
get_snpseq <- function(seq) {
  dplyr::if_else(stringr::str_detect(seq, "^[ATGC]{50,}\\[[ATGC]/[ATGC]\\][ATGC]{50,}$"), seq, NA_character_)
}

#' @export
to_iupac <- function(seq) {
  seq <- get_snpseq(seq)
  seq <- stringr::str_replace(seq, "\\[(A/T|T/A)\\]", "W")
  seq <- stringr::str_replace(seq, "\\[(A/G|G/A)\\]", "R")
  seq <- stringr::str_replace(seq, "\\[(A/C|C/A)\\]", "M")
  seq <- stringr::str_replace(seq, "\\[(T/G|G/T)\\]", "K")
  seq <- stringr::str_replace(seq, "\\[(T/C|C/T)\\]", "Y")
  seq <- stringr::str_replace(seq, "\\[(G/C|C/G)\\]", "S")
  seq
}

#' @export
search_genome_position <- function(seq, ref) {
  seq <- Biostrings::DNAStringSet(seq, use.names = TRUE)
  tf <- tempfile()
  Biostrings::writeXStringSet(seq, tf)
  outcol <- c("qseqid", "sseqid", "sstart", "qstart", "length", "qcovhsp", "qcovus", "pident", "btop", "evalue")
  out <- system2("/home/tosabe/local/bin/blastn", args = c("-db", ref, "-query", tf, "-outfmt '6", outcol, "'", "-max_target_seqs 1 -max_hsps 1"), stdout = TRUE, env = "PATH=/home/tosabe/local/bin")
  out <- strsplit(out, "\t")
  dplyr::bind_rows(purrr::map(out, ~tibble::as_tibble_row(purrr::set_names(., nm = outcol))))
  
}