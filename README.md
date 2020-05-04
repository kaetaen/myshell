# My Shell
> _"Com organização e tempo, acha-se o segredo de fazer tudo e bem feito."_
<br> — Pitágoras

<!-- img -->
<p align="center">
  <img src="https://media.giphy.com/media/zOvBKUUEERdNm/source.gif" align="center" width="600" height="400"/>
</p>
<!-- Img -->

## Descrição

Esses são os meus principais arquivos de configuração do meu ambiente de desenvolvimento, sendo alguns deles responsáveis pelo shell no desktop linux, shell do mobile (termux) e pelo editor de texto neovim.

## Bash 💻
  ### Principais features
  * Interoperabilidade entre mobile e desktop.
  * Aliases dedicados ao git e diversos interpretradores: lua, python, node e etc.
  ### Requisitos
  * Basta linkar ou copiar o bashrc para diretório $HOME e pronto, seja feliz 😊.
  ### Notas
  * Alguns aliases são associados a softwares do desktop, logo não irão funcionar no mobile. 

## Termux 📱
  ### Principais features
  * Atalhos personalizados para navegação, criação e nomeação de abas
  * Tema e fonte inclusos
  ### Requisitos
  * Ter o termux instalado no smartphone 😜

## Neovim 📝
  ### Principais features
  * Autocomplete com deoplete
  * Code runner personalizado
  * Suporte aprimorado para Lua, Ruby, Javascript e Python
  ### Requisitos
  * Neovim +0.3.0v (caso esteja no desktop, instale os pacotes python recomendados na página de instrução de instalação do neovim)
  * Python +3.6v
  * NodeJS +12.0v
  * Ter um compilador C instalado, tanto no mobile como no desktop. Recomendo o clang.
  ### Notas
  Para habilitar o suporte aprimorado no Python é necessário a instalação de alguns pacotes adicionais.
  
  ```
  pip3 install pynvim neovim jedi --user
  ```
  O mesmo vale para o JavaScript
  ```
  npm install tern standard --global
  ```
