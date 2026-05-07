---
name: openclaw-os:security
description: |
  Etapa 2 — Blindagem do servidor. Guia o aluno em 5 frentes de seguranca:
  (1) Validar Allowlist Telegram, (2) Firewall UFW, (3) Fail2ban contra
  brute force, (4) Credenciais em env vars com chmod 600, (5) Portas em
  127.0.0.1 (nao 0.0.0.0). Audit final com score 0-10. Pre-req: Etapa 1 OK.
  Tempo: ~25min.
---

# Etapa 2 — Seguranca (5 frentes de blindagem)

**Tempo:** 25 min
**Objetivo:** Servidor blindado contra os 5 vetores de ataque mais comuns.

## IMPORTANTE

Voce **continua sendo o instrutor**. Aluno tem 2 terminais:
- Terminal 1: Claude Code (este, te guiando)
- Terminal 2: SSH na VPS (de Etapa 1)

## Pre-checks

- state.json: `etapas_completas` contem [0, 1]
- OpenClaw rodando (`gateway status` = running)
- Bot Telegram respondendo

## Conteudo da etapa

### Apresentacao

```
========================================
  ETAPA 2 — SEGURANCA
========================================

Vamos blindar seu servidor contra os 5 vetores de ataque mais comuns.

Frentes:
  1. Allowlist Telegram (so VOCE fala com o bot)
  2. Firewall UFW (so SSH passa, resto bloqueado)
  3. Fail2ban (3 tentativas erradas = IP banido 1h)
  4. Credenciais protegidas (.env com chmod 600)
  5. Portas em 127.0.0.1 (nao expostas em 0.0.0.0)

Tempo: ~25min. Pronto?
```

### Frente 1/5 — Validar Allowlist Telegram

```
FRENTE 1/5 — ALLOWLIST TELEGRAM

(Ja configurado na Etapa 1, vamos so validar.)

Cola este PROMPT no chat com seu bot no Telegram:

────────────────────────────────────────
Verifica se a seguranca do meu canal Telegram esta configurada
corretamente. Confere:

  - dmPolicy = allowlist?
  - Lista de IDs autorizados — tem so o meu?
  - Algum estranho na lista?

Me responde no formato:
  🛡️ Allowlist OK · so voce esta autorizado
ou
  ⚠️ ALERTA · IDs estranhos: [lista]

Se estiver tudo OK, da OK. Se nao, me indica o que mudar.
────────────────────────────────────────

Cola aqui o que ele respondeu.
```

Se OK → ✅ avanca. Se alerta → orienta o aluno a remover IDs estranhos via
edicao do `~/.openclaw/openclaw.json`.

### Frente 2/5 — Firewall UFW

```
FRENTE 2/5 — FIREWALL UFW

UFW (Uncomplicated Firewall) bloqueia conexoes que voce nao autorizou.
Vamos liberar SO o SSH (porta 22) e bloquear todo o resto.

No Terminal 2 (SSH), cola UM POR VEZ:

    ufw default deny incoming

    ufw default allow outgoing

    ufw allow 22/tcp comment 'SSH'

    ufw --force enable

Depois valida:

    ufw status verbose

Deve mostrar "Status: active" e a regra do SSH (22) liberada.

Cola aqui o output do `ufw status verbose`.
```

Validacao: output contem `Status: active` E `22/tcp ALLOW` → ✅

### Frente 3/5 — Fail2ban

```
FRENTE 3/5 — FAIL2BAN

Fail2ban detecta tentativas de login com senha errada e bane o IP
automaticamente. Configuracao: 3 tentativas erradas em 10min = ban 1h.

No Terminal 2, cola UM POR VEZ:

    apt install -y fail2ban

    cat > /etc/fail2ban/jail.local <<'EOF'
    [sshd]
    enabled = true
    port = 22
    maxretry = 3
    findtime = 600
    bantime = 3600
    EOF

    systemctl enable fail2ban && systemctl restart fail2ban

Valida:

    fail2ban-client status sshd

Deve mostrar "Currently banned: 0" e "Currently failed: 0" (ou numeros).

Cola o output aqui.
```

Validacao: output contem `Currently banned` (qualquer numero) → ✅

### Frente 4/5 — Credenciais protegidas

```
FRENTE 4/5 — .env COM CHMOD 600

O OpenClaw guarda credenciais em /etc/openclaw/.env. Esse arquivo
precisa de permissao 600 (so root le e escreve) e dono root:root.

No Terminal 2:

    chmod 600 /etc/openclaw/.env

    chown root:root /etc/openclaw/.env

    ls -la /etc/openclaw/.env

A saida deve comecar com:
    -rw------- 1 root root ...

(o `-rw-------` significa 600, e os "root root" sao dono e grupo)

Cola aqui o output do `ls -la`.
```

Validacao: output comeca com `-rw-------` E contem `root root` → ✅

### Frente 5/5 — Portas internas

