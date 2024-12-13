# Cloud Auth Provider

Configure Authentik using Terragrunt and OpenTofu

## How to use

* Install nix in WSL/Linux/Mac

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

* `nix develop` to install all the configuration
  * If this your first time, then fill the `.env` and `source .env`
  * It install terragrunt with alias `tg` and opentofu with alias `tf`
* To apply all configuration

```bash
cd live/staging
tg run-all plan
```

* If you want to execute only one service, then

```bash
cd live/staging/vision
tg plan
tg apply
```



## Contribute

Please refer to [Contribute](./CONTRIBUTE.md) and [Style Guideline](./STYLE_GUIDE.md) before creating any PR.