---
name: openclaw-os:extract-memory
description: |
  Re-extrai perfil do aluno via ChatGPT (gera USER.md atualizado). Use quando perfil
  mudou (mudou de empresa, novo foco, nova fase de vida). Substitui USER.md anterior.
---

# OpenClaw OS — Extract Memory (Re-run)

**Tempo:** 10 min
**Objetivo:** Atualizar USER.md de um claw existente.

## Quando usar

- Perfil do aluno mudou bastante (empresa nova, foco diferente)
- USER.md original foi feito superficial e quer aprofundar
- Apos 6+ meses do setup inicial (mantem identity fresh)

## Fluxo

E o mesmo de `/openclaw-os:phase-1` mas:

1. Detecta que claw ja existe (state.json com `memory_extracted: true`)
2. Faz **backup do USER.md antigo:**
   ```
   ~/.openclaw/{claw}/identity/USER.md
   → ~/.openclaw/{claw}/identity/archive/USER-{timestamp}.md
   ```
3. Roda extracao do zero (mesmo prompt em `~/coreaios/openclaw-os/templates/memory-extraction-prompt.md`)
4. Salva novo USER.md
5. **SCP pro VPS** (substitui o que ta la)
6. **Restart OpenClaw** pra carregar identidade nova:
   ```bash
   ssh root@{IP} 'systemctl restart openclaw'
   ```
7. **Smoke test:** aluno manda "voce me conhece?" no Telegram, claw responde com novo perfil

## Veto conditions

- Aluno colou texto curto (<500 chars) → suspeito, repete
- SCP falha → mantem USER.md antigo, nao atualiza state.json
