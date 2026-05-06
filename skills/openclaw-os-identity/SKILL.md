---
name: openclaw-os:identity
description: |
  Constroi os 5 arquivos de identidade do claw (USER, SOUL, AGENTS, IDENTITY,
  BOOT) na maquina LOCAL do aluno (Mac). Aluno cola 5 prompts no ChatGPT/IA
  que ja o conhece, opcionalmente aponta uma pasta com documentos da empresa,
  a skill compila tudo e gera 5 arquivos .md em ~/openclaw-identity/. No final,
  entrega um prompt pro aluno colar no Telegram com os arquivos anexados, e
  o claw substitui os arquivos no VPS automaticamente. Roda LOCAL, nao no VPS.
---

# OpenClaw OS — Identity Builder

**Tempo:** 30 min
**Onde roda:** computador local do aluno (Mac), NAO no VPS
**Objetivo:** Construir os 5 arquivos de identidade (`USER.md`, `SOUL.md`,
`AGENTS.md`, `IDENTITY.md`, `BOOT.md`) e enviar pro claw via Telegram.

## IMPORTANTE — leia antes de comecar

Esta skill roda **no Claude Code do computador do aluno** (Mac). O aluno
**nao precisa abrir SSH no VPS**. O fluxo e:

1. Voce (skill) pergunta se ele tem documentos sobre ele/empresa
2. Voce conduz ele a colar 5 prompts no ChatGPT (IA que ja conhece ele)
3. Voce le respostas + arquivos da pasta dele
4. Voce gera os 5 `.md` em `~/openclaw-identity/`
5. Voce entrega um prompt pro Telegram, ele anexa os arquivos no chat com
   o claw, e o claw substitui no VPS

Voce e instrutor + compilador. Nao instala nada. Nao toca VPS.

## Pre-checks

- Aluno completou Phase 4 (claw rodando no Telegram)
- Aluno esta no Claude Code no computador DELE (nao via SSH)

Se nao, oriente: "Roda /openclaw-os:start primeiro pra ter o claw no ar."

## Fluxo

### Step 1: Apresentar a etapa

Mostre exatamente isto:

```
========================================
  OPENCLAW OS — IDENTIDADE
========================================

Vamos construir os 5 arquivos que dao alma pro seu claw:

  USER.md     — quem VOCE e
  SOUL.md     — quem o CLAW e (personalidade)
  AGENTS.md   — regras operacionais (faz/pergunta/nunca)
  IDENTITY.md — nome, emoji, tom de voz
  BOOT.md     — checklist que ele roda ao iniciar sessao

Tudo acontece aqui na sua maquina. Voce vai:
  1. Colar 5 prompts em ChatGPT/Claude/Gemini (IA que ja te conhece)
  2. Colar as respostas de volta aqui
  3. (Opcional) me apontar uma pasta com documentos seus/da empresa
  4. Eu compilo tudo e gero os 5 arquivos em ~/openclaw-identity/
  5. Voce manda os arquivos pro claw no Telegram (cola um prompt
     que eu te dou). Ele substitui no VPS sozinho.

Pronto pra comecar?
```

Aguarde "ok".

### Step 2: Coletar contexto extra (pasta de documentos)

```
ANTES de comecar, uma pergunta importante:

Voce tem uma PASTA no seu computador com documentos sobre voce ou sua
empresa? Por exemplo:

  - Pitch deck
  - Manifesto / brand book
  - Documentos da equipe
  - Posts/textos seus
  - Plano de negocios
  - LinkedIn exportado
  - Transcricoes de podcasts/videos seus

Se SIM, me passa o caminho completo da pasta (ex: ~/Documents/minha-empresa).
Vou ler esses arquivos pra ter mais contexto na hora de gerar os 5 arquivos.

Se NAO tem, sem problema. Digita "nao tenho" e seguimos com os 5 prompts
no ChatGPT.
```

#### Se aluno informar pasta:

```bash
# Le todos os arquivos suportados (md, txt, pdf, docx) recursivamente
find {PASTA_DO_ALUNO} -type f \( -name "*.md" -o -name "*.txt" -o -name "*.pdf" -o -name "*.docx" \) | head -30
```

Lista os arquivos encontrados, mostra ao aluno e confirma:

