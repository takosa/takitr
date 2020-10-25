#' @importFrom magrittr %>%
#' @export
plot.CollapsedVCF <- function(vcf, type = 1L) {
  if (type == 1L) {
    contig <- VariantAnnotation::meta(VariantAnnotation::header(vcf))$contig
    genome <- regioneR::toGRanges(
      data.frame(
        chr = rownames(contig),
        start = 1L,
        end = contig$length
      )
    )
    marker_chr <- as.character(GenomicRanges::seqnames(rowRanges(vcf)))
    marker_x <- start(ranges(rowRanges(vcf)))
    karyoploteR::plotKaryotype(genome, plot.type = 6) %>% 
      karyoploteR::kpAddBaseNumbers() %>% 
      karyoploteR::kpPlotMarkers(chr = marker_chr, x = marker_x, y = 1.0, labels = "", line.color = "red")
    
  }
}