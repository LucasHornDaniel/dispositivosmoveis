# iot_farm
Criado como projeto de disciplina de Desenvolvimento De Aplicações Para Dispositivos Móveis do curso de Ciência da Computação da UTFPR-MD.

O repositório contém as pastas: 
- api: esta pasta contém um modelo básico de api, utilizada na máquina localhost para ser consumida pelo aplicativo. O projeto da api foi executado utilizando Visual Studio Community 2017 na versão 15.9.11. Foi incluída nas dependências o pacote MySql.Data na versão 8.0.15, que foi utilizado para realizar a conexão com o MariaDB Server na versão 10.3.13-MariaDB.

- db: esta pasta possui os script de criação do modelo do banco, e um exemplo de script para inserção de dados dos sensores. Obs.: os comandos podem ser executados na aplicação de preferência conectada ao banco.

- app: esta pasta possui os arquivos da pasta lib, e arquivos adicionais como pubspec.yaml que inclui as dependências do projeto. O projeto foi criado no Android Studio na versão 3.4 com o flutter na versão 1.0.0+1. Para executar o projeto, basta criar um novo projeto flutter com o nome "iot_farm", e após a criação do projeto copiar o conteúdo da pasta app para dentro da pasta "iot_farm" do projeto.

Obs.: não foram feitos testes de desempenho que garantam a estabilidade da aplicação.

#Created by Luiz Flávio - vluizflavio@gmail.com
