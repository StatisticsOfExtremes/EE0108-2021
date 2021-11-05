install.packages("renv")
install.packages("dplyr")

library("renv")

renv::snapshot()

library("tidyr")
library("magrittr")
library("dplyr")


dados <- read.csv("~/EE108/TRAB1/dados/Dados_auto_sd_pecas2_exec_graduacao_lista_final.csv", sep = ';')


###Questão 01

#tamanho de mercado dado na atividade
M <- 18271717


#A o market share de cada modelo é 
dados <- dados %>% mutate(fatia_mercado = vendas/M)
