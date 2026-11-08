# Converti Moedas

## 1. Identificação

- **Nome do aplicativo:** Converti Moedas
- **Squad:** Equipe Moedas

| Integrante | Matrícula | Contato |
|---|---:|---|
| Ana Carolina Rodrigues de Almeida César Alves | 72500719 | 72500719@aluno.faculdadecotemig.br |
| Mateus Thomas Amorim Domingues | 72400447 | 72400447@aluno.faculdadecotemig.br |
| Paulo Vitor Martins de Castro | 72400218 | 72400218@aluno.faculdadecotemig.br |

## 2. Sobre o projeto

O **Converti Moedas** é um aplicativo Flutter voltado ao público que deseja consultar o histórico da cotação de moedas estrangeiras em relação ao Real brasileiro. O aplicativo disponibiliza as cotações dos últimos sete dias, permitindo acompanhar a variação dos valores nesse período.

O usuário inicia na tela de busca, onde seleciona uma moeda entre as opções disponíveis. Após a validação do formulário, o aplicativo abre a tela de histórico, que apresenta as cotações em uma lista dinâmica. Também é possível consultar os detalhes de cada dia ou visualizar a evolução da cotação em um gráfico de colunas.

Na tela de detalhes, o usuário pode adicionar ou remover a moeda dos favoritos. Essas moedas ficam disponíveis em uma tela própria e são armazenadas localmente para permitir sua recuperação ao abrir o aplicativo novamente.

O fluxo principal é composto por busca → histórico → detalhes, gráfico ou favoritos, com navegação entre as telas por meio do sistema de rotas do Flutter.

## 3. Requisitos atendidos

| Requisito | Situação | Implementação no projeto |
|---|---|---|
| Pelo menos 4 telas com `Navigator.push` e `Navigator.pop` | Atendido | O aplicativo possui rotas para Busca, Lista, Detalhes, Gráfico e Favoritos. As navegações entre telas utilizam `Navigator.push` em [`busca.dart`](lib/screens/busca.dart) e [`lista.dart`](lib/screens/lista.dart). As telas de Lista, Detalhes, Gráfico e Favoritos implementam botões de retorno com `Navigator.pop` em seus componentes de `AppBar`. |
| API REST com `http`, `async/await` e dados reais | Atendido | [`moeda_service.dart`](lib/services/moeda_service.dart) usa o pacote `http`, `async/await` e consulta dados reais da AwesomeAPI. |
| Loading e erro visíveis na UI | Atendido | [`lista.dart`](lib/screens/lista.dart) mostra `CircularProgressIndicator` durante o carregamento, mensagem de erro e botão “Tentar novamente”. [`favoritos.dart`](lib/screens/favoritos.dart) também mostra loading enquanto os favoritos são inicializados. |
| Formulário com `Form` e `validator` | Atendido | [`busca.dart`](lib/screens/busca.dart) utiliza `Form`, `GlobalKey<FormState>` e `validator` para exigir a seleção da moeda. |
| Lista dinâmica com `ListView.builder` | Atendido | [`lista.dart`](lib/screens/lista.dart) monta o histórico com `ListView.builder`; [`favoritos.dart`](lib/screens/favoritos.dart) usa o mesmo recurso para os favoritos. |
| Persistência com `SharedPreferences` após fechar e reabrir o app | Atendido | [`cotacao_provider.dart`](lib/providers/cotacao_provider.dart) lê a chave `favoritos` na inicialização e grava a lista atual no armazenamento local. |
| `Provider` para gerenciamento de estado e integração entre telas, API e armazenamento | Atendido | [`main.dart`](lib/main.dart) registra `CotacaoProvider` com `ChangeNotifierProvider`. O provider centraliza favoritos, carregamento, estado de erro, consulta à API e sincronização com `SharedPreferences`. |
| Aplicativo funcionando sem travamentos durante o fluxo | Em validação | O fluxo foi estruturado com estados separados de carregamento, sucesso, vazio e erro. Requer validação manual contínua em um dispositivo, pois o fluxo de rede depende de disponibilidade e conexão com a API pública. |

## 4. API e dados remotos

