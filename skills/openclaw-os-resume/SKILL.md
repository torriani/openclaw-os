---
name: openclaw-os:resume
description: |
  Retoma pipeline OpenClaw OS interrompido. Le ~/.openclaw/*/state.json,
  identifica claws com pipeline parcial, mostra de onde continuar.
---

# OpenClaw OS — Resume

## Fluxo

### Step 1: Listar claws com pipeline incompleto

```bash
ls ~/.openclaw/*/state.json 2>/dev/null
```

Pra cada um, le e checa `go_live`. Se `false`, mostra status:

```
CLAWS COM PIPELINE INCOMPLETO:

  1. alfred       → Phase 4/7 (Identity + Memory)  — ultima atualizacao 2h atras
  2. sofia        → Phase 2/7 (Credentials)        — ultima atualizacao ontem
  3. zeus         → Phase 6/7 (Costs + Immune)     — ultima atualizacao 30min

Qual quer retomar?
```

### Step 2: Retomar fase atual

Aluno escolhe (ex: `alfred`). Le `state.json`, pega `current_phase`, mostra:

```
RETOMANDO: alfred

Status:
  ✓ Phase 1: Memory Extraction
  ✓ Phase 2: Credentials
  ✓ Phase 3: Infra + Security
  ⏳ Phase 4: Identity + Memory  ← VOCE ESTA AQUI
  ⏸ Phase 5: Skills + Crons
  ⏸ Phase 6: Costs + Immune
  ⏸ Phase 7: Mission Control

Pra continuar, digite:

  /openclaw-os:phase-4

Quando terminar, volte aqui e diga "ok" pra eu liberar Phase 5.
```

### Step 3: Se nao tiver claw incompleto

```
Nao tem pipeline pendente. Voce pode:
  - /openclaw-os:start          (criar claw novo)
  - /openclaw-os:status         (health check de claws ativos)
```

## Veto conditions

- state.json corrompido → mostra erro e oriente a recomecar com /openclaw-os:start
