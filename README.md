# Nix Home-Manager setup for Bazzite

## Initial setup

### Allowing changes being made to root directory

Following the instructions I found at [Nix package manager on Fedore Silverblue](https://gist.github.com/queeup/1666bc0a5558464817494037d612f094)
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

```nix
extra-experimental-features = flakes nix-command
```

### Initial Home-Manager Run

```bash
nix run home-manager/master -- init --switch
```

> [!NOTE]
> Don't try to fix the space between _--_ and _init_
