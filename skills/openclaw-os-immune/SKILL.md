---
name: openclaw-os:immune
description: |
  Etapa 7 — Sistema Imunologico. Watchdog (cron 5min monitora outros crons,
  retry 3x), feedback loops (approved.json/rejected.json), audit semanal de
  seguranca (seg 9h, score 0-10), protocolo sub-agents no AGENTS.md (5 passos),
  backup automatico via git. Pre-req: Etapa 6 OK. Tempo: ~30min.
---

# Etapa 7 — Sistema Imunologico

**Tempo:** 30 min
**Objetivo:** Agente que se auto-recupera, aprende com erros e mantem
seguranca em dia.

## Apresentacao

```
========================================
  ETAPA 7 — SISTEMA IMUNOLOGICO
========================================

Sistema vivo precisa de defesa. Vamos ativar:

  1. Watchdog        — monitora outros crons, retry se falhar
  2. Feedback loops  — aprende com aprovacoes e rejeicoes
  3. Audit semanal   — checklist seguranca toda segunda 9h
  4. Sub-agents      — protocolo no AGENTS.md (5 passos)
  5. Backup auto     — git commit todo dia 23h

Tempo: ~30min. Pronto?
```

## Os passos

### Passo 1 — Watchdog

```
PASSO 1/5 — WATCHDOG

No Terminal 2:

    claude /cron:create watchdog

Configuracao:
  Schedule: */5 * * * * (a cada 5 minutos)
  Modelo: Haiku
  Acao:
    1. Lista crons ativos
    2. Pra cada um, checa ultimo log
    3. Se falhou → retry (max 3x)
    4. Se falhou 3x → alerta no Telegram

Confirma quando criar.
```

### Passo 2 — Feedback loops

```
PASSO 2/5 — APPROVED.JSON E REJECTED.JSON

No Terminal 2:

    cd /agent
    mkdir -p memory/feedback
    touch memory/feedback/{approved.json,rejected.json,recommendations.json}

Inicia cada um como array vazio:

    echo '[]' > memory/feedback/approved.json
    echo '[]' > memory/feedback/rejected.json
    echo '[]' > memory/feedback/recommendations.json

Cola este PROMPT no Telegram:

────────────────────────────────────────
Configura feedback loops em memory/feedback/:

  approved.json — sugestoes que eu aprovei (formato: {timestamp,
    sugestao, contexto})
  rejected.json — sugestoes que eu rejeitei (mesmo formato + motivo)
  recommendations.json — padroes que voce identificou

Regra: max 30 entradas por arquivo (FIFO — mais antigo sai).

Antes de qualquer sugestao nova, voce checa esses arquivos pra nao
repetir o que ja foi rejeitado.

Confirma.
────────────────────────────────────────
```

### Passo 3 — Audit semanal

```
PASSO 3/5 — SECURITY AUDIT (seg 9h)

No Terminal 2:

    claude /cron:create security-audit

Configuracao:
  Schedule: 0 9 * * 1 (toda segunda, 9h)
  Modelo: Sonnet
  Acao:
    1. openclaw doctor (health check)
    2. ufw status verbose
    3. fail2ban-client status sshd
    4. ls -la /etc/openclaw/.env (chmod 600?)
    5. Score 0-10 baseado nos checks
    6. Verde (10) → silencioso
    7. ⚠️ (<10) → resume + fix no Telegram

Cola aqui o output da criacao.
```

### Passo 4 — Protocolo sub-agents no AGENTS.md

```
PASSO 4/5 — PROTOCOLO SUB-AGENTS

Cola este PROMPT:

────────────────────────────────────────
Adiciona no AGENTS.md uma secao "Protocolo Sub-Agents" com 5 passos:

## Protocolo Sub-Agents

Quando voce delegar uma tarefa pra um sub-agent (cron, watchdog,
heartbeat), segue:

  1. ANUNCIAR — antes de comecar, registra em memory/sessions/HOJE.md
     o que vai fazer
  2. FOLLOW-UP — em 15-30min, checa se terminou
  3. RESUME-HUMANO — se tarefa pediu input meu, alerta no Telegram
  4. RETRY-AUTO — se falhou, retry 1x antes de me avisar
  5. NUNCA-LIMBO — toda tarefa termina em sucesso, falha registrada
     ou pending. Nunca fica "esquecida".

Confirma quando atualizar AGENTS.md.
────────────────────────────────────────
```

### Passo 5 — Backup automatico

```
PASSO 5/5 — BACKUP DIARIO VIA GIT

Pre-requisito: agente conectado a um repo Git proprio (vamos
configurar na Etapa 9 — Backup. Por enquanto, prepara o cron.)

No Terminal 2:

    claude /cron:create backup-diario

Configuracao:
  Schedule: 0 23 * * * (todo dia 23h)
  Modelo: Sonnet
  Acao:
    1. cd /agent
    2. git add -A
    3. git commit -m "auto-backup $(date +%Y-%m-%d)"
    4. git push (se remote configurado)
    5. Loga sucesso/falha em memory/sessions/HOJE.md

Confirma. (Pode dar erro de "no remote" agora — ok, na Etapa 9
configura o GitHub remote.)
```

## Audit final imunologico

```
AUDIT FINAL — IMUNOLOGICO

Cola este PROMPT no Telegram:

────────────────────────────────────────
Faz auditoria do meu sistema imunologico. Confere:

  1. Watchdog ativo (cron a cada 5min)?
  2. Feedback files existem e sao validos JSON?
  3. Security audit configurado pra segunda 9h?
  4. AGENTS.md tem secao "Protocolo Sub-Agents"?
  5. Backup diario configurado pras 23h?

Score 0-10. Resposta no formato:

🛡️ Auditoria imunologica · Etapa 7

1. Watchdog               · ✅ OK
2. Feedback loops         · ✅ OK
3. Security audit semanal · ✅ OK
4. Protocolo sub-agents   · ✅ OK
5. Backup diario          · ✅ OK (sem remote ainda)

Score: 10/10 · imune. (ou X/10 + lista do que falta)
────────────────────────────────────────
```

## Atualizar state.json

```json
{
  "current_etapa": 8,
  "etapas_completas": [0..7],
  "immune": {
    "watchdog": true,
    "feedback_loops": true,
    "security_audit_weekly": true,
    "subagent_protocol": true,
    "backup_daily": true
  }
}
```

## Fechar

```
✓ Etapa 7 concluida

PROXIMA ETAPA: Etapa 8 — Casos de Uso (~20min)
```

## Origem
Curso M2 · Etapa 7 (Imunologico).
Squad openclaw-creator/agents/guardian.md (immune system 5-layer).