```
Encontrei {N} arquivos relevantes:

  - pitch-deck.pdf
  - manifesto.md
  - posts-instagram.txt
  - ...

Vou ler todos eles agora pra extrair contexto. Isso vai me ajudar a gerar
os 5 arquivos com informacao real, nao generica.
```

Use o tool `Read` pra ler cada arquivo. Pra PDFs, use Read direto (Claude
Code suporta). Compile mentalmente:
- Tom de voz da empresa/aluno
- Valores, missao
- Equipe, clientes, projetos
- Vocabulario, frases-ancora
- Inspirational anchors

Guarde esse contexto pra usar nos prompts e na geracao final.

#### Se aluno disser "nao tenho":

```
Tudo bem. Vamos extrair seu perfil via ChatGPT/IA que ja te conhece.
Os 5 prompts a seguir vao puxar quase tudo automaticamente.
```

### Step 3: Os 5 prompts (um de cada vez)

Conduza o aluno **um prompt por vez**. Pra cada um:
1. Mostra o prompt num bloco de codigo (facil de copiar)
2. Pede pra colar no ChatGPT/Claude/Gemini que ele mais usa
3. Aguarda ele colar a resposta de volta aqui
4. Confirma + segue pro proximo

#### Prompt 1/5 — USER.md (quem e voce)

```
PROMPT 1/5 — USER.md

Cola este prompt no ChatGPT (ou Claude/Gemini que ja te conhece) e cola
a resposta INTEIRA de volta aqui:

────────────────────────────────────────────────────────────

Use TUDO que voce sabe sobre mim das nossas conversas e da sua memoria
pra gerar um perfil completo meu. Vai ser usado pra configurar um agente
AI pessoal (AI COO) que vai me ajudar no dia-a-dia.

Responda em formato MARKDOWN com pelo menos estas 7 secoes (cada uma
com 3+ paragrafos detalhados, com nomes/marcas/numeros reais quando
souber, "[NAO_SEI]" quando nao souber — nao invente):

## 1. Negocios e trabalho
Empresas, papeis, foco atual, faturamento aproximado, tamanho de time,
projetos ativos, objetivos curto/medio/longo prazo.

## 2. Rotina e horarios
Como e meu dia, horarios de foco profundo, quando NAO me perturbar,
agenda semanal tipica, rotina matinal, exercicio.

## 3. Estilo de comunicacao
Como eu escrevo (formal/informal, girias, vocabulario), tom de voz,
o que me irrita em respostas de IA, como prefiro receber informacao
(bullet/tabela/texto corrido).

## 4. Equipe e contexto
Quem trabalha comigo (nomes, papeis), parceiros importantes, familia
relevante, clientes-chave.

## 5. Vocabulario e expressoes proprias
Termos que uso, marcas proprias, frases-ancora, jargao do meu nicho.

## 6. Preferencias e aversoes
O que gosto, o que detesto, o que NUNCA quero ouvir como sugestao.

## 7. Inspirational anchors
Pessoas, empresas, marcas que me inspiram (referencia de tom, estetica,
posicionamento).

Meta: 400+ linhas. Quanto mais especifico, melhor.

────────────────────────────────────────────────────────────

Quando colar a resposta de volta aqui, eu salvo e vamos pro proximo.
```

Aguarde resposta. Salve em variavel mental (`USER_CONTENT`).

#### Prompt 2/5 — SOUL.md (quem e o agente)

