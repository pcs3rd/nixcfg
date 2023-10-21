{
description = "My personal flake.nix";

inputs ={
    # Upstream nixpkgs
    nixpkgs.url = github:NixOS/nixpkgs;
    
    # Home-manager 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Community packages; used for Firefox extensions
    nur.url = "github:nix-community/nur";
    
};
  
  home-manager.url = github:nix-community/home-manager;

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.fnord = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
  };
}
