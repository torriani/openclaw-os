---
name: openclaw-os:add-skill
description: |
  Adiciona skill nova a um claw existente. SSH no VPS, gera SKILL.md + handler,
  atualiza inventory, valida com smoke test, registra em skill-inventory.json.
---

# OpenClaw OS — Add Skill

**Tempo:** 15-30 min
**Objetivo:** Ensinar capacidade nova ao claw sem refazer pipeline.

## Pre-checks

- Claw alvo tem `go_live: true` no state.json
- Phase 5 (skills + crons) foi completada

## Fluxo

1. **Escolher claw alvo** (lista go_live=true)

2. **Coletar definicao da skill:**
   ```
   Nome da skill (kebab-case): _____
   O que ela faz (1 linha):    _____
   Trigger (palavras-chave):    _____
   Output esperado:             _____
   ```

3. **Gerar SKILL.md** com frontmatter + prompt + exemplos. Salva em `~/openclaw/skills/{nome}/SKILL.md` no VPS.

4. **Smoke test no Telegram:** aluno testa o trigger e confirma que claw responde corretamente.

5. **Atualizar `skill-inventory.json`** local + VPS:
   ```json
   {
     "{nome}": {
       "added_at": "{timestamp}",
       "version": "1.0.0",
       "status": "active",
       "last_used": null,
       "executions": 0
     }
   }
   ```

6. **state.json:** push em `skills_installed: [...]`

## Veto conditions

- Smoke test falha 3x → revert (remove SKILL.md), nao registra
- Skill com mesmo nome ja existe → pergunta: substituir ou criar v2?

## Origem
`legacy/squads/openclaw-manager/agents/skill-ops.md`
