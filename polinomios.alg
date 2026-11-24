algoritmo "Polinomios"
// Raizes de polinomios e produto de polinomios (Visualg)
// Cada polinomio guarda os coeficientes em um vetor:
// posicao k guarda o coeficiente de x^(k-1). Ex.: x^2+3x-10 -> [-10, 3, 1]

var
   polin: vetor[1..4,1..7] de inteiro   // 1=p, 2=q, 3=r, 4=s
   graus: vetor[1..4] de inteiro
   pol, pa, pb, w, quo: vetor[1..7] de inteiro
   grau, gpa, gpb, gw: inteiro
   k: inteiro

// Carrega o polinomio n (1 a 4) no vetor de trabalho "pol"
procedimento CarregaPol(n: inteiro)
var t: inteiro
inicio
   para t de 1 ate 7 faca
      pol[t] <- polin[n, t]
   fimpara
   grau <- graus[n]
fimprocedimento

// Carrega o polinomio n no vetor "pa" (primeiro fator)
procedimento CarregaA(n: inteiro)
var t: inteiro
inicio
   para t de 1 ate 7 faca
      pa[t] <- polin[n, t]
   fimpara
   gpa <- graus[n]
fimprocedimento

// Carrega o polinomio n no vetor "pb" (segundo fator)
procedimento CarregaB(n: inteiro)
var t: inteiro
inicio
   para t de 1 ate 7 faca
      pb[t] <- polin[n, t]
   fimpara
   gpb <- graus[n]
fimprocedimento

// Multiplica pa * pb e deixa o resultado em "pol"
procedimento Multiplica()
var a, b: inteiro
inicio
   para a de 1 ate 7 faca
      pol[a] <- 0
   fimpara
   para a de 1 ate gpa + 1 faca
      para b de 1 ate gpb + 1 faca
         pol[a + b - 1] <- pol[a + b - 1] + pa[a] * pb[b]
      fimpara
   fimpara
   grau <- gpa + gpb
fimprocedimento

// Escreve o polinomio "pol" de forma legivel
procedimento MostraPol()
var t, c, m: inteiro
    primeiro: logico
inicio
   primeiro <- verdadeiro
   para t de grau + 1 ate 1 passo -1 faca
      c <- pol[t]
      se c <> 0 entao
         se c < 0 entao
            m <- 0 - c
         senao
            m <- c
         fimse

         se primeiro entao
            se c < 0 entao
               escreva("-")
            fimse
         senao
            se c < 0 entao
               escreva(" - ")
            senao
               escreva(" + ")
            fimse
         fimse

         se (t = 1) ou (m <> 1) entao
            escreva(m)
         fimse
         se (t > 1) e (m <> 1) entao
            escreva("*")
         fimse
         se t > 1 entao
            escreva("x")
         fimse
         se t > 2 entao
            escreva("^", t - 1)
         fimse
         primeiro <- falso
      fimse
   fimpara
   escreval("")
fimprocedimento

// Acha as raizes inteiras de "pol" testando divisores de -100 a 100
// e dividindo por (x - c) com o metodo de Briot-Ruffini.
// Repetir a divisao mostra a multiplicidade da raiz.
procedimento Raizes()
var c, t, val, mult: inteiro
    continua: logico
inicio
   para t de 1 ate 7 faca
      w[t] <- pol[t]
   fimpara
   gw <- grau

   para c de -100 ate 100 faca
      mult <- 0
      continua <- verdadeiro
      enquanto (continua) e (gw >= 1) faca
         // valor do polinomio em c (Horner) = resto da divisao por (x - c)
         val <- 0
         para t de gw + 1 ate 1 passo -1 faca
            val <- val * c + w[t]
         fimpara

         se val = 0 entao
            // Briot-Ruffini: divide w por (x - c)
            mult <- mult + 1
            quo[gw] <- w[gw + 1]
            para t de gw ate 2 passo -1 faca
               quo[t - 1] <- w[t] + c * quo[t]
            fimpara
            para t de 1 ate gw faca
               w[t] <- quo[t]
            fimpara
            gw <- gw - 1
         senao
            continua <- falso
         fimse
      fimenquanto

      se mult > 0 entao
         escreva("   Raiz x = ", c, "  (multiplicidade ", mult, ")")
         escreval("")
      fimse
   fimpara

   se gw > 0 entao
      escreval("   Resta fator de grau ", gw, " sem raiz inteira entre -100 e 100.")
   fimse
fimprocedimento

// Mostra o polinomio carregado em "pol" e suas raizes
procedimento Analisa(nome: caractere)
inicio
   escreva(nome, "(x) = ")
   MostraPol()
   Raizes()
   escreval("")
fimprocedimento

inicio
   // p(x) = x^2 + 3x - 10
   polin[1,1] <- -10
   polin[1,2] <- 3
   polin[1,3] <- 1
   graus[1] <- 2

   // q(x) = x^3 - 3x^2 - 6x + 8
   polin[2,1] <- 8
   polin[2,2] <- -6
   polin[2,3] <- -3
   polin[2,4] <- 1
   graus[2] <- 3

   // r(x) = 2x^3 - 10x^2 + 6x + 18
   polin[3,1] <- 18
   polin[3,2] <- 6
   polin[3,3] <- -10
   polin[3,4] <- 2
   graus[3] <- 3

   // s(x) = x^4 - 10x^2 + 9
   polin[4,1] <- 9
   polin[4,2] <- 0
   polin[4,3] <- -10
   polin[4,4] <- 0
   polin[4,5] <- 1
   graus[4] <- 4

   escreval("=== a) Raizes de cada polinomio ===")
   escreval("")
   CarregaPol(1)
   Analisa("p")
   CarregaPol(2)
   Analisa("q")
   CarregaPol(3)
   Analisa("r")
   CarregaPol(4)
   Analisa("s")

   escreval("=== b) f = p * q ===")
   escreval("")
   CarregaA(1)
   CarregaB(2)
   Multiplica()
   Analisa("f")

   escreval("=== c) g = p * r ===")
   escreval("")
   CarregaA(1)
   CarregaB(3)
   Multiplica()
   Analisa("g")

   escreval("=== d) h = p * s ===")
   escreval("")
   CarregaA(1)
   CarregaB(4)
   Multiplica()
   Analisa("h")

fimalgoritmo
