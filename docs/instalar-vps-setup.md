# Instalar a skill `vps-setup` na VPS

Pre-requisito do M2 (Core IA Mentoria). Esse guia mostra como preparar uma VPS
Ubuntu nova com **Node 20, npm e Claude Code** instalados, usando a skill
`/vps-setup`.

---

## Quando usar

Use esse passo a passo quando a sua VPS Ubuntu acabou de ser criada (Hostinger,
DigitalOcean, etc) e ainda **nao tem** Claude Code instalado.

Se a VPS ja tem Claude Code rodando, pula direto pra `/openclaw-os:install`.

---

## Passo 1 — Entra na VPS via SSH

No terminal do seu computador (Mac, Windows ou Linux), conecta na VPS:

```bash
ssh root@SEU_IP_DA_VPS
```

Substitui `SEU_IP_DA_VPS` pelo IP que a Hostinger (ou outro provedor) te
forneceu. A senha eh a que voce definiu na criacao da VPS.

**Output esperado:**

```
Welcome to Ubuntu 24.04 LTS (GNU/Linux ...)
root@srvXXXXX:~#
```

A partir daqui, todos os comandos rodam **dentro da VPS**.

---

## Passo 2 — Baixa a skill `vps-setup`

Cola o bloco abaixo inteiro no terminal da VPS:

```bash
mkdir -p ~/.claude/skills/vps-setup && \
curl -fsSL https://raw.githubusercontent.com/torriani/openclaw-os/main/skills/vps-setup/SKILL.md \
  -o ~/.claude/skills/vps-setup/SKILL.md && \
echo "✅ Skill vps-setup instalada em ~/.claude/skills/vps-setup/"
```

**O que esse comando faz:**

1. Cria a pasta `~/.claude/skills/vps-setup/`
2. Baixa o arquivo `SKILL.md` direto do GitHub via `curl`
3. Confirma que deu certo

**Output esperado:**

```
✅ Skill vps-setup instalada em ~/.claude/skills/vps-setup/
```

---

## Passo 3 — Verifica que baixou

```bash
ls -la ~/.claude/skills/vps-setup/
```

Tem que listar o arquivo `SKILL.md`.

```bash
head -10 ~/.claude/skills/vps-setup/SKILL.md
```

Tem que mostrar:

```yaml
---
name: vps-setup
description: Setup de VPS Ubuntu para rodar Claude Code...
```

Se aparecer isso, a skill esta instalada corretamente.

---

## Passo 4 — Le o passo a passo completo da skill

A skill `SKILL.md` tem **6 etapas guiadas** pra instalar Node, npm, Claude Code
e fazer o primeiro login. Roda:

```bash
cat ~/.claude/skills/vps-setup/SKILL.md
```

Vai aparecer o passo a passo inteiro. Roda cada bloco `bash` da skill
**na ordem**, uma etapa por vez:

| # | Etapa | O que faz |
|---|-------|-----------|
| 0 | Verifica Ubuntu | Confirma que e Ubuntu/Debian |
| 1 | Atualiza sistema | `apt update && apt upgrade -y` |
| 2 | Dependencias base | `build-essential curl git ca-certificates` |
| 3 | Node 20 LTS | NodeSource + npm incluso |
| 4 | Claude Code | `npm install -g @anthropic-ai/claude-code` |
| 5 | Primeiro login | Autentica no Claude (URL no browser do Mac) |
| 6 | Verificacao | Confirma `node`, `npm`, `claude --version` |

**Confirma o output esperado de cada etapa antes de avancar pra proxima.** Se
algo falhar, consulta a tabela "Erros comuns" no fim do `SKILL.md`.

---

## Passo 5 — Apos o setup, ativa a skill no Claude Code

Quando terminar a Etapa 6 da skill, voce ja vai ter Claude Code instalado e
autenticado na VPS. Pra usar a skill `vps-setup` de forma guiada (com Claude
te conduzindo), roda dentro da VPS:

```bash
claude
```

Vai abrir o Claude Code interativo. Ai digita:

```
/vps-setup
```

A skill vai conduzir o passo a passo com explicacoes em portugues e validacao
em cada etapa. Como tudo ja esta instalado, ela vai confirmar o status atual e
apontar o **proximo passo**: `/openclaw-os:install`.

---

## Resumo dos comandos (copy-paste rapido)

Pra quem quer so o essencial sem ler explicacao:

```bash
# 1. Conecta na VPS
ssh root@SEU_IP_DA_VPS

# 2. Baixa a skill
mkdir -p ~/.claude/skills/vps-setup && \
curl -fsSL https://raw.githubusercontent.com/torriani/openclaw-os/main/skills/vps-setup/SKILL.md \
  -o ~/.claude/skills/vps-setup/SKILL.md && \
echo "✅ Skill instalada"

# 3. Le o passo a passo
cat ~/.claude/skills/vps-setup/SKILL.md

# 4. Roda manualmente as 6 etapas (Node, npm, Claude Code, login)
#    Comandos detalhados estao dentro do SKILL.md acima

# 5. Apos terminar, ativa a skill no Claude
claude
# dentro do Claude:
/vps-setup
```

---

## Alternativa — Instalar todas as 18 skills de uma vez

Se voce quer ja deixar **todas as skills do OpenClaw OS** prontas (incluindo
`vps-setup`), use o instalador completo do repo:

```bash
# 1. Instala git (caso nao tenha numa VPS minimalista)
sudo apt update && sudo apt install -y git

# 2. Clona o repo e instala todas as 18 skills
git clone https://github.com/torriani/openclaw-os.git ~/openclaw-os && \
  bash ~/openclaw-os/install.sh
```

Isso copia as 18 skills pra `~/.claude/skills/` de uma vez. Depois e so abrir
o Claude Code e usar qualquer uma:

- `/vps-setup` — preparar stack base
- `/openclaw-os:setup` — orquestrador do pipeline completo
- `/openclaw-os:install` — etapa 1 do M2
- (e mais 15 skills do OpenClaw)

---

## Erros comuns

| Erro | Causa | Fix |
|------|-------|-----|
| `curl: command not found` | VPS minimalista sem curl | `sudo apt update && sudo apt install -y curl` |
| `Permission denied (publickey)` no SSH | SSH so aceita chave, nao senha | Configurar SSH key (ver `/openclaw-os:ssh`) ou ativar PasswordAuthentication |
| `404 Not Found` no curl | URL digitada errada ou repo privado | Confere a URL: `https://raw.githubusercontent.com/torriani/openclaw-os/main/skills/vps-setup/SKILL.md` |
| `mkdir: cannot create directory` | Sem permissao no `$HOME` | Confirma que esta logado como `root` ou usuario com home valido (`echo $HOME`) |

---

## Proximo passo

Apos terminar `vps-setup`, segue pra:

```
/openclaw-os:install
```

Que eh a Etapa 1 do M2 (Setup OpenClaw na VPS, 11 passos, ~55 min).
