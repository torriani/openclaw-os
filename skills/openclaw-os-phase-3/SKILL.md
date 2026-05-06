---
name: openclaw-os:phase-3
description: |
  Phase 3 — Instalar OpenClaw no VPS. Guia o aluno por: SSH no VPS, executar
  installer oficial (curl https://openclaw.ai/install.sh), rodar wizard
  (openclaw onboard --install-daemon), responder 5 perguntas, validar status
  rodando. OpenClaw e servico externo (docs.openclaw.ai). Pre-req: phase 2 OK.
---

# Phase 3 — Instalar OpenClaw no VPS

**Tempo:** 20 min
**Objetivo:** OpenClaw oficial instalado e rodando como servico no VPS.

## IMPORTANTE — leia antes de executar

Voce **nao instala OpenClaw**. Voce **guia o aluno** a executar os comandos
oficiais do OpenClaw (servico externo: <https://docs.openclaw.ai/pt-BR/install>).

Sua funcao aqui e: ler o `.env` da Phase 2, dizer pro aluno **abrir um terminal
separado**, conectar SSH no VPS dele, e rodar **na tela dele** os comandos que
voce vai mostrar **um por um** com explicacao + bloco de codigo pra copiar.

Nao execute SSH voce mesmo. Nao tente instalar OpenClaw via Bash dessa skill.
Voce e o instrutor, ele e quem digita.

## Pre-checks

- state.json: `phases_completed` contem [1, 2]
- `~/.openclaw/{claw-slug}/.env` existe com `VPS_IP` e senha do VPS

Se faltar, oriente: "Roda Phase 2 antes (`/openclaw-os:phase-2`)."

## Fluxo

### Step 1: Apresentar a fase

Mostre exatamente isto:

```
========================================
  PHASE 3 — INSTALAR OPENCLAW NO VPS
========================================

OpenClaw e um servico externo (https://openclaw.ai). Vamos seguir o
guia oficial passo a passo.

Voce vai precisar de DOIS terminais abertos:
  - Terminal 1: este aqui (Claude Code, te guiando)
  - Terminal 2: terminal do seu computador, conectado SSH no VPS

Vou te dar os comandos um por um. Cada comando voce roda no Terminal 2
(SSH no VPS) e me confirma o resultado.

Pronto?
```

Aguarde "ok" do aluno.

### Step 2: Conectar SSH

Le o `VPS_IP` do `.env`. Mostre:

```
PASSO 1 de 8 — CONECTAR NO VPS

Abra um terminal NOVO no seu computador (Terminal 2) e cole isto:

    ssh root@{VPS_IP_LIDO_DO_ENV}

Quando pedir senha, cola a senha root da Hostinger.

Quando voce vir o prompt mudar pra `root@...# ` (com hashtag), me diz "conectei".
```

Aguarde "conectei".

### Step 3: Instalar OpenClaw (1 comando)

```
PASSO 2 de 8 — INSTALAR OPENCLAW

No Terminal 2 (SSH no VPS), cola este comando:

    curl -fsSL https://openclaw.ai/install.sh | bash

Isso baixa o instalador oficial do OpenClaw e roda. Demora ~2 min.

Quando terminar (volta o prompt `root@...# `), me diz "instalou".
```

Aguarde "instalou". Se der erro, oriente: "Cola o erro aqui pra eu ver."

### Step 4: Rodar wizard de configuracao

```
PASSO 3 de 8 — WIZARD DE CONFIGURACAO

Agora cola este comando:

    openclaw onboard --install-daemon

Vai abrir um wizard interativo com 5 perguntas. Vou te guiar pergunta por
pergunta. Quando aparecer a primeira pergunta, me diz "abriu wizard".
```

Aguarde "abriu wizard".

### Step 5: Wizard — responder 5 perguntas (uma por vez)

Conduza o aluno **pergunta a pergunta**, esperando confirmacao entre cada uma:

#### Pergunta 1/5 — Gateway Mode

```
WIZARD 1/5 — GATEWAY MODE

O wizard pergunta: "Gateway mode?"

ESCOLHA: Local

(Local roda no proprio VPS. As outras opcoes sao pra setups avancados.)

Selecione "Local" e me diz "ok 1".
```

#### Pergunta 2/5 — AI Provider

```
WIZARD 2/5 — AI PROVIDER

O wizard pergunta: "Which AI provider?"

ESCOLHA: OpenAI Codex  (ou "OpenAI Codecs" — mesma opcao, nome varia por versao)

(Vamos usar ChatGPT/OpenAI. Voce ja tem a API key da Phase 2.)

Selecione e me diz "ok 2".
```

#### Pergunta 3/5 — API Key

Le `OPENAI_API_KEY` do `.env` do aluno (`~/.openclaw/{claw-slug}/.env`).

```
WIZARD 3/5 — API KEY

O wizard pergunta: "Paste your API key:"

Cola a chave que voce salvou na Phase 2. Pra pegar ela rapidinho, abre
um terceiro terminal (no seu computador, NAO no VPS) e roda:

    cat ~/.openclaw/{claw-slug}/.env | grep OPENAI_API_KEY

Copia o valor depois do `=`, volta no Terminal 2 (SSH no VPS), e cola
no wizard.

Quando colar, me diz "ok 3".
```

> Se o wizard rejeitar com "401 Unauthorized", a chave esta errada ou sem
> credito. Manda o aluno ir em platform.openai.com/api-keys, gerar nova,
> atualizar o `.env`, e re-rodar o wizard.

#### Pergunta 4/5 — Model

```
WIZARD 4/5 — MODEL

O wizard pergunta: "Which model?"

ESCOLHA: Codex 5.5  (recomendado pra OpenAI Codex provider)

(Codex 5.5 equilibra qualidade e custo. Em Phase 6 a gente configura
model split pra usar modelos mais potentes so quando precisar.)

Selecione e me diz "ok 4".
```

#### Pergunta 5/5 — Instalar como servico

```
WIZARD 5/5 — INSTALAR COMO SERVICO

O wizard pergunta: "Install as system service (systemd)?"

ESCOLHA: Sim (Y)

(Isso faz o OpenClaw rodar 24/7 automaticamente, mesmo apos reboot do VPS.
E o que faz o claw ser SEMPRE-ON.)

Confirma "Y" e aguarde o wizard terminar. Vai aparecer "Installation
complete" ou similar, e o prompt volta pra `root@...# `.

Quando voltar, me diz "wizard ok".
```

Aguarde "wizard ok".

### Step 6: Verificar se esta rodando

```
PASSO 4 de 8 — VERIFICAR STATUS

Cola no Terminal 2:

    openclaw gateway status

Deve aparecer "running" (verde). Cola aqui o output que apareceu.
```

Aguarde output. Validacao:
- Output contem `running` ou `active` → ✅ avanca pro Step 7
- Output contem `stopped`, `failed`, `error` → 🔴 PARA, oriente troubleshooting:
  - Roda `journalctl -u openclaw -n 50` no VPS pra ler logs
  - Aluno cola logs aqui, voce diagnostica
  - Tipico: API key invalida, sem internet no VPS, porta ocupada

### Step 7: Atualizar state.json

Quando confirmado `running`, atualiza `~/.openclaw/{claw-slug}/state.json`:

```json
{
  "current_phase": 4,
  "phases_completed": [1, 2, 3],
  "openclaw": {
    "installed": true,
    "gateway_mode": "Local",
    "provider": "OpenAI Codex",
    "model": "Codex 5.5",
    "service": "systemd",
    "status": "running"
  }
}
```

### Step 8: Fechar fase

```
========================================
  PHASE 3 CONCLUIDA ✓
========================================

OpenClaw instalado e rodando no seu VPS:

  ✓ Installer oficial executado (curl install.sh)
  ✓ Wizard configurado:
      - Gateway: Local
      - Provider: OpenAI Codex
      - Model:    Codex 5.5
      - Service:  systemd (24/7)
  ✓ Gateway status: running

PROXIMA FASE: Phase 4 — Conectar Telegram + Identidade

Volte ao /openclaw-os:start e me diz "ok" pra avancar.
```

## Veto conditions

- SSH falha 3 vezes → PARA. Volta pra Phase 2 e revalida senha do VPS.
- `curl install.sh` falha → cola erro, diagnostica (DNS? sem internet?).
- Wizard nao abre → comando `openclaw` nao ficou no PATH. Oriente:
  `export PATH=$PATH:/usr/local/bin && openclaw onboard --install-daemon`
- Wizard responde "401 Unauthorized" na API key → chave invalida.
- `openclaw gateway status` retorna `failed` → NAO marca phases_completed.

## Origem

Este passo a passo segue a documentacao oficial do OpenClaw:
<https://docs.openclaw.ai/pt-BR/install>

OpenClaw e um servico externo de terceiros. Esta skill apenas guia o aluno a
seguir o procedimento oficial. Nao instalamos nem mantemos OpenClaw.
