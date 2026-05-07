# OpenClaw OS

Pacote completo da skill OpenClaw OS — guia o aluno do zero ate o agente AI
pessoal rodando 24/7 no Telegram, seguindo a sequencia oficial do curso M2
(Core IA Mentoria).

## Instalacao rapida (1 comando)

Cole no terminal:

```bash
git clone https://github.com/torriani/openclaw-os.git ~/openclaw-os && bash ~/openclaw-os/install.sh
```

Reinicia o Claude Code e digita:

```
/openclaw-os:setup
```

E segue o passo a passo guiado.

## Atualizacao (quem ja clonou)

```bash
cd ~/openclaw-os && git pull && rm -rf ~/.claude/skills/openclaw-os* && bash install.sh
```

## Skills disponiveis (17 no total)

### Comando principal

| Comando | Funcao |
|---|---|
| `/openclaw-os:setup` | **COMECE AQUI**. Orquestra as 12 etapas em ordem. |

### As 12 etapas (ordem do curso M2)

| # | Comando | Etapa do curso | Tempo |
|---|---|---|---|
| 0 | `:abertura`     | Abertura (intro + 8 etapas)              | 18min |
| 1 | `:install`      | Setup (OpenClaw na VPS, 11 passos)       | 55min |
| 2 | `:security`     | Seguranca (5 frentes + audit)            | 25min |
| 3 | `:identity`     | Identidade (5 arquivos + ChatGPT)        | 30min |
| 4 | `:memory`       | Memoria (4 camadas + extract rule)       | 40min |
| 5 | `:integrations` | Integracoes (Calendar, Gmail, crons)     | 30min |
| 6 | `:proactivity`  | Proatividade (heartbeat + automacoes)    | 25min |
| 7 | `:immune`       | Imunologico (watchdog + audit semanal)   | 30min |
| 8 | `:use-cases`    | 20+ casos de uso prontos                 | 20min |
| 9 | `:backup`       | Backup automatico via GitHub             | 25min |
| 10 | `:troubleshoot` | Diagnostico de 10 problemas comuns       | ad-hoc |
| 11 | `:ssh`          | Bonus SSH com chave + alias `vps`        | 10min |

### Comandos de operacao

| Comando | Quando usar |
|---|---|
| `:resume`     | Retomar pipeline interrompido |
| `:status`     | Health check rapido |
| `:help`       | Ajuda detalhada |

## Pre-requisitos do aluno

1. **ChatGPT Plus** (~$20/mes)
2. **Telegram** instalado
3. **VPS Hostinger** KVM 2, Ubuntu 24.04 (~R$ 49/mes)

## Custos mensais

- VPS Hostinger: R$ 49/mes
- ChatGPT Plus: ~R$ 100/mes
- **Total: ~R$ 150/mes**

## Tempo total

~5 horas, em 1-3 sessoes (pode parar e retomar com `/openclaw-os:resume`).

## Estrutura do pacote

```
openclaw-os/
├── install.sh              ← instalador (bash install.sh)
├── README.md               ← este arquivo
├── MANUAL.html             ← manual completo (abre no navegador)
├── skills/                 ← 17 skills (copiadas pra ~/.claude/skills/)
├── templates/              ← USER, SOUL, AGENTS, IDENTITY, BOOT, memory-extraction-prompt
├── checklists/             ← gates de validacao
├── state/                  ← state-schema.json
└── aulas/                  ← drafts pro agente que monta o curso
```

## Conteudo baseado em

- Curso Core IA Mentoria — M2 (Construindo Seu Primeiro Agente)
- Squad openclaw-creator (5 agents, 6.305 linhas: infra-installer,
  identity-builder, skill-teacher, guardian, setup-chief)
- Squad openclaw-manager (4 agents + 7 tasks + templates + outputs)

## Suporte

- Manual completo: abra `MANUAL.html` no navegador
- Problemas: `/openclaw-os:troubleshoot` no Claude Code
- Issues: github.com/torriani/openclaw-os/issues

---

OpenClaw OS · Juliano Torriani · Core AIOS · 2026
