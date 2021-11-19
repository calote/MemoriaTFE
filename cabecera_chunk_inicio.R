options(kableExtra.latex.load_packages = F)
knitr::opts_chunk$set(fig.path = 'figurasR/',
                      echo = TRUE, warning = FALSE, message = FALSE,
                      fig.pos="H",fig.align="center",out.width="95%",
                      cache=FALSE)
knitr::write_bib(c("knitr","rmarkdown"),
                 file="bib/paquetes.bib", width = 60)
