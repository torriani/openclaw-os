---
name: openclaw-os:phase-2
description: |
  Phase 2 — Coletar Credenciais. Coleta IP/senha do VPS Hostinger e a OpenAI
  API key. Salva em ~/.openclaw/{claw-slug}/.env. Telegram fica pra Phase 4
  (depois de OpenClaw instalado). Pre-req: phase 1 OK.
---

# Phase 2 — Credentials (VPS + OpenAI API)

**Tempo:** 10 min
**Objetivo:** Coletar 2 credenciais e salvar de forma segura.

## Pre-checks

- state.json: `phases_completed` contem `1`
- Se nao, oriente: "Roda /openclaw-os:phase-1 primeiro."

## Fluxo

### Step 1: Apresentar

```
========================================
  PHASE 2 — COLETAR CREDENCIAIS
========================================

Vou coletar 2 credenciais essenciais:

  1. VPS Hostinger (IP + senha root)
  2. OpenAI API key

Salvo localmente em ~/.openclaw/{claw-slug}/.env (chmod 600, nao vai pra Git).

Telegram a gente cria depois (Phase 4), apos instalar o OpenClaw.

Pronto?
```

### Step 2: Coletar VPS

```
[1/2] VPS HOSTINGER

Va em hpanel.hostinger.com → VPS → seu servidor → SSH access.

Cole aqui:
  - IP do VPS:
  - Senha root:
```

Aguarde resposta. Valide IP (regex `\d+\.\d+\.\d+\.\d+`). Teste conexao **rapida** (so pra ver se autentica):

```bash
ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 -o BatchMode=no \
  root@{IP} "echo OK" 2>&1
```

> Nota: SSH pode pedir senha interativamente. Se voce esta executando isso
> via Bash da skill, talvez nao consiga responder ao prompt. Nesse caso,
> assuma que se IP eh valido, o aluno passa adiante e a validacao real
> acontece na Phase 3 (quando ele de fato roda `ssh root@{IP}` no terminal
> dele).

Se IP invalido, oriente: "Confirma o IP no painel Hostinger."

### Step 3: Coletar OpenAI API key

```
[2/2] OPENAI API KEY

Vai em platform.openai.com/api-keys → Create new secret key.

Da o nome "openclaw-{claw-name}" e copia a chave (comeca com sk-...).

ATENCAO: a chave so aparece UMA VEZ. Salva em local seguro tambem.

⚠️  BILLING:
A OpenAI so emite chaves se voce tiver billing configurado (cartao
cadastrado em platform.openai.com/account/billing). Sem credito, a chave
nao funciona.

Cola a chave aqui:
```

Valide formato (`sk-...`, comprimento >= 40 chars).

> Nota sobre teste de API: pra evitar gastar tokens do aluno antes da hora,
> nao testamos a chave aqui. Ela vai ser validada na Phase 3 quando o
> wizard do OpenClaw aceitar/recusar.

### Step 4: Salvar .env

```bash
mkdir -p ~/.openclaw/{claw-slug}
cat > ~/.openclaw/{claw-slug}/.env << EOF
# OpenClaw OS — credenciais {claw-name}
# Gerado em $(date -u +%Y-%m-%dT%H:%M:%SZ)

VPS_IP={ip}
VPS_USER=root
VPS_PASSWORD={senha}

OPENAI_API_KEY={openai_api_key}

# Telegram (preenchido na Phase 4)
TELEGRAM_BOT_USERNAME=
TELEGRAM_CHAT_ID=
EOF
chmod 600 ~/.openclaw/{claw-slug}/.env
```

### Step 5: Atualizar state.json

```json
{
  "current_phase": 3,
  "phases_completed": [1, 2],
  "vps": {"ip": "{ip}", "ssh_user": "root"},
  "credentials": {
    "openai_api_key": "...{ultimos 4 chars}",
    "telegram": "(pendente Phase 4)"
  }
}
```

NAO escreva valores completos no state.json. Apenas ultimos chars pra audit.
Valores reais ficam so no `.env`.

### Step 6: Fechar

```
Phase 2 concluida ✓

  ✓ VPS Hostinger (IP salvo)
  ✓ OpenAI API key salva

Proxima fase: Phase 3 — Instalar OpenClaw no VPS

Volte ao /openclaw-os:start e diz "ok" pra Phase 3.
```

## Veto conditions

- IP invalido → PARA
- Chave OpenAI nao comeca com `sk-` ou tem <40 chars → PARA
- Aluno nao tem billing configurado na OpenAI → avisa que chave nao funcionara

## Origem

Telegram migrou pra Phase 4 (apos OpenClaw instalado). VPS + OpenAI API key
sao os 2 unicos pre-requisitos pra Phase 3 conseguir rodar o wizard do OpenClaw.
