options("packager" = list(force = TRUE))
me <- person(given = "Andreas Dominik", 
             family = "Cullmann",
             role = c("aut", "cre"),
             email = "adc-r@arcor.de")

packager::create("../asciidoc")
packager::set_package_info("../asciidoc",
                           author_at_r = me,
                           title = "Create Reports Using `knitr` and `asciidoc`", 
                           description = "I want to use asciidoc for html and slidy.",
                           details = "This was inspired by http://kbroman.org/knitr_knutshell/pages/asciidoc.html")
withr::with_dir("../asciidoc", git)

