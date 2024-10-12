## Inspirations

- [RockWolf's Dotfiles](https://codeberg.org/RockWolf/dotfiles)
- [Jake Hamilton's Snowfall Lib](https://github.com/snowfallorg/lib)

## Building

Just so I don't forget:

```
sudo nixos-rebuild switch --option eval-cache false --show-trace --flake .
```

## Useful bits of Nix Knowledge:

Debugging configuration accross modules with `nix-repl` and `evalModules`.
Also noteworthy is that the default behavior for option lists is to 
append entries instead of overwriting the list.

```
➜ nix repl '<nixpkgs/lib>'
Welcome to Nix version 2.3pre6895_84de821. Type :? for help.

Loading '<nixpkgs/lib>'...
Added 361 variables.

nix-repl> m1 = { options.foo = mkOption{}; }

nix-repl> m2 = { foo = [ "hello" ]; }

nix-repl> m3 = { foo = [ "world" ]; }

nix-repl> (evalModules { modules = [ m1 m2 m3 ]; }).config.foo
[ "world" "hello" ]

nix-repl> (evalModules { modules = [ m1 m3 m2 ]; }).config.foo 
[ "hello" "world" ]
```

