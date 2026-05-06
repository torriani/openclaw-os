---
name: openclaw-os:phase-2
description: |
  Phase 2 — Credentials Collection. Coleta e valida 3 credenciais essenciais:
  IP/senha do VPS Hostinger, ChatGPT API key, Telegram bot token + chat_id.
  Salva em ~/.openclaw/{claw-slug}/.env. Atualiza state.json. Pre-req: phase 1 OK.
---

# Phase 2 — Credentials Collection

**Tempo:** 10 min
**Objetivo:** Coletar 3 credenciais e salvar de forma segura.

## Pre-checks

1. Le state.json. Verifica `phases_completed` contem `1`.
2. Se nao, oriente: "Phase 1 (memory extraction) nao foi feita. Rode /openclaw-os:phase-1 antes."

## Fluxo

### Step 1: Apresentar

```
========================================
  PHASE 2 — CREDENTIALS COLLECTION
========================================

Vou coletar 3 credenciais essenciais pra seu claw funcionar:

  1. VPS Hostinger (IP + senha root)
  2. ChatGPT API key
  3. Telegram bot token + chat_id

Tudo fica salvo localmente em ~/.openclaw/{claw-slug}/.env (nao vai pra Git).

Pronto?
```

### Step 2: Coletar VPS

```
[1/3] VPS HOSTINGER

Va em hpanel.hostinger.com → VPS → seu servidor → SSH access.

Cole aqui:
  - IP do VPS:
  - Senha root:
```

Aguarde resposta. Valide IP (regex `\d+\.\d+\.\d+\.\d+`). Teste conexao:

```bash
ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 root@{IP} "echo OK"
```

Se falhar, oriente: "SSH nao conecta. Confirma IP e senha. Tenta de novo."

### Step 3: Coletar ChatGPT API

```
[2/3] CHATGPT API KEY

Va em platform.openai.com/api-keys → Create new secret key.
Da o nome "openclaw-{claw-name}" e copia a chave (comeca com sk-...).

Cole aqui:
```

Valide formato (`sk-...`). Teste:

```bash
curl -s https://api.openai.com/v1/models \
  -H "Authorization: Bearer {API_KEY}" | head -c 200
```

Se 401, oriente: "Chave invalida. Confirma copia."

### Step 4: Coletar Telegram

```
[3/3] TELEGRAM BOT

Abra Telegram, fale com @BotFather:
  1. /newbot
  2. Nome do bot: {claw-name} Bot
  3. Username: {claw-slug}_bot (precisa terminar em _bot)
  4. BotFather te da um TOKEN. Copia.

Cole o token aqui:
```

Valide formato (`\d+:[A-Za-z0-9_-]+`). Pegue chat_id:

```
Agora abre conversa com seu bot no Telegram, manda "oi", e roda este comando
no seu computador (substitui o TOKEN):

curl -s "https://api.telegram.org/bot{TOKEN}/getUpdates" | grep -o '"id":[0-9]*' | head -1

Cola aqui o numero que aparece (esse e seu chat_id):
```

### Step 5: Salvar .env

```bash
mkdir -p ~/.openclaw/{claw-slug}
cat > ~/.openclaw/{claw-slug}/.env << EOF
# OpenClaw OS — credenciais {claw-name}
# Gerado em $(date -u +%Y-%m-%dT%H:%M:%SZ)

VPS_IP={ip}
VPS_USER=root
VPS_PASSWORD={senha}

OPENAI_API_KEY={chatgpt_api_key}

TELEGRAM_BOT_TOKEN={telegram_token}
TELEGRAM_CHAT_ID={chat_id}
EOF
chmod 600 ~/.openclaw/{claw-slug}/.env
```

### Step 6: Atualizar state.json

```json
{
  "current_phase": 3,
  "phases_completed": [1, 2],
  "vps": {"ip": "{ip}", "ssh_user": "root"},
  "credentials": {
    "chatgpt_api_key": "...{ultimos 4 chars}",
    "telegram_bot_token": "...{ultimos 6 chars}",
    "telegram_chat_id": "{chat_id}"
  }
}
```

NAO escreva valores completos no state.json (so os ultimos chars). Valores reais ficam so no `.env`.

### Step 7: Fechar

```
Phase 2 concluida ✓

  ✓ VPS testado (SSH conecta)
  ✓ ChatGPT API validada
  ✓ Telegram bot ativo

Volte ao /openclaw-os:start e diga "ok" pra Phase 3.
```

## Veto conditions

- SSH nao conecta → PARA, nao avanca
- ChatGPT 401 → PARA, nao avanca
- Telegram chat_id vazio → PARA, peca pro aluno mandar "oi" pro bot primeiro

## Origem

`legacy/squads/openclaw-manager/tasks/credential-collection.md`
