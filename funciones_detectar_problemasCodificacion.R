library(utf8)

# EJEMPLO DE USO:
# source("funciones_detectar_problemasCodificacion.R")
# vficheros01 = c("portadas/latex_paginatitulo_modTFE.tex",
#                 "bib/library.bib","bib/paquetes.bib",
#                 "prologo.Rmd","resumen.Rmd","abstract.Rmd",
#                 "capitulo01.Rmd","capitulo02.Rmd", "capitulo03.Rmd",
#                 "capitulo04.Rmd","capitulo05.Rmd")
# func_utf8_corregir_problemas_ficheros(vficheros01, sobreescribir = TRUE)




func_utf8_numlineas_detectaproblemas = function(fichero) {

  contenidofichero = readLines(fichero)
  #fichero[!utf8_valid(fichero)]
  cuantaslineas = sum(!utf8_valid(contenidofichero))
  return(cuantaslineas)
}

# USO:
#func_utf8_numlineas_detectaproblemas(fichero =  "portadas/latex_paginatitulo_modTFE.tex")
#func_utf8_numlineas_detectaproblemas(fichero =  "capitulo01.Rmd")

func_utf8_quelineas_detectaproblemas = function(fichero) {
  
  contenidofichero = readLines(fichero)
  #fichero[!utf8_valid(fichero)]
  quelineas = contenidofichero[!utf8_valid(contenidofichero)]
  return(list(
    QueLineas = which(!utf8_valid(contenidofichero)),
    Lineas = quelineas
    )
  )
}

# USO:
# func_utf8_quelineas_detectaproblemas(fichero = "portadas/latex_paginatitulo_modTFE.tex")
# func_utf8_quelineas_detectaproblemas(fichero = "capitulo01.Rmd")




func_utf8_corregir_problemas = function(fichero, sobreescribir = FALSE) {
  numproblemas = func_utf8_numlineas_detectaproblemas(fichero)
  if (numproblemas>0) {
    contenidofichero = readLines(fichero)
    Encoding(contenidofichero) = "latin1"
    contenidoficheroMej = as_utf8(contenidofichero, normalize = T)
    if (sobreescribir) {
      file.rename(fichero,paste0(fichero,"_Anterior"))
      writeLines(contenidoficheroMej, fichero)
      cat("El fichero: ",fichero, " contiene las correcciones!!!")
    } else {
      writeLines(contenidoficheroMej, paste0(fichero,"_Corregido"))
      cat("El fichero: ",paste0(fichero,"_Corregido"), " contiene las correcciones!!!")
    }
    return(TRUE)
  } else {
    return(FALSE)
  }

}

# USO:
#func_utf8_corregir_problemas(fichero = "portadas/latex_paginatitulo_modTFE.tex", sobreescribir = T)
#


func_utf8_corregir_problemas_ficheros = function(vficheros, sobreescribir = FALSE) {
  
  for (i in seq_along(vficheros)) {
      func_utf8_corregir_problemas(vficheros[i], sobreescribir)
  }
  
}


# USO:
# vficheros01 = c("portadas/latex_paginatitulo_modTFE.tex",
#                 "bib/library.bib","bib/paquetes.bib",
#                 "prologo.Rmd","resumen.Rmd","abstract.Rmd",
#                 "capitulo01.Rmd","capitulo02.Rmd", "capitulo03.Rmd",
#                 "capitulo04.Rmd","capitulo05.Rmd")
# func_utf8_corregir_problemas_ficheros(vficheros01, sobreescribir = FALSE)
# func_utf8_corregir_problemas_ficheros(vficheros01, sobreescribir = TRUE)




# library(utf8)
# output_ansi()
# 
# fichero = readLines("portadas/latex_paginatitulo_modTFE.tex")
# fichero[!utf8_valid(fichero)]
# 
# Encoding(fichero) = "latin1"
# 
# fichero2 = as_utf8(fichero, normalize = T)
# fichero2[!utf8_valid(fichero2)]
# 
# fichero = readLines("capitulo01.Rmd")
# fichero[!utf8_valid(fichero)]
