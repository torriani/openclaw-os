---
name: openclaw-os:phase-5
description: |
  Phase 5 — Skills + Crons + Heartbeat. Instala primeira skill (sugerido: lembretes),
  configura cron heartbeat (5min) que mantem claw responsivo, ativa proatividade
  basica. Pre-req: phase 4 OK.
---

# Phase 5 — Skills + Crons + Heartbeat

**Tempo:** 15 min
**Objetivo:** Claw tem >= 1 skill funcional + heartbeat ativo + 1 cron proativo.

## Pre-checks

- state.json: `phases_completed` contem [1..4]
- OpenClaw responde no Telegram

## Conteudo de referencia

`legacy/squads/openclaw-creator/agents/skill-teacher.md` cobre criacao de skills + crons + heartbeat.

## Fluxo resumido

1. **Apresentar:** "Vou instalar tua primeira skill + heartbeat (~15min)"
2. **Sugerir skill basica:** lembretes (claw te lembra coisas via Telegram)
   - Aluno escolhe: lembretes / agenda / clima / outra
3. **Criar skill no VPS:** `~/openclaw/skills/{nome}/SKILL.md` com prompt + handler
4. **Heartbeat cron:**
   ```
   */5 * * * * cd ~/openclaw && node heartbeat.js
   ```
   (verifica se OpenAI API ta respondendo, se Telegram bot ta ativo)
5. **Cron proativo (1):** "Bom dia 7h" — claw manda mensagem motivacional baseada em USER.md
6. **Smoke test:** muda hora local pra 7h59 → espera mensagem 8h
7. **state.json:** `phases_completed: [1..5]`, `skills_installed: ["{nome}"]`

## Veto conditions

- Cron heartbeat falha → claw fica unresponsive, NAO avanca
- Skill nao executa → debug antes

## Origem
skill-teacher.md
