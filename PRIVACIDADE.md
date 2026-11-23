# ZyntraAcesso — informações do piloto

Versão de desenvolvimento, 23/11/2026. O piloto inicial é destinado ao proprietário, para testar a conexão entre dois computadores. Não há servidor público próprio ZyntraAcesso em operação neste estágio.

O aplicativo é independente do ERP Zyntra: não utiliza suas contas, seu banco de dados nem seus certificados. Usa o motor aberto RustDesk 1.5.3 para captura da tela, entrada, autenticação e transporte.

## Dados usados na conexão

O motor processa o número de conexão, endereços de rede e informações técnicas necessárias para localizar os dispositivos e negociar a sessão. O servidor configurado pode receber esses dados e manter registros técnicos conforme sua própria configuração e política. Um servidor público de terceiros não é um servidor administrado pelo Zyntra.

Após autorização, a pessoa conectada pode acessar os recursos permitidos no equipamento: tela, mouse/teclado, arquivos, área de transferência, áudio e outras capacidades habilitadas. Elevação de administrador depende do consentimento ou das permissões válidas do Windows. O operador pode encerrar a conexão e alterar as permissões suportadas.

A senha permanente é opcional e configurada no equipamento que será acessado, pelos controles do motor. Não existe senha universal ZyntraAcesso e conhecer o número não substitui a autenticação. Credenciais ou documentos não devem ser enviados por issues públicas deste repositório.

O motor pode manter configurações, histórico de conexões e logs locais em seu perfil de aplicativo. Não apagar o perfil manualmente enquanto houver serviço em uso; usar as configurações e a desinstalação do produto.

## Limites do piloto

O transporte/autenticação preservam a implementação upstream. Isso não constitui homologação de todas as opções: a versão e o servidor selecionados precisam ser testados antes de trabalho real. A rede pública do RustDesk é destinada a demonstração/testes; não deve ser usada neste piloto para dados empresariais ou sessões de trabalho sensíveis. Para usar o Codex e documentos reais, concluir a configuração do servidor próprio e validar a conexão.

## Código e contato

Código correspondente e instruções: https://github.com/anderdias-br/zyntraacesso.
Licença e atribuição: [LICENCE](LICENCE) e [ZYNTRAACESSO.md](ZYNTRAACESSO.md).
Contato: os canais comerciais oficiais em https://zyntrasistemas.com.br.
