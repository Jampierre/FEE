require(ca) 
require(ggplot2)
library(dplyr)
library(plotly)

###########################################
# Leitura de dados
###########################################
data<-read.csv2("C:/Users/dlanzari/Desktop/Pós/Merge_apenas_categoricas.csv", sep=";" ,encoding =  "UTF-8" )
names(data)

###########################################
#Função da Análise de Correspondência
###########################################
analise_correspondecia <- function(data) 
{
  categ= apply(data, 2, function(x) nlevels(as.factor(x)))
  ca = mjca(data, lambda="indicator", nd=4) 
  ca$sv^2 
  ca$colcoord 
  ca$rowcoord 
  ca_var= data.frame(ca$colcoord, Variable=rep(names(categ), categ)) 
  rownames(ca_var) = ca$levelnames 
  
  p <- ggplot(data=ca_var, aes(x=X2, y=X1,label=rownames(ca_var)
                          )) + 
    geom_hline(yintercept=0, colour="white") + 
    geom_vline(xintercept=0, colour="white") + 
    geom_text(aes(colour=Variable)) + 
    ggtitle("MCA plot of variables using R package ca ")
  
  ggplotly(p)
}

######################################################################################
#Fazendo uma análise geral da Base, com objetivo de manter o entendimento da escala 
######################################################################################
ca_data=cbind(data$evolucao_Problema.Clínico, data [,(11:450)])
analise_correspondecia(ca_data)

###########################################
# Base de paciente
###########################################
data_paciente= cbind(data$evolucao_Problema.Clínico, data [,(11:91)])
analise_correspondecia(data_paciente)
# Relevantes
# paciente_Cigarros..dia....Tabagista_de.10.a.20 (O)
# paciente_Cigarros..dia....Tabagista_de.20.a.40 (0)
# paciente_Grau.de.Instrução_Superior (1)
#	paciente_Tratamento.Dislipidemia_Sem.Tratamento (1)
# paciente_Grau.de.Instrução_Mestrado.ou.Doutorado (1)

#################################################################################################################################
#Base de procedimento - Primeiro é gerado uma análise de todas as variáveis em seguida uma específica das features de interesse
#################################################################################################################################
data_procedimento= cbind(data$evolucao_Problema.Clínico, data [,(92:205)])
analise_correspondecia(data_procedimento)

data_procedimento_interesse=data %>%
    select("evolucao_Problema.Clínico","procedimento_Anestesia...Intervenção_Geral.Sedação_sum",
    "procedimento_Clopidogrel.1_lt.6h_sum",
    "procedimento_Clopidogrel.1_gt.6h_sum",
    "procedimento_Droga...Intervenção_Xilocaína.2._sum",
    "procedimento_Introdutor...Intervenção_7F_sum",
    "procedimento_Nome.Comercial...Intervenção_HENETIX.350_sum",
    "procedimento_Ticlopidina_Não_sum",
    "procedimento_Ticlopidina_Sim_sum",
    "procedimento_Tipo.Contraste...Intervenção_Não.iônico.de.baixa.osmolaridade_sum",
    "procedimento_Trombolítico.Prévio...Resgate_Nenhum_sum") 
analise_correspondecia(data_procedimento_interesse)

#procedimento_Anestesia...Intervenção_Geral.Sedação_sum=0
#procedimento_Clopidogrel.1_lt.6h_sum=0
#procedimento_Clopidogrel.1_gt.6h_sum=1
#procedimento_Droga...Intervenção_Xilocaína.2._sum=1
#procedimento_Introdutor...Intervenção_7F_sum=1
#procedimento_Nome.Comercial...Intervenção_HENETIX.350_sum =0
#procedimento_Ticlopidina_Não_sum=1
#procedimento_Tipo.Contraste...Intervenção_Não.iônico.de.baixa.osmolaridade_sum =0 
#procedimento_Trombolítico.Prévio...Resgate_Nenhum_sum=1


###########################################
#Base de complicação 
###########################################
data_complicação= cbind(data$evolucao_Problema.Clínico, data [,(206:230)])
analise_correspondecia(data_complicação)
 
# nenhuma exceto óbito foi próxima o suficiente


#################################################################################################################################
# Base de balão  - Primeiro é gerado uma análise de todas as variáveis em seguida uma específica das features de interesse
#################################################################################################################################
data_balao= cbind(data$evolucao_Problema.Clínico, data [,(231:294)])
analise_correspondecia(data_balao)
#balao_Vaso.coronário...Balão_Dg3_sum
#balao_Vaso.coronário...Balão_Dg1_sum
#balao_Vaso.coronário...Balão_Dg2_sum
#balao_Vaso.coronário...Balão_VPD_sum
#balao_Tipo...Dissecção...Balão_B_sum
#balao_Classificação.da.Lesão..ACC.AHA....Balão_A_sum"
# balao_Vaso.coronário...Balão_DPD_sum
# balao_Tipo...Dissecção...Balão_C_sum
# balao_Tipo...Dissecção...Balão_F_sum
# balao_Vaso.coronário...Balão_VPE_sum
# balao_Classificação.da.Lesão..ACC.AHA....Balão_B1_sum"