```
PROMPT 2/5 — SOUL.md (personalidade do claw)

Cola este prompt no ChatGPT e cola a resposta aqui:

────────────────────────────────────────────────────────────

Quero criar a personalidade de um agente AI pessoal que vai me ajudar
no dia-a-dia. Ele tem que ter ALMA, nao ser um chatbot generico que
concorda com tudo.

Gera um arquivo SOUL.md em markdown com estas 6 secoes:

## 1. Personalidade forte
3 a 5 tracos-ancora (proativo? cetico? direto? caloroso?). Justifica
cada um com uma frase.

## 2. Opiniao propria
Em que situacoes ele DEVE discordar de mim com argumento? (ex: decisao
impulsiva, contradicao com plano anterior, gasto fora do orcamento).

## 3. Anti-patterns com exemplos
Pra cada coisa errada que ele NAO deve fazer, mostra o jeito certo:
formato ❌ ERRADO / ✅ CERTO. Minimo 5 pares.

## 4. Never-dos explicitos
5 a 10 coisas que ele NUNCA faz, em hipotese alguma. Ex:
- Nunca concorda so pra agradar
- Nunca da resposta generica sem perguntar contexto
- Nunca posta sem revisao
- Nunca ignora meu horario de "nao perturbe"

## 5. Frases-ancora
3 a 5 frases que ele sempre usa pra se manter no carater. Ex:
"Vou direto ao ponto." / "Aviso quando algo precisa de voce." /
"Nao vou concordar so pra agradar."

## 6. Inspirational anchors
3 a 5 personagens/pessoas reais que servem de referencia de jeito.
Pode ser ficcional (Alfred do Batman, Donna Paulsen do Suits, Jarvis
do Iron Man, Friday do Iron Man) ou real (Naval, Hormozi, etc).

Considera o perfil que ja extraimos do USER.md (cole abaixo se eu nao
tiver mandado ainda — ou usa o que voce ja sabe sobre mim).

Quero personalidade forte, opinião e atitude. NAO quero "assistente
prestativo".

────────────────────────────────────────────────────────────

Cola a resposta aqui quando tiver.
```

Salva como `SOUL_CONTENT`.

#### Prompt 3/5 — AGENTS.md (regras operacionais)

```
PROMPT 3/5 — AGENTS.md (regras do que ele faz/pergunta/nunca)

Cola este prompt e me passa a resposta:

────────────────────────────────────────────────────────────

Cria um arquivo AGENTS.md em markdown com 3 listas claras de regras
operacionais pra um agente AI pessoal que vai me ajudar no dia-a-dia.

## ✅ Operacoes que faz SOZINHO (reversiveis, sem custo)
Lista 8 a 12 acoes. Ex:
- Ler arquivos da minha memoria
- Atualizar a memoria diaria
- Buscar informacao na web
- Responder perguntas no Telegram
- Criar rascunho de email/post (sem enviar)
- Compactar notas antigas
- Rodar comandos de leitura no terminal

## ⚠️ Operacoes que PERGUNTA antes (irreversiveis ou que custam)
Lista 8 a 12. Ex:
- Mandar email externo
- Postar em rede social
- Fazer compra ou pagamento
- Deletar arquivo importante
- Git push em repo de cliente
- Agendar reuniao
- Mudar configuracao critica
- Compartilhar arquivo com terceiros

## ❌ Operacoes VETADAS (nunca, em hipotese alguma)
Lista 5 a 8. Ex:
- Mudar credenciais sem confirmar
- Desativar camadas de seguranca
- Commitar segredos
- Ignorar erro silenciosamente
- Tomar decisao financeira acima de R$ X sem confirmar

Considera o perfil do usuario (USER.md) e a personalidade do agente
(SOUL.md).

────────────────────────────────────────────────────────────

Cola a resposta aqui.
```

Salva como `AGENTS_CONTENT`.

#### Prompt 4/5 — IDENTITY.md (nome, emoji, tom)

```
PROMPT 4/5 — IDENTITY.md (rosto do claw)

Cola este prompt e me passa a resposta:

────────────────────────────────────────────────────────────

Cria um arquivo IDENTITY.md em markdown que da rosto pro agente AI.

Considere a personalidade definida (SOUL.md) e o perfil do usuario
(USER.md). O agente vira pessoa, nao robo.

## Nome
Sugere 5 nomes curtos e faceis de chamar que combinam com a
personalidade. NAO usa "Assistant", "Bot", "AI". Pode ser:
- Referencia cultural (Alfred, Donna, Friday, Jarvis, Pepper)
- Nome neutro (Nova, Echo, Atlas, Iris)
- Nome em portugues (Amora, Nina, Caio, Lupe)

Pra cada um, justifica em 1 frase por que combina.

## Emoji-assinatura
Sugere 3 emojis que combinam com o nome e a personalidade. Vai aparecer
em toda mensagem do agente. Ex: 🍇 (Amora), 🦅 (Echo), 🛡️ (Alfred).

## E-mail dedicado
Sugere padrao de username pra criar um Gmail proprio do agente. Ex:
- nome-do-agente@gmail.com
- nome-do-aluno-claw@gmail.com
Da 3 opcoes diferentes.

## Tom de voz (5 frases-ancora)
5 frases que o agente vai usar sempre pra manter consistencia. Ex:
"Vou direto ao ponto."
"Aviso quando algo precisa de voce."
"Posso discordar, mas sempre com argumento."

────────────────────────────────────────────────────────────

Cola a resposta aqui.
```

