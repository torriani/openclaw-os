---
name: openclaw-os:troubleshoot
description: |
  Etapa 10 — Resolvendo problemas. Skill ad-hoc (rode quando algo der errado).
  Diagnostico de 10 problemas comuns: agente nao responde, gateway down,
  Telegram silencioso, memoria nao persiste, cron nao roda, gastos altos,
  API key invalida, dmPolicy errado, watchdog flapping, restore.
---

# Etapa 10 — Resolvendo Problemas

**Tempo:** ad-hoc (so quando algo da errado)
**Objetivo:** Diagnosticar e resolver problemas comuns sem precisar
recomecar do zero.

## Apresentacao

```
========================================
  ETAPA 10 — RESOLVENDO PROBLEMAS
========================================

Algo deu errado? Vamos diagnosticar.

Me diz QUAL o sintoma:

  1. Agente nao responde no Telegram
  2. openclaw gateway status retorna failed
  3. Telegram bot silencioso (nem error)
  4. Memoria nao persiste entre sessoes
  5. Cron nao esta rodando
  6. Gastos OpenAI altos
  7. API key invalida (401)
  8. dmPolicy errado (estranhos falando com bot)
  9. Watchdog reiniciando agente toda hora
  10. Quero fazer restore (perdi a VPS)

Digita o numero ou descreve o problema com suas palavras.
```

## Diagnosticos

### 1. Agente nao responde no Telegram

```
DIAGNOSTICO 1/10:

Roda no Terminal 2 (SSH):

    openclaw gateway status
    systemctl is-active openclaw
    journalctl -u openclaw -n 30

Se status=failed → reinicia:
    systemctl restart openclaw

Se ainda falha → problema na config:
    openclaw doctor

Cola aqui o output do `openclaw doctor` que eu te ajudo a interpretar.
```

### 2. Gateway down

```
DIAGNOSTICO 2/10:

    systemctl restart openclaw
    sleep 10
    openclaw gateway status

Ainda failed? Provavel:
  - API key OpenAI invalida → vai pra diagnostico 7
  - Internet caiu na VPS → ping google.com
  - Disco cheio → df -h
  - Memoria cheia → free -m

Cola aqui o que apareceu.
```

### 3. Telegram silencioso

```
DIAGNOSTICO 3/10:

    curl "https://api.telegram.org/bot{SEU_TOKEN}/getMe"

Deve retornar JSON com `"ok":true`.

Se retornar erro → token invalido. Refaz Etapa 1 Passo 7-8.

Se OK → o gateway esta com algum problema:
    journalctl -u openclaw -n 50 | grep -i telegram

Cola o output.
```

### 4. Memoria nao persiste

```
DIAGNOSTICO 4/10:

    ls -la /agent/memory/
    cat /agent/memory/MEMORY.md
    cat /agent/identity/BOOT.md | grep -A 10 -i "memory"

Verifica:
  - memory/ existe e tem content?
  - BOOT.md le memory/MEMORY.md no startup?
  - Permissoes OK (chown root:root)?

Cola aqui o output.
```

### 5. Cron nao esta rodando

```
DIAGNOSTICO 5/10:

    crontab -l
    ls /agent/.openclaw/crons/  (ou onde os crons salvam)
    journalctl -u openclaw -n 50 | grep -i cron

Verifica:
  - Cron esta listado?
  - Schedule (0 */4 * * *) esta correto?
  - Algum erro nos logs?

Cola aqui.
```

### 6. Gastos OpenAI altos

```
DIAGNOSTICO 6/10:

Cola este PROMPT no Telegram:

────────────────────────────────────────
Audit de custos:
  1. Quantas chamadas API voce fez nos ultimos 7 dias?
  2. Qual a distribuicao por modelo (Haiku/Sonnet/Opus)?
  3. Tem cron rodando com Opus quando deveria ser Haiku?
  4. Tem loop infinito em algum heartbeat?

Me responde com numeros e me sugere onde cortar.
────────────────────────────────────────

Provavel solucao: forcar split de modelos (ver Etapa 5 Passo 8).
```

### 7. API key invalida (401)

```
DIAGNOSTICO 7/10:

Solucao:
  1. Vai em platform.openai.com/api-keys
  2. Confirma que tem credito (Settings → Billing)
  3. Gera nova key
  4. No Terminal 2:
       nano /etc/openclaw/.env
       (atualiza OPENAI_API_KEY)
       systemctl restart openclaw
       openclaw gateway status

Funcionou?
```

### 8. dmPolicy errado

```
DIAGNOSTICO 8/10:

URGENTE — qualquer estranho pode falar com seu bot:

    cat /agent/.openclaw/openclaw.json | grep -A 5 dmPolicy

Se mostrar "open" → fix imediato:

    nano /agent/.openclaw/openclaw.json
    (troca "open" por "allowlist" e adiciona seu chat_id)
    systemctl restart openclaw

Roda diagnostico de seguranca completo:
    /openclaw-os:security
```

### 9. Watchdog flapping

```
DIAGNOSTICO 9/10:

Watchdog reinicia o servico toda hora? Provavel:
  - Algum cron com erro fatal
  - OOM (out of memory)
  - Disco cheio

Diagnostico:
    journalctl -u openclaw --since "1 hour ago" | grep -i error
    free -m
    df -h

Cola o output.
```

### 10. Restore (perdi a VPS)

```
DIAGNOSTICO 10/10 — RESTORE:

1. Provisiona VPS nova (mesma config: Hostinger KVM 2 Ubuntu 24.04)
2. Conecta SSH
3. Roda /openclaw-os:install (Etapa 1) ate o passo 5 (wizard)
4. APOS o wizard, em vez de criar /agent do zero, faz:

    cd /
    rm -rf agent  (apaga o que o wizard criou)
    git clone git@github.com:{seu-user}/claw-{seu-nome}-backup.git agent

5. Restart:
    systemctl restart openclaw

6. Roda /openclaw-os:status pra validar

Tempo total: ~10min pra agente voltar a funcionar igual antes.
```

## Origem
Curso M2 · Etapa 10 (Resolvendo Problemas).
