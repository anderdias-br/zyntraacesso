# ZyntraAcesso — instalador do piloto pessoal

Estado: compilação em andamento; não confundir com entrega concluída.

## Escopo atual autorizado

Piloto para um operador e dois notebooks: controlar o notebook de casa a partir do notebook da empresa para usar o Codex. Produto independente; ERP, contas, assinaturas e servidores atuais preservados. O mesmo pacote Windows x64 deve atender as duas máquinas.

Em 23/11/2026, Alexandre autorizou expressamente tornar público **somente** o repositório ZyntraAcesso para usar a compilação gratuita de projetos públicos. A alteração foi aplicada em https://github.com/anderdias-br/zyntraacesso e confirmado que `anderdias-br/zyntra` continua privado. Não havia certificados, `.env`, chaves de assinatura nem secrets no novo repositório.

O proprietário vai criar a conta gratuita Oracle Cloud. Sem acesso/servidor fornecido até agora. Não foi criado recurso pago, alterado limite de cobrança, instalado agente nem aberto firewall neste computador. O servidor público do RustDesk é somente para demonstração/testes; não usar para o trabalho real do Codex ou dados empresariais.

## Verificações e versão

- Descoberta do workflow corrigida ao definir `main` como branch padrão do produto; o branch `codex/zyntraacesso` permanece para desenvolvimento.
- Tentativa privada 45175816585: job não iniciou por orçamento Actions. Não houve compilação nem teste nessa tentativa.
- Repositório público: interface **3 testes aprovados** na execução [45176344516](https://github.com/anderdias-br/zyntraacesso/actions/runs/45176344516): claro/escuro e ação de configurações; janela estreita sem overflow; aviso de capacidades/administração. Isso não equivale a validação nativa completa.
- Instalador beta1 em compilação na execução [45176350143](https://github.com/anderdias-br/zyntraacesso/actions/runs/45176350143), fonte `286f2df`. Não afirmar que arquivo existe até concluir a execução e conferir o artefato.
- Flutter Windows x64 3.24.5 e engine upstream `windows-x64-release.zip` obtido para conferência local: SHA256 `EC8CABF36EE4FF24C8D98DE25B00E70781EB03876265AEE84D0FE554A110036E` (63.301.215 bytes). A conferência foi adicionada ao workflow para compilações seguintes; a execução inicial segue o download oficial upstream da fonte indicada.
- Credenciais/UAC/transporte/captura/entrada/arquivos preservam o motor nativo. Sem senha universal, sem biometria facial obrigatória e sem desativar proteções do Windows.

## Próximos critérios de entrega

1. Acompanhar a execução nativa, corrigir falhas comprovadas, baixar o instalador concluído e conferir hash/tamanho/versão/conteúdo do pacote.
2. Registrar separadamente renderização nativa, instalação/serviço, senha correta/incorreta, recusa e elevação. O teste entre redes depende do segundo computador e do servidor configurado.
3. Entregar ao proprietário o executável real e instruções curtas. Assinatura de distribuição ZyntraAcesso não foi contratada/configurada; não utilizar certificado do ERP.
4. Com a conta Oracle pronta: inspecionar ambiente e capacidade gratuita, preparar servidor/chave e recuperação, configurar ambos os clientes e validar a conexão antes de considerar pronto para uso real do Codex.

## Retenção

Um checkout reutilizado, sem ferramentas nativas grandes instaladas localmente. Um ZIP temporário de engine em `zyntra-work` para conferência; remover o alvo exato após registrar o hash. Nenhum servidor de prévia ou navegador de teste iniciado nesta etapa até o registro.