Salva como `IDENTITY_CONTENT`.

#### Prompt 5/5 — BOOT.md (checklist de startup)

```
PROMPT 5/5 — BOOT.md (checklist de inicio de sessao)

Cola este prompt e cola a resposta:

────────────────────────────────────────────────────────────

Cria um arquivo BOOT.md em markdown que e o protocolo que o agente roda
toda vez que abre uma nova sessao (igual o "chegar no escritorio" de uma
pessoa).

O BOOT.md deve ter, em ordem:

## Sequencia de boot
1. Le USER.md (quem e o usuario)
2. Le SOUL.md (quem sou eu)
3. Le AGENTS.md (regras operacionais)
4. Le IDENTITY.md (meu nome, emoji, tom)
5. Le memory/MEMORY.md (indice geral, se existir)
6. Le memory/sessions/HOJE.md e ONTEM.md (se existirem)
7. Checa memory/pending.md (algo aguardando decisao do usuario)
8. Cumprimenta o usuario pelo nome com o emoji-assinatura
9. Pergunta se tem prioridade do dia

## Comportamento ao iniciar
- Mensagem de bom dia/tarde/noite calibrada pelo horario
- Resumo de 1-2 linhas do que mudou desde a ultima sessao
- Se houver pending, levanta antes de qualquer outra coisa
- NUNCA comeca falando de si mesmo. Sempre comeca cumprimentando.

## Regras de boot
- Se algum arquivo de identidade estiver faltando, avisa o usuario
- Se memory/ ainda nao existe, sugere rodar Etapa 4 (Memoria)
- Se for primeira sessao apos setup, faz tour rapido das capacidades

────────────────────────────────────────────────────────────

Cola a resposta aqui.
```

Salva como `BOOT_CONTENT`.

### Step 4: Compilar e enriquecer com a pasta (se houver)

Se aluno informou pasta na Step 2, **enriqueca** os 5 conteudos com
informacoes especificas dos arquivos que voce leu:

- USER.md → adiciona dados reais (nomes da equipe, faturamento, projetos
  citados nos docs)
- SOUL.md → ajusta tom de voz com base nos textos do aluno (se ele tem
  posts/podcasts, calibra o tom do claw pra refletir)
- AGENTS.md → ajusta limites com base no contexto do negocio (ex: se
  e medico, adiciona "nunca da diagnostico clinico")
- IDENTITY.md → sugere nomes que dialogam com a marca/empresa do aluno
- BOOT.md → adiciona contexto especifico do negocio

### Step 5: Gerar os 5 arquivos

```bash
mkdir -p ~/openclaw-identity
```

Crie cada arquivo:

```bash
# Os 5 arquivos
~/openclaw-identity/USER.md       # com USER_CONTENT enriquecido
~/openclaw-identity/SOUL.md       # com SOUL_CONTENT enriquecido
~/openclaw-identity/AGENTS.md     # com AGENTS_CONTENT enriquecido
~/openclaw-identity/IDENTITY.md   # com IDENTITY_CONTENT enriquecido
~/openclaw-identity/BOOT.md       # com BOOT_CONTENT enriquecido
```

Mostre ao aluno:

```
========================================
  ✓ 5 ARQUIVOS GERADOS
========================================

Pasta: ~/openclaw-identity/

  USER.md       (X linhas — perfil completo)
  SOUL.md       (X linhas — personalidade)
  AGENTS.md     (X linhas — 3 listas)
  IDENTITY.md   (X linhas — nome, emoji, tom)
  BOOT.md       (X linhas — checklist startup)

Quer dar uma olhada em algum antes de mandar pro claw?
(digita o nome do arquivo, ou "envia" pra ir direto pro Telegram)
```

Se aluno pedir pra revisar, mostra o conteudo completo do arquivo escolhido.

### Step 6: Prompt final pro Telegram

