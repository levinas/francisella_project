## Francisella Sequence Comparison

Define regions of difference (RDs or SNPs) by comparing genomes of six
isolates to a published F. tularensis Schu S4 genomic sequence.

### Reference

Francisella tularensis Schu S4: GenBank AJ749949.2

### Six isolates

* Francisella tularensis Schu S4 FSC043
  http://www.ncbi.nlm.nih.gov/bioproject?cmd=Retrieve&dopt=Overview&list_uids=217352
* Francisella tularensis Schu S4 FTS-634/635
  http://www.ncbi.nlm.nih.gov/bioproject?cmd=Retrieve&dopt=Overview&list_uids=217353
* Francisella tularensis Schu S4 NR-10492
  http://www.ncbi.nlm.nih.gov/bioproject?cmd=Retrieve&dopt=Overview&list_uids=217349
* Francisella tularensis Schu S4 NR-28534
  http://www.ncbi.nlm.nih.gov/bioproject?cmd=Retrieve&dopt=Overview&list_uids=217348
* Francisella tularensis Schu S4 NR-643
  http://www.ncbi.nlm.nih.gov/bioproject?cmd=Retrieve&dopt=Overview&list_uids=217350
* Francisella tularensis Schu S4 SL
  http://www.ncbi.nlm.nih.gov/bioproject?cmd=Retrieve&dopt=Overview&list_uids=217351

### Summary

Isolate_name | SNPs (NCBI assembly) |SNPs (reads: Pond lib) |  SNPs (reads: Solexa lib) | Ref bases with no read coverage |
--- | --- | --- | --- | --- |
FSC043   |  1 | 0/0 |  0/0 | 0 |
FTS-634  |  8 | 6/0 |  6/6 | 0 |
NR-10492 |  1 | 0/0 |  0/1 | 0 |
NR-28534 |  2 | 0/0 |  0/2 | 0 |
NR-643   |  8 | 7/7 | 10/11 | 0 |
SL       | 10 | 0/0 |  0/1 | 298 (0.016%) |

Each isolate is associated with two paired-end libraries. The number
of SNPs estimated through read mapping is shown in the format of `#
raw SNPs / filtered SNPs`. The minimum variant fraction for filtered
SNPs is 0.3.


### Analysis

* [vcf/](vcf): Raw SNPs estimated by read mapping (BWA-mem v0.7.7, Samtools v0.1.19)
* [snps/](snps): Annotated filtered SNPs
* [bbhs/](bbhs): Protein-protein bidiretional best hits and unique proteins (reference vs de novo assemblies, both annotated using RAST)
* [mummer/](mummer): DNA-level difference computed using Mummer (reference vs de novo assemblies)
* [uncov/](uncov): Base positions in the reference contigs with no read coverage
* [assembly/](assembly): De novo assemblies computed using Assembly-RAST (--recipe rast)
* [rast2/](rast2): RAST2 annotations of de novo assembled contigs
* [olive-mummer/](olive-mummer): DNA-level difference (reference vs NCBI scaffolds downloaded from the Broad Oliver site)
