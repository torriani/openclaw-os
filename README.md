# OpenClaw OS

Pacote completo da skill OpenClaw OS — cria agentes AI pessoais (claws) rodando 24/7 no VPS dos alunos.

## Instalacao rapida (1 comando)

Cole no terminal:

```bash
git clone https://github.com/torriani/openclaw-os.git ~/openclaw-os && bash ~/openclaw-os/install.sh
```

Depois feche e reabra o Claude Code, e digite no prompt:

```
/openclaw-os:start
```

E segue o passo a passo guiado.

## Instalacao manual (alternativa)

1. Clone o repo: `git clone https://github.com/torriani/openclaw-os.git`
2. Abre terminal na pasta `openclaw-os/`
3. Roda: `bash install.sh`
4. Fecha e reabre o Claude Code
5. Digita: `/openclaw-os:start`

## Pre-requisitos do aluno

- VPS Hostinger com Ubuntu 24.04 (KVM 1 ou 2)
- Conta ChatGPT (Plus recomendado)
- Telegram instalado no celular

## O que tem dentro

```
openclaw-os/
├── install.sh              ← instalador (bash install.sh)
├── README.md               ← este arquivo
├── MANUAL.html             ← manual completo (abre no navegador)
├── skills/                 ← as 16 skills (copiadas pra ~/.claude/skills/)
│   ├── openclaw-os/
│   ├── openclaw-os-start/
│   ├── openclaw-os-resume/
│   ├── openclaw-os-help/
│   ├── openclaw-os-status/
│   ├── openclaw-os-upgrade/
│   ├── openclaw-os-daily/
│   ├── openclaw-os-add-skill/
│   ├── openclaw-os-extract-memory/
│   └── openclaw-os-phase-1/ ... openclaw-os-phase-7/
├── templates/              ← BOOT, AGENTS, IDENTITY, USER, SOUL, memory-extraction-prompt
├── checklists/             ← gates de validacao
└── state/                  ← state-schema.json
```

## Comandos disponiveis (depois de instalar)

| Comando | Quando usar |
|---|---|
| `/openclaw-os:start` | **COMECE AQUI**. Pipeline 7 fases do zero. |
| `/openclaw-os:resume` | Retoma pipeline interrompido. |
| `/openclaw-os:status` | Health check rapido. |
| `/openclaw-os:upgrade` | Atualiza claw existente. |
| `/openclaw-os:help` | Lista comandos detalhada. |

90% do tempo voce so usa `/openclaw-os:start`. As 7 fases rodam em sequencia automaticamente.

## Manual completo

Abra `MANUAL.html` no navegador pra detalhes de cada fase, troubleshooting, FAQ.

## Custos mensais por claw

- VPS Hostinger: $5–10
- ChatGPT API: $5–15 (com model split)
- Total: **$10–25/mes**

## Suporte

Em caso de problema, consulta a secao **Troubleshooting** do MANUAL.html.

---

OpenClaw OS · Juliano Torriani · Core AIOS · 2026