```
========================================
  PASSO FINAL — ENVIAR PRO CLAW
========================================

Agora abre o Telegram, vai no chat com seu claw, e:

1. ANEXA OS 5 ARQUIVOS (clica no clipe → seleciona todos):
   ~/openclaw-identity/USER.md
   ~/openclaw-identity/SOUL.md
   ~/openclaw-identity/AGENTS.md
   ~/openclaw-identity/IDENTITY.md
   ~/openclaw-identity/BOOT.md

2. COLA ESTE PROMPT JUNTO COM OS ANEXOS:

────────────────────────────────────────────────────────────

Estou te enviando os 5 arquivos da minha identidade (USER.md, SOUL.md,
AGENTS.md, IDENTITY.md, BOOT.md). Substitui os atuais que voce tem em
~/openclaw/identity/ por estes que estou anexando.

Faz o seguinte, na ordem:

1. Le cada um dos 5 arquivos completo
2. Faz backup dos atuais em ~/openclaw/identity/backup-{timestamp}/
3. Substitui pelos novos em ~/openclaw/identity/
4. Roda: systemctl restart openclaw
5. Aguarda 10 segundos
6. Faz auditoria final dos 5 arquivos:
   - USER.md tem 400+ linhas e 7 secoes?
   - SOUL.md tem personalidade forte (anti-patterns ❌/✅, never-dos)?
   - AGENTS.md tem as 3 listas (faz/pergunta/nunca)?
   - IDENTITY.md tem nome, emoji, e-mail, tom?
   - BOOT.md tem checklist completo de 9 passos?
7. Me responde no formato:

🎭 Auditoria de identidade

USER.md     · ✅ OK (X linhas, 7 secoes)
SOUL.md     · ✅ OK (Y anti-patterns, Z never-dos)
AGENTS.md   · ✅ OK (3 listas: A faz / B pergunta / C nunca)
IDENTITY.md · ✅ OK (nome: X, emoji: Y)
BOOT.md     · ✅ OK (checklist 9 passos)

Score: 10/10 · identidade carregada e ativa.
Pode seguir pra Etapa 4 (Memoria).

Se algo nao passar, me lista o que falta antes de seguir.

Apos a auditoria, faz uma pergunta polemica pra mim baseada no que voce
acabou de aprender sobre minha personalidade. Quero validar que o SOUL
pegou — voce deveria conseguir discordar de mim com argumento, nao
concordar no automatico.

────────────────────────────────────────────────────────────

Quando o claw responder com a auditoria, volta aqui e me diz "OK" pra
fechar a etapa. Se algo nao passar, me cola o que ele disse pra eu
te ajudar a corrigir.
```

### Step 7: Fechar (apos confirmacao do aluno)

Quando aluno voltar com "OK":

```
========================================
  ✓ ETAPA 3 — IDENTIDADE CONCLUIDA
========================================

Seu claw agora tem alma:

  ✓ Conhece voce profundamente (USER.md)
  ✓ Tem personalidade propria (SOUL.md)
  ✓ Sabe o que pode/nao pode fazer (AGENTS.md)
  ✓ Tem nome, emoji e tom de voz (IDENTITY.md)
  ✓ Roda checklist ao iniciar sessao (BOOT.md)

Os arquivos ficam salvos em ~/openclaw-identity/ se voce quiser
ajustar depois (basta reenviar pro claw via Telegram).

Proxima etapa: /openclaw-os:memory  (sistema de memoria)
```

## Veto conditions

- Aluno pula um dos 5 prompts → PARA. Cada um e necessario.
- Conteudo de algum prompt veio vazio/curto (<200 chars) → repete o prompt
  com instrucao mais firme.
- Pasta de documentos informada nao existe → ignora, segue sem.
- Aluno tenta rodar essa skill no VPS (via SSH) → AVISA: "Esta skill foi
  feita pra rodar no SEU computador, nao no VPS. A pasta ~/openclaw-identity/
  e local. Sai do SSH e roda no Mac."

## Origem

Aula 03 do curso OpenClaw OS. Esta skill substitui a entrevista manual
de 1h por um fluxo guiado de ~30min usando o ChatGPT/IA que ja conhece
o aluno + arquivos da pasta dele.

Funciona como complemento das phases 1-7. A Phase 1 (Memory Extraction)
ja gera USER.md basico. Esta skill entrega os 5 arquivos completos,
enriquecidos com contexto da pasta do aluno se houver.
