algoritmo "QuizMatematicoAvancadoComVidasCorrigido"

var
   opcao, nivel, pontos, respostaTentativa: inteiro
   operador, continuar, usuario: caractere
   resultado, numum, numdois: inteiro
   vidas: inteiro

//===========================
// REGISTRADOR DE USUÁRIO
//===========================
procedimento registradorUsuario()
inicio

   escreval("+---------------------------------------+")
   escreval("|               Nextage                 |")
   escreval("|      Olá Jogador seja bem vindo       |")
   escreval("|---------------------------------------|")
   escreval("|      Digite seu nome de jogador       |")
   escreval("+---------------------------------------+")
   leia(usuario)
   se usuario = "" entao
      usuario <- "Jogador"
   fimse
fimprocedimento

//===================================
// REGISTRO BOAS VINDAS AO JOGADORES
//===================================


//===========================
// GERAR NÚMEROS
//===========================
procedimento gerarNumeros(nivel: inteiro; var num1: inteiro; var num2: inteiro)
inicio
   escolha nivel
   caso 1
      num1 <- randi(10) + 1
      num2 <- randi(10) + 1
   caso 2
      num1 <- randi(41) + 10
      num2 <- randi(41) + 10
   caso 3
      num1 <- randi(51) + 50
      num2 <- randi(51) + 50
   outrocaso
      num1 <- 1
      num2 <- 1
   fimescolha
fimprocedimento

//===========================
// DEFINIR OPERAÇÃO
//===========================
procedimento definirOperacao(var num1: inteiro; var num2: inteiro; var operador: caractere; var resultado: inteiro)
var op: inteiro
inicio
   op <- randi(4)
   escolha op
   caso 0
      operador <- "+"
      resultado <- num1 + num2
   caso 1
      operador <- "-"
      resultado <- num1 - num2
   caso 2
      operador <- "*"
      resultado <- num1 * num2
   caso 3
      enquanto num2 = 0 faca
         num2 <- randi(10) + 1
      fimenquanto
      operador <- "/"
      resultado <- num1 div num2
   fimescolha
fimprocedimento

//===========================
// SALVAR PONTUAÇÃO (Simulado)
//===========================
procedimento salvarPontuacaoArquivo(nome: caractere; pts: inteiro)
inicio
   escreval("[DEBUG] Salvando pontuação de ", nome, ": ", pts, " ponto(s). (Simulado)")
fimprocedimento

//===========================
// MOSTRAR RANKING (Simulado)
//===========================

procedimento mostrarRanking()
inicio
   escreval("+---------------------------------------------------------+")
   escreval("|                    RANKING (simulado)                   |")
   escreval("| (Implementar leitura de arquivo futuramente)            |")
   escreval("+---------------------------------------------------------+")
fimprocedimento

//===========================
// MOSTRAR PONTUAÇÃO
//===========================
procedimento mostrarPontuacao(pontos: inteiro; nome: caractere)
inicio
   escreval("+------------------------------------+")
   escreval("|          PLACAR ATUAL              |")
   escreval("|------------------------------------|")
   escreval("| ", nome, " - ", pontos, " ponto(s) |")
   escreval("+------------------------------------+")
   limpatela()
fimprocedimento

//===========================
// JOGAR
//===========================
procedimento jogar()
var
   perguntas, acertos, i: inteiro
inicio
   escreval("+-----------------------------------------+")
   escreval("| Escolha o nível de dificuldade:         |")
   escreval("+-----------------------------------------+")
   escreval("| 1 - Fácil (1 a 10)                      |")
   escreval("| 2 - Médio (10 a 50)                     |")
   escreval("| 3 - Difícil (50 a 100)                  |")
   escreval("+-----------------------------------------+")
   escreva("Nível: ")
   leia(nivel)
   limpatela()
   se (nivel < 1) ou (nivel > 3) entao
      escreval("Nível inválido. Voltando ao menu.")
      retorne
   fimse

   perguntas <- 10
   acertos <- 0
   vidas <- 3

   para i de 1 ate perguntas faca
      se vidas <= 0 entao
         interrompa
      fimse

      gerarNumeros(nivel, numum, numdois)
      definirOperacao(numum, numdois, operador, resultado)

      escreval()
      escreval("-----------------------------------------")
      escreval("Pergunta ", i, " de ", perguntas, " | Vidas: ", vidas)
      escreval("Resolva: ", numum, " ", operador, " ", numdois, " = ?")
      escreva("Digite sua resposta: ")
      leia(respostaTentativa)

      se respostaTentativa = resultado entao
         escreval("? CORRETO! +1 ponto!")
         pontos <- pontos + 1
         acertos <- acertos + 1
      senao
         vidas <- vidas - 1
         escreval("? ERRADO! A resposta correta era ", resultado)
         escreval("Você perdeu 1 vida. Vidas restantes: ", vidas)
         se vidas = 0 entao
            escreval()
            escreval("?? Você perdeu todas as vidas! Fim do jogo.")
            escreval("-----------------------------------------")
            interrompa
         fimse
      fimse
   fimpara

   escreval()
   escreval("Fim da rodada! Você acertou ", acertos, " de ", perguntas)
   escreval("Pontuação total: ", pontos)
   salvarPontuacaoArquivo(usuario, pontos)
   escreval("-----------------------------------------")
   escreval()
fimprocedimento

//===========================
// MENU PRINCIPAL
//===========================
procedimento mostrarMenuPrincipal()
inicio
   limpatela()
   escreval("+----------------------------------+")
   escreval("|             NEXTAGE              |")
   escreval("|----------------------------------|")
   escreval("| 1 - Jogar                        |")
   escreval("| 2 - Ver Pontuação                |")
   escreval("| 3 - Ver Ranking (simulado)       |")
   escreval("| 4 - Registrar/Alterar Jogador    |")
   escreval("| 5 - Sair                         |")
   escreval("+----------------------------------+")
   escreva("Escolher uma opção: ")
   leia(opcao)
   limpatela()
fimprocedimento

//===========================
// PROGRAMA PRINCIPAL
//===========================
inicio
   pontos <- 0
   usuario <- "Jogador"
   continuar <- "S"

   registradorUsuario()

   enquanto (continuar = "S") ou (continuar = "s") faca
      mostrarMenuPrincipal()

      escolha opcao
      caso 1
         jogar()
      caso 2
         mostrarPontuacao(pontos, usuario)
      caso 3
         mostrarRanking()
      caso 4
         registradorUsuario()
      caso 5
         escreval("Obrigado por jogar! Até logo.")
         continuar <- "N"
      outrocaso
         escreval("Opção inválida. Tente novamente.")
      fimescolha

      se opcao <> 5 entao
         escreva("Deseja voltar ao menu principal? (S/N): ")
         leia(continuar)
         limpatela()
      fimse
   fimenquanto

fimalgoritmo