- **Provedora:** AwesomeAPI — Economia
- **URL base:** `https://economia.awesomeapi.com.br/json`
- **Endpoint utilizado:** `/daily/{MOEDA}-BRL/7`
- **Exemplo completo:** `https://economia.awesomeapi.com.br/json/daily/USD-BRL/7`
- **Tipo de acesso:** API pública remota.
- **Autenticação:** não é necessária para o endpoint utilizado.
- **Chave ou login de teste:** não se aplica.
- **Dados esperados:** lista de até sete registros com cotação atualizada, máxima, mínima, variação percentual e data.
- **Tratamento de resposta:** o serviço verifica o status HTTP, decodifica o JSON e converte os campos para o modelo `Cotacao`.

## 5. Como executar

### Pré-requisitos

- Flutter SDK instalado.
- Dart SDK compatível com o projeto.
- Ambiente configurado para pelo menos uma das plataformas suportadas pelo projeto.
- Em dispositivo móvel ou emulador, ter Android ou iOS disponível; para desktop, Windows/Linux/macOS; para navegador, Chrome ou Edge.

## Como Usar

1. Clone o repositório:
```bash
git clone https://github.com/MateusThomas7737/converti_moedas.git
```

2. Acesse a pasta do projeto:
```bash
cd converti-moedas
code .
```
3. Instale as dependências do projeto:
```bash
flutter pub get
```

4. Execute a aplicação:
```bash
flutter run
```

### Comandos

Na raiz do projeto, execute:

```bash
flutter pub get
flutter run
```

### Versões e plataformas

- Versão de Flutter identificada neste ambiente: **Flutter 3.47.8 (stable)**.
- Versão de Dart informada pelo mesmo ambiente: **3.13.7**.
- Restrição declarada para o SDK no [`pubspec.yaml`](pubspec.yaml): **Dart ^3.13.2**.
- Versão instalada em outros computadores deve ser registrada por cada desenvolvedor como **pendente de padronização**, caso não corresponda à versão acima.
- Plataformas com configuração no projeto: Android, iOS, web, Windows, Linux e macOS.

### Dependências declaradas

| Pacote | Versão |
|---|---:|
| `cupertino_icons` | ^1.0.8 |
| `http` | ^1.6.0 |
| `provider` | ^6.1.5+1 |
| `fl_chart` | ^1.3.0 |
| `shared_preferences` | ^2.5.6 |
| `flutter_lints` | ^6.0.0 |

O aplicativo também usa os SDKs `flutter` e `flutter_test` fornecidos pela instalação local do Flutter.

## 6. Backend local

**Não se aplica.** O projeto não possui servidor ou backend próprio; os dados são obtidos diretamente da API pública da AwesomeAPI. Não é necessário iniciar banco de dados, servidor, usuário ou senha locais.

## 7. Estrutura do código

### Arquivos principais

- [`main.dart`](lib/main.dart): inicializa o aplicativo, registra o `ChangeNotifierProvider` e define o tema e a tela inicial.
- [`models/cotacao.dart`](lib/models/cotacao.dart): define o modelo `Cotacao` e converte os dados JSON da API, além de formatar as datas exibidas.
- [`providers/cotacao_provider.dart`](lib/providers/cotacao_provider.dart): concentra estados de carregamento, erro, cotações, moeda atual e favoritos; integra API e persistência.
- [`services/moeda_service.dart`](lib/services/moeda_service.dart): realiza a requisição HTTP à API, valida a resposta e devolve a lista ordenada de cotações.

### Telas

- [`screens/busca.dart`](lib/screens/busca.dart): tela inicial com seleção de moeda, formulário e validação.
- [`screens/lista.dart`](lib/screens/lista.dart): exibe o histórico em lista, estados de loading/erro, navegação para gráfico, favoritos e detalhes.
- [`screens/detalhe.dart`](lib/screens/detalhe.dart): mostra os preços da cotação selecionada, máximas, mínimas, variação e ação de favorito.
- [`screens/grafico.dart`](lib/screens/grafico.dart): apresenta o histórico em gráfico de linhas por meio de `fl_chart`.
- [`screens/favoritos.dart`](lib/screens/favoritos.dart): lista as moedas favoritas persistidas e permite removê-las.

## 8. Observações

- Os dados das cotações são obtidos por meio da AwesomeAPI e dependem de conexão com a internet.
- O aplicativo não possui backend próprio, autenticação ou chave de API.
- Os códigos das moedas favoritas são armazenados localmente utilizando SharedPreferences.
- O histórico de cotações é obtido diretamente da API, não sendo armazenado localmente.
- O aplicativo disponibiliza um gráfico de linhas com o histórico dos últimos sete dias.
- Também possui indicadores visuais para representar variações positivas e negativas das cotações.
