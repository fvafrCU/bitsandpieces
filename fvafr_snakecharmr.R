
if (cuutils::is_windows()) {
    if (cuutils::is_32bit()) {
        py <- "86"
    } else {
       stop("Can't install SnakeCharmR on 64 bit, don't know why.")
        
    }
    Sys.setenv(
        PATH = paste(
            paste0("C:\\Python\\Python34_x", py),
            Sys.getenv("PATH"), 
            sep = ";"
        )
    )
        
}
if (! require("SnakeCharmR", character.only = TRUE)) cuutils::install_github("asieira/SnakeCharmR")


