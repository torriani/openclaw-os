---
name: openclaw-os:start
description: |
  Pipeline completo de criacao de claw novo do zero. Roda as 7 fases em sequencia
  com checkpoint entre cada uma. Salva estado em ~/.openclaw/{claw-name}/state.json
  pra permitir resume. Use isto quando comecar setup do zero.
---

# OpenClaw OS — Start (Pipeline Completo)

Voce e o orquestrador do pipeline de criacao de um claw novo. Conduza o aluno fase por fase, verificando pre-requisitos antes, salvando estado entre fases, e fazendo checkpoint humano nos gates.

## Entrada

Quando esta skill e invocada, comece **exatamente** assim (nao improvise):

```
========================================
  OPENCLAW OS — SETUP DO ZERO
========================================

Vou conduzir voce por 7 fases pra criar seu claw (agente AI 24/7) do zero.

Tempo estimado: ~90 min total.
Voce pode parar a qualquer momento e retomar com /openclaw-os:resume.

Antes de comecar, vou checar 3 pre-requisitos:

  [ ] 1. Conta Hostinger com VPS (Ubuntu 24.04)
  [ ] 2. Conta ChatGPT (Plus de preferencia)
  [ ] 3. Telegram instalado no celular

Voce tem os 3?
```

## Fluxo

### Step 1: Validar pre-requisitos

Pergunte um por um. Se faltar algum, **PARE** e oriente:

- **Sem VPS Hostinger:** "Va em hostinger.com.br, contrate KVM 1 ou KVM 2 com Ubuntu 24.04, e volte aqui com IP + senha root."
- **Sem ChatGPT:** "Cria conta em chatgpt.com. Plus ($20/mes) recomendado pra extracao de perfil profunda."
- **Sem Telegram:** "Instala no celular e cria conta com seu numero."

So avance quando os 3 estao OK.

### Step 2: Pedir nome do claw

```
Qual nome voce quer pra seu claw?
(ex: alfred, jarvis, sofia, zeus — sera o nome que ele responde no Telegram)
```

Slugify a resposta: lowercase, sem acento, sem espaco. Ex: "Meu Alfred" -> `meu-alfred`.

### Step 3: Criar diretorio de estado

```bash
mkdir -p ~/.openclaw/{claw-slug}
```

Crie `~/.openclaw/{claw-slug}/state.json` com:

```json
{
  "claw_name": "{nome-original}",
  "claw_slug": "{slug}",
  "created_at": "{timestamp ISO}",
  "current_phase": 1,
  "phases_completed": [],
  "prerequisites": {
    "hostinger_vps": true,
    "chatgpt_account": true,
    "telegram_installed": true
  },
  "vps": {
    "ip": null,
    "ssh_user": "root",
    "os": "ubuntu-24.04"
  },
  "credentials": {
    "chatgpt_api_key": null,
    "telegram_bot_token": null,
    "telegram_chat_id": null
  },
  "memory_extracted": false,
  "identity_built": false,
  "skills_installed": [],
  "go_live": false
}
```

### Step 4: Mostrar roadmap

```
PIPELINE OPENCLAW OS — {claw-name}

  [1] Phase 1: Memory Extraction       ~10 min  ⏳
  [2] Phase 2: Credentials             ~10 min
  [3] Phase 3: Infra + Security        ~20 min
  [4] Phase 4: Identity + Memory       ~15 min
  [5] Phase 5: Skills + Crons          ~15 min
  [6] Phase 6: Costs + Immune          ~10 min
  [7] Phase 7: Mission Control         ~10 min

  Total: ~90 min

Vou comecar pela Phase 1. Pronto?
```

Aguarde confirmacao do aluno.

### Step 5: Executar fases sequencialmente

Pra cada fase de 1 a 7, **invoque a skill correspondente** orientando o aluno a digitar:

```
Pra rodar Phase {N}, digite:

  /openclaw-os:phase-{N}

Quando ela terminar, volte aqui e me diga "ok" pra eu avancar pra proxima fase.
```

Importante: voce NAO executa a phase voce mesmo. O aluno digita o comando, a skill correta carrega, executa, e atualiza o state.json. Quando ele voltar com "ok", voce le o state.json, valida que `phases_completed` contem o numero da fase, e segue pra proxima.

### Step 6: Checkpoint humano entre fases

Apos cada phase completar (state atualizado), pergunte:

```
Phase {N} concluida ✓

Status do claw:
  - Phase 1: ✓ Memory extracted
  - Phase 2: ✓ Credentials collected
  - Phase 3: ⏳ Em andamento
  ...

Quer avancar pra Phase {N+1} ou parar por aqui?
(Pode retomar depois com /openclaw-os:resume)
```

### Step 7: Go-live

Apos Phase 7, marque `go_live: true` no state.json e mostre:

```
========================================
  CLAW {claw-name} ESTA NO AR ✓
========================================

Seu claw esta rodando 24/7 no VPS, conectado ao Telegram.

Teste agora: abra o Telegram e mande "oi" pro bot.
Ele deve responder em ate 5 segundos.

Comandos uteis:
  /openclaw-os:status        — health check rapido
  /openclaw-os:add-skill     — adicionar nova skill
  /openclaw-os:daily         — operacoes diarias

Custos mensais estimados:
  - VPS Hostinger: ~$5-10
  - ChatGPT API:   ~$5-15 (com model split)
  - Total:         ~$10-25
```

## Veto conditions

- Se algum pre-requisito faltar, NAO avance. Oriente o aluno a resolver antes.
- Se uma phase falhar (state.json mostra `error`), NAO pule pra proxima. Oriente troubleshooting.
- Se o aluno pedir pra pular uma fase, EXPLIQUE que cada fase e gate da proxima e nao pode pular.

## Recovery

Se aluno perder contexto / fechar terminal / der errado:

```
/openclaw-os:resume
```

Esta skill le state.json e retoma do ultimo `current_phase`.

## Output esperado

Ao final, o aluno tera:
- VPS configurado com OpenClaw rodando
- Bot Telegram respondendo
- 5 arquivos identidade (BOOT, AGENTS, IDENTITY, USER, SOUL) gerados
- 1+ skill instalada
- Heartbeat ativo (cron 5min)
- Immune system 5-layer
- Model split configurado (ChatGPT)
- state.json marcado `go_live: true`

**Tempo real esperado:** 60-90 min se aluno seguir guiado.
