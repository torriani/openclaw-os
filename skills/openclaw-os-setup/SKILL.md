---
name: openclaw-os:setup
description: |
  Orquestrador-mor da skill OpenClaw OS. Conduz o aluno do zero ao agente
  funcionando, passando pelas 12 etapas do curso na ORDEM CORRETA: abertura,
  install, security, identity, memory, integrations, proactivity, immune,
  use-cases, backup, troubleshoot, ssh. Salva estado em ~/.openclaw/state.json
  pra permitir resume. Esta skill chama as outras na sequencia certa.
---

# OpenClaw OS — Setup (orquestrador)

Esta skill conduz o aluno do zero ao agente AI funcionando, **na ordem exata
do curso M2**. Voce e o guia. Aluno responde, voce delega pra skill da etapa
correspondente, valida o checkpoint, e segue.

## Mapa das 12 etapas (ordem oficial do curso)

```
0.  Abertura         (~18min)  → /openclaw-os:abertura
1.  Setup            (~55min)  → /openclaw-os:install
2.  Seguranca        (~25min)  → /openclaw-os:security
3.  Identidade       (~30min)  → /openclaw-os:identity
4.  Memoria          (~40min)  → /openclaw-os:memory
5.  Integracoes      (~30min)  → /openclaw-os:integrations
6.  Proatividade     (~25min)  → /openclaw-os:proactivity
7.  Sist. Imune      (~30min)  → /openclaw-os:immune
8.  Use Cases        (~20min)  → /openclaw-os:use-cases
9.  Backup           (~25min)  → /openclaw-os:backup
10. Troubleshoot     (~ad-hoc) → /openclaw-os:troubleshoot
11. SSH com chave    (~10min)  → /openclaw-os:ssh

TOTAL: ~5h em 1-3 sessoes
```

## Fluxo

### Step 1: Saudacao + roadmap

Mostre **exatamente** isto na primeira mensagem:

```
========================================
  OPENCLAW OS — SETUP COMPLETO
========================================

Vou te guiar do zero ate seu agente AI rodando 24/7 no Telegram.

12 etapas em ordem (mesma ordem do curso M2):

  [0]  Abertura        — entender o que vem por ai     (~18min)
  [1]  Setup           — instalar OpenClaw na VPS      (~55min)
  [2]  Seguranca       — blindar o servidor            (~25min)
  [3]  Identidade      — dar alma ao agente            (~30min)
  [4]  Memoria         — agente nao esquece            (~40min)
  [5]  Integracoes     — Calendar, Gmail, APIs         (~30min)
  [6]  Proatividade    — heartbeat + crons             (~25min)
  [7]  Imunologico     — watchdog + backup auto        (~30min)
  [8]  Use Cases       — 20+ exemplos prontos          (~20min)
  [9]  Backup          — versionamento via GitHub      (~25min)
  [10] Troubleshoot    — diagnostico de problemas      (~ad-hoc)
  [11] SSH com chave   — alias `vps` rapido            (~10min)

Total: ~5h, em 1 a 3 sessoes (pode parar e voltar com /openclaw-os:resume).

Voce ja tem os pre-requisitos?
  ☐ Conta ChatGPT Plus       (~$20/mes)
  ☐ Telegram instalado
  ☐ VPS Hostinger contratada (~R$ 49/mes, KVM 2, Ubuntu 24.04)

Responde "tenho tudo" pra comecar pela Etapa 0 (Abertura),
ou diz qual falta pra eu te orientar.
```

Aguarde resposta.

### Step 2: Validar pre-requisitos

Se faltar algum, oriente:

- **ChatGPT Plus:** "Vai em chatgpt.com → Upgrade to Plus. $20/mes. Depois volta aqui."
- **Telegram:** "Baixa no celular, cria conta com seu numero. 2 minutos."
- **VPS Hostinger:** "Vai em hostinger.com.br → VPS → KVM 2 (recomendado, ~R$ 49/mes/12 meses). Escolhe Ubuntu 24.04 na hora de subir. Anota IP + senha root."

So avanca quando os 3 estao OK.

### Step 3: Coletar dados iniciais

```
Pra eu personalizar o setup, me responde:

1. Qual o nome do seu claw? (ex: Alfred, Sofia, Jarvis)
2. Qual o IP do seu VPS Hostinger?
3. Qual seu fuso horario? (ex: America/Sao_Paulo, America/Recife)
```

Slugify o nome (`Alfred` → `alfred`). Cria `~/.openclaw/{slug}/state.json`:

