# Trial registration number screener

This *R* script provides a function that takes two arguments: the path to a folder of plain text files named by their DOI, and an output filename. For each file in the folder, it searches for trial identifiers based on regex matching and writes a CSV that contains all the trial registration numbers and in the case of ClinicalTrials.gov entries, whether they correspond to a registry entry on ClinicalTrials.gov.

## Citing TRN-screener

Here is a BibTeX entry for *Trial registration number screener*:

```
@Manual{bgcarlisle-TRN-screener,
  Title          = {Trial registration number screener},
  Author         = {Carlisle, Benjamin Gregory},
  Organization   = {The Grey Literature},
  Address        = {Berlin, Germany},
  url            = {https://github.com/bgcarlisle/TRNscreener},
  year           = 2020
}
```

If you used this in your research and you found it useful, I would take it as a kindness if you cited it.

Best,

Benjamin Gregory Carlisle PhD
