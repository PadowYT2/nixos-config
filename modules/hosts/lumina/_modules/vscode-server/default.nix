{inputs, ...}: {
  imports = [inputs.vscode-server.nixosModules.default];

  services.vscode-server = {
    enable = true;
    enableFHS = true;
    installPath = ["$HOME/.vscode-server" "$HOME/.vscode-server-insiders"];
  };
}
