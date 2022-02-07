install.packages("renv")
install.packages("dplyr")
install.packages("stringr")
install.packages("broom")

library("renv")

renv::snapshot()

library("tidyr")
library("magrittr")
library("dplyr")
library("stringr")
library("broom")



dados <- read.csv("dados/Dados_auto_sd_pecas2_exec_graduacao_lista_final.csv", sep = ';')


###Questão 01

#tamanho de mercado dado na atividade
M <- 18271717


#A fatia_mercado = Sj
#preco_k = Preço dividido por 10000 (10k)
##o market share de cada modelo é
dados <- dados %>% mutate(fatia_mercado = vendas/M, y = log(fatia_mercado) - log(1 - sum(fatia_mercado)),
                          preco_k = Preco/10000)


modelo_linear <- lm(y ~ preco_k + ratio_HP_Peso + Gasolina, dados)

resultados <- broom::tidy(modelo_linear)

elas_ols = resultados$estimate[2] * (dados$preco_k) * (1 - dados$fatia_mercado)


#Lerner de todos os modelos
Li = 1 / abs(elas_ols)


modelos_selecionados <- c(1, 19, 51, 127)

#Nos indices de lerner, esses são os modelos
lerner_modelos <- Li[modelos_selecionados]



matriz_elast <- matrix(nrow = 4, ncol = 4)


for (i in 1:length(modelos_selecionados)){ 
  for (j in 1:length(modelos_selecionados)){
    if (i==j) {matriz_elast[i,i]=resultados$estimate[2] * (dados$preco_k[modelos_selecionados[i]]) * (1 - dados$fatia_mercado[modelos_selecionados[j]])}
    else {matriz_elast [i,j]= abs(resultados$estimate[2])*(dados$preco_k[modelos_selecionados[j]])*dados$fatia_mercado[modelos_selecionados[j]]}
  } 
}


#Com as variáveis instrumentais
