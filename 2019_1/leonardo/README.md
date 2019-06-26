# serviceOrderProject

A proposta da aplicação é facilitar a comunicação entre cliente e empresas de manutenção de aparelhos eletrônicos.
O aplicativo permite a empresa comunicar seus clientes por meio do aplicativo e de um e-mail automatico qual é o estado em que o produto se encontra, se o aparelho está em análise, manutenção, aguardando a aprovação do cliente para realizar a manutenção ou se está pronto. Além disso a aplicação exibe os itens que serão necessários para realizar o reparo do defeito e o custo que esta manutenção terá.


**Instalação do NodeJS e do NPM**
- Acesse https://nodejs.org;
- Instale o NodeJS comforme instruçoes.

**Instalação do MySQL ou MariaDB**
- Acesse https://www.mysql.com/ para o MySQL ou https://mariadb.org/ para o MariaDB;
- Instale a base de dados de sua preferencia comforme instruçoes no site.

**Instalação da API**
- Clone do projeto -> git clone https://github.com/LSacoman/ServiceOrder;
- Entre na pasta API;
- Instalação das dependencias:
    Dentro da pasta do projeto abra o terminal e execute 'npm install'.

**Configuração da API**
- Dentro do arquivo config/config.js;
- No arquivo config.js é possivel alterar as variaveis de ambiente da API;
- Altere-as para que fiquem adequadas ao seu  ambiente.

**Configurando o envio de emails**
- Crie uma conta no SendGrid;
- Dentro do arquivo controllers/serviceOrder.controller.js;
- Altere o conteudo da api_key do sendgrid para uma Key valida.

**Execução da API**
- Inicie o MySQL ou o MariaDB;
- Dentro da pasta do projeto execute 'npm run start' para iniciar a API.


**Instalação do Flutter**
- Acesse https://flutter.dev/;
- Instale o Flutter comforme instruções no site oficial;
- Para verificar se esta tudo funcionando corretamente execute 'flutter doctor' na linha de comando.


**Instalaçao do projeto**
- Clone do projeto 'git clone https://github.com/LSacoman/ServiceOrder'
- O aplicativo se encontra dentro da pasta 'Aplicativo';

**Configuração do projeto**
- Abra o projeto com o Android Studio;
- Navegue até o arquivo 'pubspec.yaml';
- Na parte superior da janela ira aparecer um snackbar clique em 'Packages get';
- Dentro de 'lib/Data/shared_prefs.dart' altere a 'baseurl' para a URL ou o IP de sua API.

**Execução do projeto**
- Com a base de dados e a API executando aperte 'shift + F10' na janela do Android Studio.



**Criado por: Leonardo Sacoman - leonardodentz@hotmail.com**
 