```
FRENTE 5/5 — PORTAS EM 127.0.0.1

Servicos internos (banco, cache, etc) NAO podem estar escutando em
0.0.0.0 (todas as interfaces — exposto pra internet). Tem que estar em
127.0.0.1 (so localhost).

A unica excecao e o SSH na porta 22 (precisa ficar em 0.0.0.0 pra voce
conectar de fora).

No Terminal 2:

    ss -tlnp

Vai listar portas abertas. Procura por algo assim:

    LISTEN  0.0.0.0:22       <- SSH OK (precisa estar 0.0.0.0)
    LISTEN  127.0.0.1:N      <- Servico interno OK (so localhost)
    LISTEN  0.0.0.0:N        <- ⚠️ EXPOSTO! (problema)

Cola aqui o output completo do `ss -tlnp`.
```

Validacao: leia o output. Se TUDO em `127.0.0.1:` exceto `0.0.0.0:22` → ✅

Se houver outras portas em `0.0.0.0:`, identifica qual servico e e oriente:
- Se for OpenClaw mesmo → ja esta OK assim (Telegram precisa de internet)
- Se for outra coisa → para e investiga

### Audit final

```
========================================
  AUDIT FINAL — ETAPA 2 SEGURANCA
========================================

Vamos pedir pro seu agente fazer a auditoria final completa.
Cola este PROMPT no chat dele no Telegram:

────────────────────────────────────────
Acabei de configurar todas as 5 frentes de seguranca do servidor.
Quero que voce **apenas analise** se esta tudo certo · nao executa
mudancas, so valida e reporta.

Audita item por item:

1. Allowlist Telegram (dmPolicy=allowlist, so meu user)
2. UFW ativo (`ufw status verbose` retorna "active")
3. Fail2ban rodando (`fail2ban-client status sshd` mostra jail ativo)
4. .env protegido (chmod 600, chown root:root)
5. Portas em 127.0.0.1 (`ss -tlnp` sem servicos em 0.0.0.0 alem do SSH)

Me responde no formato:

🛡️ Auditoria de seguranca · Etapa 2

1. Allowlist Telegram  · ✅ OK
2. Firewall UFW        · ✅ OK
3. Fail2ban            · ✅ OK (X IPs banidos)
4. Credenciais         · ✅ OK
5. Portas internas     · ✅ OK

Score final: 10/10 · servidor blindado.
Pode seguir pra Etapa 3 (Identidade).

Se algum item nao passar, ajusta o score (ex: 7/10) e me lista o que
precisa corrigir antes de seguir.
────────────────────────────────────────

Cola aqui o que ele respondeu.
```

Validacao:
- Score 10/10 → ✅ avanca
- Score < 10 → identifica item faltante e corrige antes

### Atualizar state.json

```json
{
  "current_etapa": 3,
  "etapas_completas": [0, 1, 2],
  "security": {
    "allowlist_telegram": true,
    "ufw_active": true,
    "fail2ban_active": true,
    "env_chmod_600": true,
    "ports_localhost": true,
    "audit_score": 10
  }
}
```

### Fechar etapa

```
========================================
  ✓ ETAPA 2 CONCLUIDA
========================================

Servidor blindado:

  ✓ Allowlist Telegram (so VOCE fala com o bot)
  ✓ Firewall UFW ativo
  ✓ Fail2ban contra brute force
  ✓ .env com chmod 600
  ✓ Portas internas em 127.0.0.1
  ✓ Audit score: 10/10

PROXIMA ETAPA: Etapa 3 — Identidade (~30min)
(dar alma ao seu agente: USER, SOUL, AGENTS, IDENTITY, BOOT)

Volta ao /openclaw-os:setup e diz "ok" pra liberar a Etapa 3
(ou roda direto: /openclaw-os:identity)
```

## Camadas extras (v3.2+)

Mencione apos o audit final como "bonus pra depois":

```
BONUS — Camadas extras (configurar depois, nao agora):

  - Camada 6: openclaw secrets audit  (detecta credenciais expostas)
  - Camada 7: openclaw secrets apply  (cofre criptografado)
  - Camada 8: Cloudflare Tunnel       (painel admin em 127.0.0.1)
  - Camada 9: Rate limiting + quota   (futuro)

Estas sao avancadas e nao bloqueiam o curso. Pode rodar depois de
terminar todas as 12 etapas.
```

## Veto conditions

- UFW falhou ao ativar → PARA, diagnostica (talvez ja estava ativo)
- Fail2ban nao instala → confere internet no VPS
- .env nao existe → talvez Etapa 1 nao terminou direito, volta
- Audit final score < 8 → NAO avanca pra Etapa 3, corrige o que falta
- Aluno quer pular esta etapa → BLOCK. Sem seguranca, qualquer um usa o claw.

## Origem

Curso Core IA Mentoria — M2 — Etapa 2 (Seguranca).
Squad openclaw-creator/agents/infra-installer.md (9-layer hardening).
