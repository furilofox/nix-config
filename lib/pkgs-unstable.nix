# Helper function to use unstable packages easily
# Usage: pkgsUnstable.pkg [ package1 package2 ... ]
pkgs: pkgs-unstable:

rec {
  # Get a single package from unstable
  pkg = name: pkgs-unstable.${name};
  
  # Get multiple packages from unstable
  pkgs = names: builtins.map (name: pkg name) names;
}