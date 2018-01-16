options("packager" = list(force = TRUE))
me <- person(given = "Andreas Dominik", 
             family = "Cullmann",
             role = c("aut", "cre"),
             email = "adc-r@arcor.de")


if (FALSE) {
    path <- "../asciidoc"
    packager::create(path)
    packager::set_package_info(path,
                               author_at_r = me,
                               title = "Create Reports Using `knitr` and `asciidoc`", 
                               description = "I want to use asciidoc for html and slidy.",
                               details = "This was inspired by http://kbroman.org/knitr_knutshell/pages/asciidoc.html")
    packager::git_add_commit(path = path, "Update Package Info")
    file.copy(file.path("..", "funktionen_in_r", "asciidoc.R"), file.path(path, "R"))
    packager::git_add_commit(path = path, "Add Core Functionality", untracked = TRUE)
}
