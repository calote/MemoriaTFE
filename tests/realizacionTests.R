# Realización de los test para comprobar que sigue funcionando todo correctamente
# 

# Copia primero "tfe_principal.Rmd" al directorio principal del proyecto 
# (se hace copia de seguridad del existente) y 
# luego se crea el fichero pdf

t0 = system.time()
#### INICIO PROCESO

setwd(here::here("tests"))

tfe_principal_raiz = "../tfe_principal.Rmd"
tfe_principal_raiz_pdf = "../tfe_principal.pdf"

file.copy(from = tfe_principal_raiz, to = "tfe_principal_raiz.Rmd", 
          overwrite = TRUE)

#### DIR 1


dir_prueba = "bibmet02_csl_ecology/"
tfe_principal_prueba = paste0(dir_prueba,"tfe_principal.Rmd")
tfe_principal_prueba_nuevo = paste0(dir_prueba,"tfe_principal_nuevo.Rmd")
tfe_principal_prueba_nuevo_pdf = paste0(dir_prueba,"tfe_principal_nuevo.pdf")

file.copy(from = tfe_principal_prueba, to = tfe_principal_raiz, 
          overwrite = TRUE)

rmarkdown::render(tfe_principal_raiz,  encoding = 'UTF-8')


file.copy(from = tfe_principal_raiz, to = tfe_principal_prueba_nuevo, 
          overwrite = TRUE)
file.copy(from = tfe_principal_raiz_pdf, to = tfe_principal_prueba_nuevo_pdf, 
          overwrite = TRUE)


# FINAL DEL PROCESO DE TESTS
file.copy(from = "tfe_principal_raiz.Rmd", to = tfe_principal_raiz, 
          overwrite = TRUE)

setwd(here::here())
t1 = system.time()

print("PROCESO TERMINADO")
print("TIEMPO DEL PROCESO COMPLETO:")
print(t1-t0)
















