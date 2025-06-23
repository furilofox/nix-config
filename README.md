# My NixOS Config
My Modular NixOS Config, uses **Flakes** and **Homemanager** on **Latest / Unstable**

CLI Commands using **nh**

# Commands
`nh os switch . --upgrade` Rebuild System and apply Changes (Optional: Upgrade System)

`nh clean` Garbage Collection

`nix flake update` Update System known Version

`nh clean --keep 5 --keep-since 5d` Garbage collection (Optional: Keep x Generations, Keep since x Time)