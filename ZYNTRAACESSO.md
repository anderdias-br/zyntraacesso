# ZyntraAcesso

Aplicativo independente de acesso remoto para Windows, destinado inicialmente ao proprietário, amigos e outras empresas. Usa a identidade visual do Zyntra, mas **não faz parte do ERP**, não usa suas contas, senhas, banco, regiões, certificados nem atualizadores.

**Estado: desenvolvimento. Não há instalador ZyntraAcesso validado ou serviço público em operação.**

## Experiência solicitada

- Número de conexão do computador e campo para conectar a outro número.
- Acesso acompanhado: a pessoa recebe a solicitação, vê a identidade/ID do solicitante e as permissões, e pode aceitar ou recusar.
- Acesso sem confirmação: opcional, habilitado explicitamente pelo proprietário do equipamento com senha permanente. Nunca senha universal, senha no código ou acesso apenas por conhecer o número.
- Tela, mouse/teclado e arquivos pelas capacidades existentes do motor RustDesk. Recursos não testados não estão homologados.
- Administração: usar o serviço e a elevação nativa do Windows. Instalação/elevação requer consentimento ou credenciais válidas do Windows. Não desativar UAC nem criar desvio de autenticação.
- Indicador de sessão e opção de encerrar preservados. Sem biometria facial obrigatória, agente oculto ou instalação silenciosa não autorizada.
- Mesma logo Zyntra, azul/navy, superfícies claras/escuras, ações de conexão em destaque e configurações secundárias.

## Base escolhida

RustDesk **1.5.3**, commit `95cca3f661f635b3cc85c04935fe8d96d8f432ef`.
Submódulo hbb_common fixado pelo upstream em `fae47e024dd83cef6aaecde0aa7d11731df11649`.

- Cliente: https://github.com/rustdesk/rustdesk/tree/1.5.3
- Servidor aberto: https://github.com/rustdesk/rustdesk-server
- Licença integral: [LICENCE](LICENCE), AGPL-3.0. Manter créditos e obrigações de código correspondente ao distribuir e, quando aplicável, oferecer uso pela rede. Antes da distribuição, tornar o código correspondente acessível aos destinatários, incluindo estas modificações e instruções de compilação; um link privado inacessível ao destinatário não basta.
- Alternativa examinada: https://github.com/immense/Remotely (GPL-3.0). O modelo RustDesk aproxima-se mais do uso solicitado por número e senha.

Não foi extraído código do AnyDesk. A instalação local contém AnyDesk 9.8 assinado, com serviço automático; não é uma distribuição de código-fonte.

## Preparação local

O remoto `upstream` preserva a origem. Reutilizar este checkout; não criar outro clone. Os binários internos `rustdesk.exe`/`librustdesk.dll` permanecem com os nomes esperados pelos scripts upstream. A identidade apresentada, namespace de configurações, registro e serviço usam `ZyntraAcesso`; coexistência ainda precisa ser comprovada no Windows.

Os fluxos de compilação upstream foram preservados em `docs/upstream-workflows/` como referência e não são executados automaticamente neste novo produto. O fluxo próprio de conferência visual é manual. Não herdar publicações, cronogramas, segredos ou assinatura do ERP.

Compilação Windows: seguir https://rustdesk.com/docs/en/dev/build/windows/ e o job Windows x64 upstream em `docs/upstream-workflows/flutter-build.yml`. A versão Flutter da interface nativa escolhida é a versão fixada pelo upstream para x64: **3.24.5**. Há dependências MSVC, Rust, LLVM, vcpkg e plugins; conferir o fluxo completo upstream antes de gerar pacote.

Não instalar gigabytes de ferramentas neste computador apenas para uma prévia. Registrar ambiente de compilação disponível e conferir o orçamento do GitHub antes de disparar builds nativos.

## Servidor e publicação

Para uma rede ZyntraAcesso independente é necessário um servidor de identificação/retransmissão sempre disponível, com capacidade e tráfego proporcionais às conexões. O código OSS não exige contratar o RustDesk Pro; hospedagem e tráfego podem ter custo. Não contratar, criar cobrança, abrir portas no computador ou alterar o ERP nesta preparação.

Antes do piloto: escolher hospedagem autorizada; fixar endereço e chave pública; validar conexões entre redes diferentes; revisar atualização assinada, privacidade e entrega de código correspondente. A rede pública padrão do upstream **não é** uma infraestrutura própria ZyntraAcesso e não deve ser anunciada assim.

## Ligar remotamente

Wake-on-LAN depende do hardware/firmware, estado de energia, rede e de um equipamento/roteador capaz de encaminhar o comando na rede remota. Sem energia não é possível ligar por software. Não prometer suporte a notebook totalmente desligado, Wi-Fi ou tampa fechada sem testar o modelo.

## Critérios para disponibilizar a amigos/empresas

- [ ] Build nativo, instalador/desinstalador e assinatura compatível, identidade independente do RustDesk/ERP.
- [ ] Número real + senha correta/incorreta, recusa, revogação e limite de tentativas.
- [ ] Instalação elevada, UAC, bloqueio de tela, reinicialização, início do serviço e acesso sem confirmação opt-in.
- [ ] Permissões reais coincidem com o aviso; transferências, áudio, câmera, gravação e reinício são explícitos.
- [ ] Reconexão entre redes diferentes e internet instável; nenhuma garantia de ausência de quedas.
- [ ] Interface nativa em claro/escuro e janela pequena, teclado e textos longos. Teste de widget não equivale a operação real.
- [ ] Servidor dedicado, chave verificada, backups/recuperação, política de privacidade e fonte correspondente acessível.
- [ ] Distribuição Windows inicial. Android, macOS, iOS e acesso pelo navegador **não estão entregues** por este trabalho.

Atualização: 23/11/2026.
