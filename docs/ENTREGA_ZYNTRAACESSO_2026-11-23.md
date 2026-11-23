# ZyntraAcesso — preparação independente, 23/11/2026

Estado: **em desenvolvimento, sem distribuição**.

Código separado em https://github.com/anderdias-br/zyntraacesso (privado durante o desenvolvimento), branch `codex/zyntraacesso`. Snapshot inicial `3d0bb24`; a origem e o submódulo permanecem identificados em `UPSTREAM.lock.json`. O branch local `codex/zyntraacesso-base` preserva o histórico raso upstream e a primeira adaptação; não foi necessário baixar todo o histórico para enviar o novo produto.

## Escopo e invariantes

Pedido: aplicativo independente para amigos/empresas, mesma logo/cores do Zyntra, número de conexão, senha permanente opcional e acesso acompanhado com aviso explícito. Administração deve respeitar UAC/serviço autorizado; ligar remotamente depende do hardware/rede.

Base: RustDesk 1.5.3/`95cca3f661f635b3cc85c04935fe8d96d8f432ef`, licença preservada. Nenhum código do AnyDesk foi extraído. ERP, serviços publicados, permissões empresariais, assinaturas, certificados e aplicativos instalados permaneceram intactos.

## Superfície alterada e cobertura

| Caminho | Preparação | Validação |
|---|---|---|
| `src/zyntra_access.rs`, `src/lib.rs`, `src/common.rs`, `src/main.rs` | Inicialização única da identidade antes da configuração/serviço | Revisão; build e coexistência Windows pendentes |
| `flutter/lib/common/widgets/zyntra_access.dart` | Moldura visual responsiva, logo oficial, claro/escuro e aviso de permissões | 3 testes de widget preparados; execução e inspeção nativa pendentes |
| `desktop_home_page.dart` | Reutiliza controles reais de conexão/ID/senha; atalho às configurações de segurança | Navegação e senha real pendentes |
| `common.dart`, `Runner.rc`, `runner/main.cpp`, ícones | Azul/navy e identificação do produto | Assets iguais aos oficiais por hash; renderização nativa pendente |
| `server_page.dart`, `consts.dart` | Aviso acompanhado, capacidades condicionadas às permissões, explicação de administrador; janela maior e rolagem de segurança | Aceite/recusa, UAC e textos longos pendentes |
| `desktop_setting_page.dart` | Identificação/atribuição do fork na seção Sobre; licença original preservada | Inspeção nativa pendente; privacidade específica ainda é requisito de distribuição |
| Transporte/senhas/captura/entrada/arquivos | Preservados do upstream; sem protocolo de autenticação próprio | Validar realmente em duas máquinas/redes antes de liberar |
| Servidor de ID/relay | Repositório OSS identificado, não implantado | Hospedagem/endereço/chave e recuperação pendentes |
| ERP/Web/Windows ERP/Android ERP | Sem alterações | Integração deliberadamente ausente; outro produto |
| Android/macOS/iOS/Web ZyntraAcesso | Fontes upstream existentes, não entregues | Fora do piloto Windows; não afirmar suporte validado |

Não existe catálogo compartilhado de empresas/máquinas nem conta universal neste incremento. Nenhuma senha fixa foi criada, lida da instalação atual ou enviada ao GitHub. Conhecer o ID não dá direito de acesso.

## Bloqueios e próximos passos

O computador atual não possui Rust/Cargo, Flutter/Dart, CMake/Ninja nem Docker nos caminhos consultados. Evitada instalação de uma cadeia nativa grande após a limpeza recente. Avaliar compilação existente no GitHub; registrar resultado real do fluxo manual e não tratar código como instalador.

Antes de disponibilizar: compilar/testar Windows, servidor independente autorizado, assinatura, recuperação/atualização, teste de senha errada/recusa/UAC/reinício e reconexão; privacidade e fonte correspondente acessível aos destinatários. WOL permanece não homologado, sem promessa de ligar equipamento sem energia.

### Estado confirmado ao encerrar este incremento

- Código enviado ao repositório próprio; licença upstream sem modificações e `git diff --check` sem erros.
- Conferência visual nativa e testes de widget **não executados**. Tentativas de disparo manual retornaram HTTP 404 de descoberta do workflow; a API listava zero workflows apesar de o arquivo existir na branch padrão. Não há execução nem resultado de teste neste repositório. Não confundir com o bloqueio de orçamento observado anteriormente no projeto iOS.
- Sem build, instalador, serviço, configuração de senha ou sessão remota ZyntraAcesso em execução.
- O proprietário esclareceu depois que provavelmente não possui VPS e pediu alternativa gratuita. Nenhum servidor fornecido/verificado e nenhuma contratação autorizada.
- Candidata para piloto: Oracle Cloud Always Free, a avaliar na conta do proprietário. Existem cotas, disponibilidade de capacidade e possibilidade de recolhimento de instâncias ociosas; não prometer disponibilidade empresarial. Fontes consultadas em 23/11/2026: https://www.oracle.com/cloud/free/ e https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm. Não criar conta, inserir cartão ou converter para serviço pago automaticamente.

## Organização e reversão

Um checkout em `C:\Projetos\zyntraacesso`, submódulo fixado sem cópia duplicada. Onze workflows originais preservados em `docs/upstream-workflows/`; não herdar cron/publicação de outros produtos. Nenhum servidor, navegador de prévia ou agente remoto foi iniciado. Nenhum programa do usuário encerrado. Não foram criados backups completos; Git preserva a origem e as mudanças. Retenção de binários será aplicada quando houver versões validadas.

Disco C: antes do preparo **64,68 GiB**, após fontes/ícones e preparação do histórico Git **64,50 GiB**. Fontes rastreadas: aproximadamente **18,95 MiB**, além dos objetos Git/submódulo. Este trabalho acrescentou fontes necessárias, não executou nova limpeza nem liberou espaço. Nenhum processo temporário persistente iniciado.
