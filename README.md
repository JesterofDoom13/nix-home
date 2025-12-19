# Nix Home-Manager Setup for Bazzite

## Initial Setup

### Allowing Changes Being Made to Root Directory

Following the instructions I found at [Nix package manager on Fedora Silverblue](https://gist.github.com/queeup/1666bc0a5558464817494037d612f094)
I went with the root.transient method:

```bash
sudo tee /etc/ostree/prepare-root.conf <<'EOL'
[composefs]
enabled = yes
[root]
transient = true
EOL

rpm-ostree initramfs-etc --reboot --track=/etc/ostree/prepare-root.conf
```

### Determinate Nix Install

Then after the reboot I installed Nix:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \

    sh -s -- install ostree --no-confirm --persistence=/var/lib/nix
```

### Fixing SUDO

Last tip from that page is to fix sudo which I didn't even question and just
did:

```bash
echo "Defaults  secure_path = /nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:$(sudo printenv PATH)" | sudo tee /etc/sudoers.d/nix-sudo-env
```

### Adding Flakes Features

Pull this repository into ~/.config/home-manager/ and add a nix.conf in
~/.config/nix/ with this inside:

```bash
git clone git@github.com:JesterofDoom13/nix-home.git ~/.config/home-manager/
mkdir -p ~/.config/nix/
echo "extra-experimental-features = flakes nix-command" > ~/.config/nix/nix.conf
```

### Setup git to pull private repository

> [!NOTE]
> [Github PAT Generator](https://github.com/settings/tokens)

Get a token set up so you can pull your repo. Be ready to use the PAT you generate with the next step.

### Initial Home-Manager Run

```bash
# Don't think you need this but keep it around as a troubleshoot.
# nix run "https://flakehub.com/f/DeterminateSystems/fh/*" -- init
nix run home-manager/master -- init --switch
home-manager switch
```

> [!NOTE]
> Don't try to fix the space between _--_ and _init_

## Things to Add in the Future

- [x] First run to pull repository
  - [x] nix command to run git and pull this repository in one shot
  - [x] Script to make nix.conf in nix config directory
- [x] Start in a fresh install
- [x] Get ghostty running
- [x] Get nixCats-nvim set up
