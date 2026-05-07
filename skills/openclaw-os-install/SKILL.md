---
name: openclaw-os:install
description: |
  Etapa 1 — Setup do OpenClaw na VPS. Guia o aluno em 11 passos: SSH na VPS,
  update do Ubuntu, dependencias (build-essential/curl/git), curl install.sh
  oficial, wizard (Gateway Local + OpenAI Codex + Codex 5.5 + daemon), validar
  gateway status, criar bot no @BotFather, conectar Telegram ao OpenClaw,
  configurar dmPolicy=allowlist, primeiro teste "Oi". Tempo: ~55min.
---

# Etapa 1 — Setup do OpenClaw na VPS

**Tempo:** 55 min
**Objetivo:** OpenClaw rodando na VPS + bot Telegram conectado + primeira mensagem trocada.

## IMPORTANTE

Voce **nao instala**. Voce **guia o aluno** a executar comandos no terminal
DELE. Aluno precisa de DOIS terminais:

- **Terminal 1:** Claude Code (este, te guiando)
- **Terminal 2:** terminal do computador, conectado SSH na VPS

## Pre-checks

- state.json mostra `etapas_completas` contem `0`
- Aluno tem: ChatGPT Plus + Telegram + VPS Hostinger Ubuntu 24.04 + IP + senha

## Os 11 passos

### Passo 1 — Conectar na VPS

```
========================================
  ETAPA 1 — SETUP DO OPENCLAW
========================================

Vamos instalar o OpenClaw na sua VPS. ~55min.

PASSO 1/11 — CONECTAR NA VPS

Abre um terminal NOVO no seu computador (Terminal 2) e cola:

    ssh root@SEU_IP

(troca SEU_IP pelo IP que voce salvou na Hostinger)

Digite a senha root quando pedir.

Quando o prompt mudar pra "root@..." (com hashtag), me diz "conectei".
```

### Passo 2 — Atualizar Ubuntu

```
PASSO 2/11 — ATUALIZAR SISTEMA

No Terminal 2, cola estes 3 comandos (UM POR VEZ, espera cada terminar):

    sudo apt update

    sudo apt upgrade -y

    sudo apt autoremove -y

Pode demorar 2-5 minutos. Quando voltar o prompt, me diz "atualizou".
```

### Passo 3 — Dependencias basicas

```
PASSO 3/11 — DEPENDENCIAS

No Terminal 2, cola:

    sudo apt install build-essential curl file git -y

Quando terminar, me diz "ok".
```

### Passo 4 — Instalar OpenClaw

```
PASSO 4/11 — INSTALAR OPENCLAW

No Terminal 2, cola:

    curl -fsSL https://openclaw.ai/install.sh | bash

Isso baixa o instalador oficial e roda. Demora ~2min.

Quando voltar o prompt, me diz "instalou".
```

### Passo 5 — Wizard de configuracao

```
PASSO 5/11 — WIZARD DE CONFIGURACAO

No Terminal 2, cola:

    openclaw onboard --install-daemon

Vai abrir um wizard com 5 perguntas. Vou te guiar uma por uma.
Quando aparecer a primeira pergunta, me diz "abriu wizard".
```

#### Wizard 1/5 — Gateway Mode

```
WIZARD 1/5 — GATEWAY MODE

Pergunta: "Gateway mode?"

ESCOLHA: Local

(Local = roda no proprio VPS. As outras opcoes sao avancadas.)

Seleciona "Local" e me diz "ok 1".
```

#### Wizard 2/5 — AI Provider

```
WIZARD 2/5 — AI PROVIDER

Pergunta: "Which AI provider?"

ESCOLHA: OpenAI Codex  (pode aparecer como "OpenAI Codecs" — mesma coisa)

(Vamos usar ChatGPT/OpenAI. Voce ja tem o Plus contratado.)

Seleciona e me diz "ok 2".
```

#### Wizard 3/5 — Login do Browser

