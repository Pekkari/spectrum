{
  pkgs = import <nixpkgs> {
    overlays = [
 
      (final: super: {
        makeModulesClosure = args: super.makeModulesClosure (args // {
          rootModules = [];
        });
      })

      (final: super: {
        linux_latest = super.pkgs.linuxKernel.manualConfig {
          inherit (super.pkgs) stdenv lib;
          version = "5.15.53-hardened1";
       
          src = super.pkgs.fetchurl {
            url = "https://github.com/anthraxx/linux-hardened/archive/refs/tags/5.15.53-hardened1.tar.gz";
            sha256 = "3157a4cadd167e0892cd4257f778dbe8d00b7ff6300c9c2dafaabb13852fa2fc";
          };
       
          configfile = ./generated_x86_qemu-nixos_host_release_defconfig;
          allowImportFromDerivation = true;
        };
      })
    ];
  };
}
