# OpenClaw Setup Guide — Checklist Final

## Phase 1: Infra & Install
- [ ] VPS criado (Ubuntu 24.04)
- [ ] Sistema atualizado (apt update && upgrade)
- [ ] OpenClaw instalado
- [ ] tools.profile = "full"
- [ ] Timezone configurado
- [ ] Telegram bot criado (BotFather)
- [ ] Canal Telegram conectado
- [ ] Primeiro teste: mensagem enviada e resposta recebida
- [ ] Token optimization: compaction mode configurado

## Phase 2: Security Hardening
- [ ] Layer 1: dmPolicy = allowlist (Telegram)
- [ ] Layer 2: UFW ativo (deny incoming, allow SSH)
- [ ] Layer 3: Fail2ban configurado (maxretry=5, bantime=3600)
- [ ] Layer 4: Cloudflare Tunnel (127.0.0.1 apenas)
- [ ] Layer 5: Portas localhost-only
- [ ] Layer 6: SSH key-only (password auth desabilitado)
- [ ] Layer 7: Credential audit (zero hardcoded)
- [ ] Layer 8: 1Password CLI ou vault seguro
- [ ] Layer 9: Systemd + secrets sync

## Phase 3: Identity & Workspace
- [ ] SOUL.md criado (>= 100 linhas, sem frases genericas)
- [ ] USER.md criado (>= 200 linhas, detalhes do dono)
- [ ] IDENTITY.md criado (nome, emoji, background)
- [ ] AGENTS.md criado (>= 60 linhas, regras operacionais)
- [ ] BOOT.md criado (sequencia de startup)
- [ ] TOOLS.md criado (mapa de integracoes)
- [ ] HEARTBEAT.md criado (checklist periodico)
- [ ] Workspace organizado (memory/, skills/, reports/, scripts/)

## Phase 4: Memory System
- [ ] MEMORY.md como indice central
- [ ] memory/sessions/ para notas diarias
- [ ] memory/context/ (decisions.md, lessons.md, people.md, pending.md)
- [ ] memory/projects/ para projetos ativos
- [ ] memory/feedback/ para loops de feedback
- [ ] Regra de extracao antes de compaction configurada
- [ ] Semantic search ativo
- [ ] Consolidacao programada (a cada 15 dias)

## Phase 5: Skills, Crons & Proatividade
- [ ] >= 1 skill criada e funcional
- [ ] Skill auditada (sem curl suspeito, rm -rf, eval, hardcoded creds)
- [ ] >= 1 cron configurado (sessionTarget: "isolated" + agentTurn + announce)
- [ ] Crons espacados 15-30min entre si
- [ ] Crons usando Sonnet (nao Opus)
- [ ] HEARTBEAT.md com checklist de proatividade
- [ ] Horarios de silencio definidos (23h-8h)
- [ ] Rate limits de heartbeat: maxPerDay, maxCostPerDay

## Phase 6: Custos & Model Split
- [ ] Model split definido (Opus/Sonnet/Haiku por tipo de tarefa)
- [ ] Spend limit configurado no console.anthropic.com
- [ ] daily_max_usd definido
- [ ] alert_threshold definido
- [ ] Rate limit por hora configurado
- [ ] Fallback chain definida (Anthropic -> Google -> OpenAI)

## Phase 7: Immune System
- [ ] Watchdog cron ativo (daily 8am)
- [ ] Feedback loops configurados (max 30/file, FIFO)
- [ ] Cost monitoring ativo
- [ ] Security audit semanal agendado
- [ ] ROLLBACK.md template criado
- [ ] Procedimento de backup testado
- [ ] `openclaw doctor` executado sem erros

## Phase 8: Multi-Agentes (se aplicavel)
- [ ] Avaliado se precisa de sub-agentes (vs skills)
- [ ] Se sim: hub model configurado (main = Opus, subs = Sonnet/Haiku)
- [ ] TEAM.md criado com registro de agentes
- [ ] Leveling definido (L1-L4)
- [ ] Shared context configurado (TEAM.md, outputs/, lessons/)
- [ ] Follow-up de 15-30min para sub-agentes

## Phase 9: Mission Control & Go-Live
- [ ] Dashboard escolhido (NocoDB/Notion/Sheets)
- [ ] Estrutura de dados definida
- [ ] Agente integrado ao dashboard
- [ ] Health check final PASS
- [ ] Daily monitoring ativado
- [ ] Owner notificado: agente operacional
