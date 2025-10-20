algoritmo "QuizMatematicoAvancado"
// Versão reorganizada com mais procedimentos e um "banco de dados" simples baseado em arquivo
// OBS: adapte as chamadas de arquivo (abrir/escrever/ler/fechar) ao seu interpretador Portugol/compilador.

var
   opcao, nivel, pontos, resposta: inteiro
   operador, continuar, usuario : caractere
   resultado, numum, numdois : inteiro
   linha : caractere

// --- Procedimentos utilitários ---
//eu não sei oq eu estou fazendo: bernardo 2025

procedimento registrarUsuario()
inicio
   escreva("Digite seu nome de jogador: ")
   leia(usuario)
   se usuario = "" entao
      usuario <- "Jogador"
   fimse
fimprocedimento

procedimento limparTela()
inicio
   // Dependendo do ambiente, pode usar comandos para limpar a tela.
   // Aqui só imprimimos linhas em branco para "separar".
   escreval("")
   escreval("------------------------------------------------")
fimprocedimento

// Gera dois números conforme o nível
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

// Define operação aleatória e calcula resultado
procedimento definirOperacao(var num1: inteiro; var num2: inteiro; var operador: caractere; var resultado: inteiro)
inicio
   escolha randi(4)
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
      // garantir divisor não-zero
      enquanto num2 = 0 faca
         num2 <- randi(10) + 1
      fimenquanto
      operador <- "/"
      resultado <- num1 div num2  // divisão inteira
   fimescolha
fimprocedimento

// --- Banco de dados simples (arquivo) ---
// Observação: as funções de arquivo abaixo são placeholders.
// Substitua por abrirArquivoRead/Write/Append, lerLinha, etc., conforme seu ambiente.

procedimento salvarPontuacaoArquivo(nome: caractere; pts: inteiro)
inicio
   // Escreve uma linha no formato: nome;pts
   // Adapte os procedimentos de arquivo ao seu interpretador.
   // Exemplo conceitual:
   // arquivo <- abrir("pontuacoes.txt", "a")
   // escrevaArquivo(arquivo, nome, ";", pts, "\n")
   // fechar(arquivo)
   escreval("[DEBUG] Salvando pontuação: ", nome, " ; ", pts, " (adaptar para escrever em arquivo)")
fimprocedimento

procedimento mostrarRanking()
var arquivoConteudo: caractere
inicio
   escreval("+-------------------------+")
   escreval("¦        RANKING          ¦")
   escreval("+-------------------------+")
   // Ler o arquivo pontuacoes.txt e mostrar linhas ordenadas é recomendado.
   // Aqui exibimos uma mensagem de placeholder e instrução para implementação.
   escreval("(Implemente leitura do arquivo 'pontuacoes.txt' e ordene por pontos para mostrar o ranking.)")
   escreval("+------------------------+")
fimprocedimento

// --- Interface e exibição ---

procedimento mostrarMenuPrincipal()
inicio
   limparTela()
   escreval("+----------------------------------+")
   escreval("¦          Nextage alan            ¦")
   escreval("¦----------------------------------¦")
   escreval("¦ 1 - Jogar                        ¦")
   escreval("¦ 2 - Ver Pontuação                ¦")
   escreval("¦ 3 - Ver Ranking (arquivo)        ¦")
   escreval("¦ 4 - Registrar/Alterar Jogador    ¦")
   escreval("¦ 5 - Sair                         ¦")
   escreval("+----------------------------------+")
   escreva("Escolha uma opção: ")
   leia(opcao)
   limpatela()
fimprocedimento

procedimento mostrarPontuacao(pontos: inteiro; nome: caractere)
inicio
   escreval("+----------------------------------+")
   escreval("¦    PLACAR ATUAL                  ¦")
   escreval("¦----------------------------------¦")
   escreval("¦                                  ¦")
   escreval("¦", nome, " - ", pontos, " ponto(s)¦")
   escreval("¦                                  ¦")
   escreval("+----------------------------------+")
   limpatela()
fimprocedimento

// --- Lógica do jogo ---

procedimento jogar()
var perguntas, acertos: inteiro
inicio
   limparTela()
   escreval("Escolha o nível de dificuldade:")
   escreval("1 - Fácil (números de 1 a 10)")
   escreval("2 - Médio (números de 10 a 50)")
   escreval("3 - Difícil (números de 50 a 100)")
   escreva("Nível: ")
   leia(nivel)
   se (nivel < 1) ou (nivel > 3) entao
      escreval("Nível inválido. Voltando ao menu.")
      retorne
   fimse

   // Permitir várias perguntas por sessão
   perguntas <- 3 // número de perguntas por rodada (pode tornar configurável)
   acertos <- 0

   mod i de 1 ate perguntas faca
      gerarNumeros(nivel, numum, numdois)
      definirOperacao(numum, numdois, operador, resultado)
      escreval("Resolva: ", numum, " ", operador, " ", numdois, " = ?")
      escreva("Sua resposta: ")
      leia(resposta)

      se resposta = resultado entao
         escreval("******************************")
         escreval("*         CORRETO!           *")
         escreval("*      +1 ponto ganho        *")
         escreval("******************************")
         pontos <- pontos + 1
         acertos <- acertos + 1
      senao
         escreval("******************************")
         escreval("*          ERRADO!           *")
         escreval("*     pontos resetados       *")
         escreval("******************************")
         escreval("A resposta correta era ", resultado)
         // opcional: zerar pontos em caso de erro
         pontos <- 0
         // Você pode optar por terminar a rodada ao errar:
         // pare
      fimse
    limpatela()
   escreval("Fim da rodada. Acertos nesta rodada: ", acertos, " de ", perguntas)
   // Persistir pontuação no "banco"
   salvarPontuacaoArquivo(usuario, pontos)
fimprocedimento

// --- Programa principal ---
inicio
   pontos <- 0
   usuario <- "Jogador"
   continuar <- "S"

 // perguntar nome inicialmente
   registrarUsuario()

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
         registrarUsuario()
      caso 5
         escreval("Obrigado por jogar! Até logo.")
      outrocaso
         escreval("Opção inválida. Tente novamente.")
      fimescolha

      se opcao <> 5 entao
         escreva("Deseja voltar ao menu? (S/N): ")
         leia(continuar)
      senao
         continuar <- "N"
      fimse
   fimenquanto


fimalgoritmo


