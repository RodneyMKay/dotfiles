inputs: { lib, config, ... }: {
  imports = [
    ./git
    (import ./nvim inputs)
  ];
}
