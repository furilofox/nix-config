# My NixOS Config
My Modular NixOS Config, uses **Flakes** and **Homemanager** on **Latest / Unstable**

CLI Commands using **nh**

# Commands
`nh os switch . --upgrade` Rebuild System and apply Changes (Optional: Upgrade System)

`nh clean` Garbage Collection

`nix flake update` Update System known Version

`nh clean --keep 5 --keep-since 5d` Garbage collection (Optional: Keep x Generations, Keep since x Time)

# Systems
### Pandora
Main Desktop System
- GPU: AMD Radeon RX 9070XT
- CPU: AMD Ryzen 9 5900X
- RAM: 32 GB DRR4

### Promethea
Laptop System for School / Remote Work
- GPU: Integrated Graphics (Meteor Lake-P Intel Arc Graphics)
- CPU: Intel Core Ultra 7 155H
- RAM: 16 GB DDR5