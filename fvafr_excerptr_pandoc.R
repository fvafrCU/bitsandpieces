if (! cuutils::is_windows()) stop("This is meant for windows at fvafr!")
if (cuutils::is_32bit()) stop("Run the 64 bit Version of R (RStudio: Tools: Global Options...)! ")
path <- system.file("tests", "files", "some_file.R", package = "excerptr")
cat(readLines(path), sep = "\n")
setwd("c:")
excerptr::excerptr(file_name = path, run_pandoc = FALSE, output_path = tempdir())
is_pandoc_installed <- nchar(Sys.which("pandoc")) > 0 &&
    nchar(Sys.which("pandoc-citeproc")) > 0
is_pandoc_version_sufficient <- FALSE
if (is_pandoc_installed) {
    reference <- "1.12.3"
    version <- strsplit(system2(Sys.which("pandoc"), "--version", stdout = TRUE), 
                        split = " ")[[1]][2]
    if (utils::compareVersion(version, reference) >= 0)
        is_pandoc_version_sufficient <- TRUE
}
if (is_pandoc_version_sufficient) {
    output_path <- tempdir()
    excerptr::excerptr(file_name = path,
                       output_path = output_path, run_pandoc = FALSE)
    html_file <- file.path(output_path, sub("\\.R$", ".html", basename(path)))
    system2(command = basename(Sys.which("pandoc")),
            args = c(file.path(output_path, sub("\\.R$", ".md", basename(path))), "-o",
                     html_file))
    if (interactive()) utils::browseURL(html_file)
}
    
  