data_balao_interesse=data %>%
  select("evolucao_Problema.Clínico",
         "balao_Vaso.coronário...Balão_Dg3_sum",
         "balao_Vaso.coronário...Balão_Dg1_sum",
         "balao_Vaso.coronário...Balão_Dg2_sum",
         "balao_Vaso.coronário...Balão_VPD_sum",
         "balao_Tipo...Dissecção...Balão_B_sum",
         "balao_Classificação.da.Lesão..ACC.AHA....Balão_A_sum",
         "balao_Vaso.coronário...Balão_DPD_sum",
         "balao_Tipo...Dissecção...Balão_C_sum",
         "balao_Tipo...Dissecção...Balão_F_sum",
         "balao_Vaso.coronário...Balão_VPE_sum",
         "balao_Classificação.da.Lesão..ACC.AHA....Balão_B1_sum") 
analise_correspondecia(data_balao_interesse)

###########################################
# Base de stent
###########################################
data_stent= cbind(data$evolucao_Problema.Clínico, data [,(294:450)])
analise_correspondecia(data_stent)
#stent_Resultado.Angiográfico...Stent_S...Sucesso_sum"


###########################################
# Base de vaso
###########################################

data_vaso= cbind(data$evolucao_Problema.Clínico, data [,(451:553)])
analise_correspondecia(data_vaso)
#vaso_Calcificação...Intervenção_Acentuada_sum =1 
#"vaso_Tipo.de.Lesão...Intrastent...Intervenção_Focal_sum" =1
#vaso_Placa.Rota...Intervenção_Sim_sum =1 
#"vaso_Tipo.de.Lesão...Intrastent...Intervenção_Oclusão_sum" =1 


###############################################################
# Análise com todas informações mais relevantes levantadas
###############################################################

data_geral_interesse=data %>%
  select("evolucao_Problema.Clínico",
          "paciente_Cigarros..dia....Tabagista_de.10.a.20",
         "paciente_Cigarros..dia....Tabagista_de.20.a.40",
         "paciente_Grau.de.Instrução_Superior",
         "paciente_Tratamento.Dislipidemia_Sem.Tratamento",
         "paciente_Grau.de.Instrução_Mestrado.ou.Doutorado",
         "procedimento_Anestesia...Intervenção_Geral.Sedação_sum",
         "procedimento_Clopidogrel.1_lt.6h_sum",
         "procedimento_Clopidogrel.1_gt.6h_sum",
         "procedimento_Droga...Intervenção_Xilocaína.2._sum",
         "procedimento_Introdutor...Intervenção_7F_sum",
         "procedimento_Nome.Comercial...Intervenção_HENETIX.350_sum",
         "procedimento_Ticlopidina_Não_sum",
         "procedimento_Ticlopidina_Sim_sum",
         "procedimento_Tipo.Contraste...Intervenção_Não.iônico.de.baixa.osmolaridade_sum",
         "procedimento_Trombolítico.Prévio...Resgate_Nenhum_sum",
         "balao_Vaso.coronário...Balão_Dg3_sum",
         "balao_Vaso.coronário...Balão_Dg1_sum",
         "balao_Vaso.coronário...Balão_Dg2_sum",
         "balao_Vaso.coronário...Balão_VPD_sum",
         "balao_Tipo...Dissecção...Balão_B_sum",
         "balao_Classificação.da.Lesão..ACC.AHA....Balão_A_sum",
         "balao_Vaso.coronário...Balão_DPD_sum",
         "balao_Tipo...Dissecção...Balão_C_sum",
         "balao_Tipo...Dissecção...Balão_F_sum",
         "balao_Vaso.coronário...Balão_VPE_sum",
         "balao_Classificação.da.Lesão..ACC.AHA....Balão_B1_sum",
         "stent_Resultado.Angiográfico...Stent_S...Sucesso_sum",
         "vaso_Calcificação...Intervenção_Acentuada_sum",
         "vaso_Tipo.de.Lesão...Intrastent...Intervenção_Focal_sum",
         "vaso_Placa.Rota...Intervenção_Sim_sum",
         "vaso_Tipo.de.Lesão...Intrastent...Intervenção_Oclusão_sum") 
analise_correspondecia(data_geral_interesse)
         
         
         
         