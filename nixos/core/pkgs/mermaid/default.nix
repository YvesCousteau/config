{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    nodePackages.mermaid-cli
  ];
}