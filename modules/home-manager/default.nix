{ lib, config, inputs, ... }: {
  imports = [
    ./git
    ./nvim
    ./zsh
    ./fzf
  ];
}
