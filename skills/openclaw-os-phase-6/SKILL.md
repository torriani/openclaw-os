---
name: openclaw-os:phase-6
description: |
  Phase 6 — Costs + Immune System 5-layer. Configura model split (gpt-4o-mini / gpt-4o)
  pra economia 75-80%, rate limits, budget alerts, watchdog que reinicia claw em crash,
  backup diario, audit semanal. Pre-req: phase 5 OK.
---

# Phase 6 — Costs + Immune System

**Tempo:** 10 min
**Objetivo:** Claw tem custos controlados + auto-recovery em crash.

## Pre-checks

- state.json: `phases_completed` contem [1..5]

## Conteudo de referencia


## Fluxo resumido

1. **Apresentar:** "Vou configurar economia + auto-recovery (~10min)"
2. **Model split:**
   - Tarefas simples (chat curto, lookups) → `gpt-4o-mini` (~$0.15/MTok input)
   - Tarefas medias (sumario, analise) → `gpt-4o-mini` com mais context
   - Tarefas complexas (codigo, raciocinio) → `gpt-4o` (~$2.50/MTok)
   - Default: gpt-4o-mini, escala so se necessario
3. **Rate limit:** max 50 msgs/hora por chat_id (anti-spam)
4. **Budget alert:** se gasto mensal > $20, manda alerta no Telegram
5. **Immune System 5-layer:**
   - L1: Watchdog cron 1min (checa systemctl status, restart se inativo)
   - L2: OOM guard (restart se RAM > 80%)
   - L3: API key rotation alert (avisa antes de expirar)
   - L4: Backup diario `tar -czf` de identity/ + memory/
   - L5: Audit semanal (domingo) — verifica logs, gastos, anomalias
6. **Smoke test:** `kill -9 $(pgrep openclaw)` → watchdog restart em <60s
7. **state.json:** `phases_completed: [1..6]`

## Veto conditions

- Watchdog nao restart em 60s → NAO avanca, fix
- Backup falha → NAO avanca

## Origem
guardian.md
