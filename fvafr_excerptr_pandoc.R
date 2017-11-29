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

ex_sys_pandoc <- function(path, format) {
    excerptr::excerptr(file_name = path,
                       output_path = dirname(path), run_pandoc = FALSE)
    md_file <- sub("\\.[rRsS]$", ".md", path)
    out_file <- sub("\\.md$", paste0(".", format), md_file)
    system2(command = basename(Sys.which("pandoc")),
            args = c(md_file, "-o",
                     out_file))
    if (! file.exists(out_file)) {
        stop("Could not compile ", file)
    } else {
        return(out_file)
    }
}

if (is_pandoc_version_sufficient) {
    file_path <- file.path(tempdir(), basename(path))
    file.copy(path, file_path)
    res <- ex_sys_pandoc(file_path, "html")
    if (interactive()) utils::browseURL(res)
}
    
  
