# One - Projeto de Conclusão de Curso

Este repositório contém o front-end do **One**, um aplicativo desenvolvido em Flutter para promover interação entre alunos, monitores e professores, oferecendo funcionalidades como fóruns de discussão, grupos de estudo, perfis personalizados e monitoria.

## Estrutura do Projeto

O projeto é organizado em quatro fluxos principais:

1. **Fórum** - Página inicial do aplicativo onde os usuários podem visualizar e participar de discussões abertas.

   - Arquivo: [`home.dart`](./lib/screens/home.dart)

2. **Grupos** - Página dedicada à criação e interação em grupos de estudo específicos.

   - Arquivo: [`group.dart`](./lib/screens/group.dart)

3. **Perfil** - Permite ao usuário editar e visualizar suas informações pessoais.

   - Arquivo: [`edit_profile.dart`](./lib/screens/edit_profile.dart)

4. **Monitoria** - Página para acessar e gerenciar sessões de monitoria.
   - Arquivo: [`monitoring.dart`](./lib/screens/monitoring.dart)

## Pré-Requisitos

- **Flutter**: Certifique-se de ter o Flutter instalado e configurado corretamente em sua máquina. Consulte a [documentação oficial do Flutter](https://docs.flutter.dev/get-started/install) para instruções de instalação.

## Como Rodar o Projeto

1.  **Clone o Repositório**

    ```bash
    git clone <URL-do-repositorio>
    ```

Acesse a Branch 'bia':

```bash

 git checkout bia
```

Instale as Dependências: Navegue até o diretório do projeto e instale as dependências do Flutter:

```bash
flutter upgrade
```

```bash
flutter pub get
```

Execute o Projeto: Para iniciar o projeto em um dispositivo emulado ou físico, utilize:

```bash
flutter run
```

Configurações de Backend e Banco de Dados

Banco de Dados: Está hospedado na plataforma Render.
URL: http://teste.com

Backend: A API que o aplicativo consome também está hospedada na Render.

URL do backend: https://back-cyc5.onrender.com/

teste algumas rotas ;))
-> https://back-cyc5.onrender.com/disciplina/all
-> https://back-cyc5.onrender.com/pergunta/all

Considerações Finais

O One foi desenvolvido para facilitar a colaboração na comunidade acadêmica, proporcionando um ambiente organizado para fóruns de discussão, monitoria e grupos de estudo.