```
WIZARD 3/5 — LOGIN VIA BROWSER

O OpenClaw vai abrir um link pra voce logar na conta OpenAI/ChatGPT.

PROCESSO:
  1. Copia o link que apareceu no terminal
  2. Cola no navegador do seu computador
  3. Faz login com a conta ChatGPT Plus que voce ja tem
  4. Autoriza o OpenClaw a acessar
  5. Volta no Terminal 2

Quando o wizard confirmar "Authorized" ou similar, me diz "logado".

(Voce nao precisa colar API key — o login do browser cuida disso.)
```

#### Wizard 4/5 — Modelo

```
WIZARD 4/5 — MODELO

Pergunta: "Which model?"

ESCOLHA: Codex 5.5  (recomendado, equilibrio qualidade/custo)

Seleciona e me diz "ok 4".
```

#### Wizard 5/5 — Instalar como servico

```
WIZARD 5/5 — INSTALAR COMO SERVICO

Pergunta: "Install as system service (systemd)?"

ESCOLHA: Sim (Y)

(Faz o OpenClaw rodar 24/7 mesmo apos reboot do VPS. E o que faz
seu agente ser SEMPRE-ON.)

Confirma "Y" e aguarde o wizard terminar. Vai aparecer "Installation
complete" ou prompt voltar.

Quando voltar, me diz "wizard ok".
```

### Passo 6 — Validar gateway status

```
PASSO 6/11 — VALIDAR STATUS

No Terminal 2, cola:

    openclaw gateway status

Deve aparecer "running" (verde). Cola aqui o output.
```

Se `running` → ✅ avanca. Se nao → cola logs:

```
Cola tambem o output deste:

    openclaw gateway logs
```

E diagnostica antes.

### Passo 7 — Criar bot no Telegram

```
PASSO 7/11 — CRIAR BOT NO TELEGRAM

Abre Telegram (celular ou desktop) e:

  1. Busca @BotFather (o bot oficial pra criar bots)
  2. Manda: /newbot
  3. BotFather pergunta o NOME. Coloca o nome que voce quer
     (ex: "Meu Alfred", "Sofia AI" — pode ter espaco e maiuscula)
  4. BotFather pergunta o USERNAME. Tem que terminar em "bot":
     ex: "alfred_bot", "sofia_ai_bot"
  5. BotFather te manda um TOKEN no formato:
     123456:ABC-defgh1234...

Copia o token e me diz "tenho o token".
```

### Passo 8 — Conectar Telegram ao OpenClaw

```
PASSO 8/11 — CONECTAR TELEGRAM

No Terminal 2 (SSH na VPS), cola:

    openclaw provider add telegram

O OpenClaw vai pedir o token do bot. Cola o token que o BotFather
te deu.

Quando o OpenClaw confirmar "Telegram provider added", me diz "conectou".
```

### Passo 9 — Disparar /start no bot

```
PASSO 9/11 — INICIAR CONVERSA

Abre o Telegram, procura pelo seu bot (pelo username, ex @alfred_bot),
abre o chat com ele e manda:

    /start

Isso:
  - Inicia a conversa (Telegram exige isso)
  - Registra seu chat_id no OpenClaw automaticamente
  - O bot DEVE responder algo (saudacao, hello, etc)

O bot respondeu? Me diz o que ele disse.
```

### Passo 10 — Configurar allowlist (CRITICO)

```
========================================
  PASSO 10/11 — SEGURANCA CRITICA
========================================

ATENCAO: ANTES de seguir, configura o allowlist. Sem isso, QUALQUER pessoa
que descobrir o username do seu bot pode mandar mensagem e gastar suas
credenciais.

No Terminal 2, cola:

    cat ~/.openclaw/openclaw.json

Procura no arquivo a chave "dmPolicy". Tem que estar:

    "dmPolicy": "allowlist"

E na lista de IDs autorizados, deve ter SO o seu chat_id (registrado no
Passo 9 quando voce mandou /start).

Se estiver "dmPolicy": "open", troca pra allowlist:

    nano ~/.openclaw/openclaw.json

Edita, salva (Ctrl+O, Enter, Ctrl+X), e reinicia:

    systemctl restart openclaw

Quando estiver com dmPolicy=allowlist e SO seu chat_id autorizado,
me diz "allowlist ok".
```

