---
name: openclaw-os:phase-4
description: |
  Phase 4 — Identity + Memory 4-layer. Cria SOUL.md, IDENTITY.md, AGENTS.md,
  BOOT.md no VPS usando templates + USER.md de Phase 1. Configura memory system
  4 camadas (working, episodic, semantic, procedural). Pre-req: phase 3 OK.
---

# Phase 4 — Identity + Memory

**Tempo:** 15 min
**Objetivo:** Claw tem identidade definida (alma, papel, contexto) e memoria persistente.

## Pre-checks

- state.json: `phases_completed` contem [1,2,3]
- `USER.md` existe (Phase 1)
- VPS acessivel via SSH

## Templates disponiveis

Em `~/coreaios/openclaw-os/templates/`:
- `SOUL.template.md` — alma do claw (valores, missao, "quem ele e")
- `IDENTITY.template.md` — identidade tecnica (nome, papel, capacidades)
- `AGENTS.template.md` — sub-agentes que ele orquestra
- `BOOT.template.md` — instrucoes de boot do agente
- `USER.md` — perfil do aluno (Phase 1, ja gerado)

## Conteudo de referencia

`legacy/squads/openclaw-creator/agents/identity-builder.md` tem o processo completo de construir os 5 arquivos + 4-layer memory system. Le como referencia operacional.

## Fluxo resumido

1. **Apresentar:** "Vou criar 5 arquivos identidade + memoria 4 camadas (~15min)"
2. **Coletar 4 inputs:** nome do claw, papel principal, 3 valores top, tom de voz
3. **Renderizar templates** substituindo placeholders ({CLAW_NAME}, {ROLE}, etc)
4. **Upload pro VPS:** SCP pra `~/openclaw/identity/`
5. **Criar memory dirs:**
   ```
   ~/openclaw/memory/working/    (sessao atual, RAM)
   ~/openclaw/memory/episodic/   (eventos diarios, JSONL)
   ~/openclaw/memory/semantic/   (fatos, vector DB)
   ~/openclaw/memory/procedural/ (skills aprendidas)
   ```
6. **Restart OpenClaw:** `systemctl restart openclaw` (carrega nova identidade)
7. **Smoke test no Telegram:** aluno manda "quem e voce?" → claw responde com IDENTITY.md
8. **state.json:** `phases_completed: [1..4]`, `current_phase: 5`, `identity_built: true`

## Veto conditions

- Algum template falta placeholder → PARA, peca info ao aluno
- Restart OpenClaw falha → mostra logs
- Telegram smoke test nao responde em 30s → diagnostica antes

## Origem
identity-builder.md + templates do Manager