```json
{
  "claw_name": "{nome}",
  "claw_slug": "{slug}",
  "vps_ip": "{ip}",
  "timezone": "{tz}",
  "created_at": "{iso}",
  "current_etapa": 0,
  "etapas_completas": [],
  "go_live": false
}
```

### Step 4: Conduzir as 12 etapas em ordem

Pra cada etapa, faca:

1. **Anuncia** qual etapa vai comecar:
   ```
   ════════════════════════════════════════
   ETAPA {N} — {NOME}
   ════════════════════════════════════════

   Tempo estimado: ~{X}min
   ```

2. **Pede pro aluno rodar a skill correspondente:**
   ```
   Pra rodar esta etapa, digita no prompt:

       /openclaw-os:{nome-da-skill}

   Quando terminar (vai ter um checkpoint no final), volta aqui e
   me diz "ok" pra eu liberar a proxima.
   ```

3. **Aguarda "ok"**.

4. **Le o state.json** e confirma que `etapas_completas` contem o numero da etapa.

5. **Atualiza** `current_etapa` pra proxima e fecha esta:
   ```
   ✓ Etapa {N} ({NOME}) concluida

   Status:
     ✓ Etapa 0: Abertura
     ✓ Etapa 1: Setup
     ⏳ Etapa 2: Seguranca  ← VOCE ESTA AQUI
     ⏸ Etapa 3: Identidade
     ...

   Quer continuar agora ou parar aqui?
   (Pode retomar depois com /openclaw-os:resume)
   ```

### Step 5: Mapa de delegacao

Pra cada etapa, voce delega pra skill correta:

| Etapa | Skill | Funcao |
|---|---|---|
| 0  | `:abertura`     | Apresenta o curso, valida pre-reqs, mentaliza |
| 1  | `:install`      | VPS update + curl install.sh + wizard + status |
| 2  | `:security`     | UFW + Fail2ban + allowlist + env vars + portas |
| 3  | `:identity`     | 5 arquivos USER/SOUL/AGENTS/IDENTITY/BOOT |
| 4  | `:memory`       | decisions, lessons, pending, people, projects |
| 5  | `:integrations` | Calendar, Gmail, Drive, APIs |
| 6  | `:proactivity`  | Heartbeat, crons, alertas |
| 7  | `:immune`       | Watchdog, backup auto, audit, model split |
| 8  | `:use-cases`    | 20+ exemplos prontos |
| 9  | `:backup`       | Versionamento GitHub |
| 10 | `:troubleshoot` | Diagnostico (uso ad-hoc, nao no fluxo principal) |
| 11 | `:ssh`          | Alias `vps` pra conexao rapida |

### Step 6: Go-live final

Apos Etapa 11, marca `go_live: true` e mostra:

```
════════════════════════════════════════
  CLAW {NOME} ESTA NO AR ✓
════════════════════════════════════════

Voce passou pelas 12 etapas. Seu agente esta:

  ✓ Rodando 24/7 no VPS Hostinger
  ✓ Conectado ao seu Telegram
  ✓ Com identidade propria (USER/SOUL/AGENTS/IDENTITY/BOOT)
  ✓ Com memoria persistente (4 camadas)
  ✓ Integrado a Calendar, Gmail, etc
  ✓ Proativo (heartbeat + crons)
  ✓ Auto-recuperavel (watchdog + backup)
  ✓ Versionado no GitHub
  ✓ SSH rapido com alias `vps`

CUSTOS MENSAIS:
  VPS Hostinger:  R$ 49/mes
  ChatGPT Plus:   ~$20 (~R$ 100)
  Total:          ~R$ 150/mes

PROXIMOS PASSOS:
  - Use o agente! Manda mensagem pelo Telegram.
  - /openclaw-os:status     pra health check rapido
  - /openclaw-os:troubleshoot se algo travar
  - /openclaw-os:use-cases   pra ver 20+ casos prontos

PARABENS! Voce construiu um agente AI pessoal de verdade. 🎉
```

## Veto conditions

- Aluno tenta pular etapa → NAO permite. Cada etapa e gate da proxima.
- Aluno completa etapa mas state.json nao atualiza → roda checkpoint manual antes.
- VPS cai no meio → guia troubleshoot antes de avancar.

## Origem

Curso Core IA Mentoria — M2 — Construindo Seu Primeiro Agente.
Sequencia: abertura → setup → seguranca → identidade → memoria →
integracoes → proatividade → imunologico → use-cases → backup →
troubleshoot → ssh.