NAO avance sem isso.

### Passo 11 — Primeiro teste real

```
PASSO 11/11 — PRIMEIRO TESTE

Volta no Telegram, no chat com seu bot, e manda:

    Oi! Me diz quem voce e e o que pode fazer.

Ele deve responder em ate 5 segundos.

Cola aqui o que ele respondeu pra eu ver se ta tudo OK.
```

Validacao:
- Resposta coerente em portugues, mencionando ser AI/agente → ✅ go-live parcial
- Resposta vazia/erro → 🔴 troubleshooting
- Resposta em ingles → ✅ funciona, vai ser ajustado na Etapa 3 (Identidade)

### Step final — Atualizar state.json

```json
{
  "current_etapa": 2,
  "etapas_completas": [0, 1],
  "vps_ip": "{ip}",
  "openclaw": {
    "installed": true,
    "gateway_mode": "Local",
    "provider": "OpenAI Codex",
    "model": "Codex 5.5",
    "service": "systemd",
    "status": "running"
  },
  "telegram": {
    "bot_username": "{username}",
    "chat_id": "{chat_id}",
    "dm_policy": "allowlist",
    "first_test_ok": true
  }
}
```

### Fechar etapa

```
========================================
  ✓ ETAPA 1 CONCLUIDA
========================================

Seu OpenClaw esta no ar:

  ✓ VPS atualizada (Ubuntu 24.04)
  ✓ OpenClaw instalado (Gateway Local)
  ✓ Provider: OpenAI Codex
  ✓ Modelo: Codex 5.5
  ✓ Service: systemd (24/7)
  ✓ Bot Telegram criado e conectado
  ✓ Allowlist ativa (so VOCE pode falar)
  ✓ Primeira mensagem respondida

PROXIMA ETAPA: Etapa 2 — Seguranca (~25min)

Volta ao /openclaw-os:setup e diz "ok" pra liberar a Etapa 2
(ou roda direto: /openclaw-os:security)
```

## Prompt de validacao opcional pro Telegram

Se o aluno quiser, ele pode mandar este prompt no chat com o bot pra
fazer auto-validacao:

```
PROMPT · VALIDACAO DO SETUP

Acabei de fazer o setup do OpenClaw na VPS. Quero que voce me ajude a
validar que esta tudo funcionando e otimizado.

Executa e me reporta:
  1. openclaw gateway status — esta running?
  2. Provider e modelo configurados?
  3. tools.profile esta full?
  4. Tem failover configurado?
  5. Telegram conectado, dmPolicy=allowlist?
  6. Token optimization ativada?
  7. Timezone correto?
  8. Health check geral

Resposta no formato:
✅ Setup OK
ou
⚠️ Setup parcial — itens faltando: [lista]
```

## Veto conditions

- SSH falha 3 vezes → PARA. Confere IP e senha.
- `curl install.sh` falha → DNS? Sem internet no VPS? Diagnostica.
- Wizard nao abre → comando `openclaw` fora do PATH:
  `export PATH=$PATH:/usr/local/bin && openclaw onboard --install-daemon`
- Login OpenAI falha → confirma que conta tem ChatGPT Plus ativo
- `gateway status` retorna `failed` → NAO avanca, mostra logs
- Bot Telegram nao responde apos /start → diagnostica antes do allowlist
- dmPolicy ainda "open" → 🔴 BLOCK total, nao libera Etapa 2

## Origem

Curso Core IA Mentoria — M2 — Setup (11 passos).
Squad openclaw-creator/agents/infra-installer.md (1.750 linhas) +
Squad openclaw-manager/tasks/provision-new-claw.md (175 linhas).
