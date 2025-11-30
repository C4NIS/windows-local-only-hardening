# 🛡️ Windows Local-Only Hardening
> Scripts de PowerShell para transformar o Windows 10/11 em um sistema **100% local**, sem SSO, sem sincronização automática, sem telemetria pesada e sem vinculação invisível à conta Microsoft.

Este repositório contém scripts focados em **privacidade, previsibilidade e controle total do ambiente** — extremamente úteis para:

- Profissionais de Cybersecurity  
- Red Team / Pentest  
- Analistas Forense  
- Desenvolvedores  
- Usuários que preferem ambientes minimalistas e offline  
- Pessoas que querem reduzir ruído cognitivo do Windows  

Nada aqui “quebra” o Windows.  
Todos os comandos usam funcionalidades **documentadas pela Microsoft**.  
O objetivo é:  
✔ reduzir integrações automáticas  
✔ desativar serviços desnecessários  
✔ impedir logins e sincronizações involuntárias  
✔ deixar o sistema mais limpo e sob controle do usuário  

---

## ✨ Recursos principais

### 🔐 Desativação completa de Single Sign-On (SSO)
- Desativa IdentityStore  
- Bloqueia Shared Experiences  
- Impede login automático de apps (WebAccountManager)  
- Força operação como “conta local”

### 🧱 Bloqueio do TokenBroker (Web Account Manager)
O serviço responsável por vincular a conta Microsoft ao sistema.  
O script:
- Para o serviço  
- Desativa no boot  
- Impede reativação automática  

### 🗂️ Remoção de sincronizações automáticas
- Config sync  
- Advertising ID  
- Telemetria associada à conta  
- Cloud Clipboard  
- Windows Timeline  

### 📉 Redução de Telemetria
- Ajusta DataCollection → `AllowTelemetry = 0`  
- Desativa várias tarefas de coleta  
- Impede envio de dados não essenciais  

### ☁️ OneDrive (opcional)
Remove o OneDrive do sistema, usando binários oficiais.  

---

## 📁 Scripts incluídos

### `disable_microsoft_integration.ps1`
Desativa:
- SSO  
- IdentityStore  
- Shared Experiences  
- Advertising ID  
- Cloud Clipboard  
- Timeline  
- Telemetria pesada  
- OneDrive (quando disponível)  
- Força operação como `LocalOnly`  

### `disable_tokenbroker.ps1`
Desativa de forma explícita o serviço:

que é responsável por:
- Logins invisíveis  
- Refresh de credenciais Microsoft  
- Integração entre apps e conta on-line  

---

## 🚀 Como executar

### 1. Abra PowerShell como Administrador  
Pressione Win → digite **PowerShell** → botão direito → *Executar como Administrador*.

### 2. Execute o script com bypass temporário:
```powershell
powershell.exe -ExecutionPolicy Bypass -File .\disable_microsoft_integration.ps1
