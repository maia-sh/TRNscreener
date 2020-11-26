# Trial registration number screener

This *R* script provides a function that takes two arguments: the path to a folder of plain text files named by their DOI, and an output filename. For each file in the folder, it searches for trial identifiers based on regex matching and writes a CSV that contains all the trial registration numbers and in the case of ClinicalTrials.gov entries, whether they correspond to a registry entry on ClinicalTrials.gov.

By default, this *R* script will search for ClinicalTrials.gov NCT numbers as well as ISRCTN registry numbers, using regular expressions as defined starting at line 30, but you may add an arbitrary number of regular expressions that correspond to different registry entry formats. For NCT numbers only, the ClinicalTrials.gov API is used to verify the existence of the number.

The script outputs a CSV with one row per trial registration number found. The first column of the output CSV contains the DOI of the paper in which the identifier was found. The second column indicates the type of identifier (e.g. NCT or ISRCTN). The third column contains the identifier that was found. The fourth column indicates whether the NCT number corresponds to a legitimate record on ClinicalTrials.gov. 1 means yes, 0 means no, and NA means that it is not an NCT number.

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
