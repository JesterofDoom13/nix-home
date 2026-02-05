# Nix Home-Manager Setup for Bazzite

## Initial Setup

### Setup Git to Pull Private Repository

#### Setup with SSH Keys

> [!NOTE]
> Use SSH Key setup if you are using your own personal computer.

Setup new keys on new install:

> [!IMPORTANT]
> Check your filenames and email address your adding. They should match what you've created and you should be putting in
> your own email address.

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Then start ssh-agent and add the new keys:

```bash
# Starting ssh-agent
eval "$(ssh-agent -s)"
# Adding newly created keys
ssh-add ~/.ssh/id_ed25519
wl-copy < ~/.ssh/id_ed25519.pub
```

Now add them to your Github [settings](https://github.com/settings/keys)

Test they work with running this exactly as is

```bash
ssh -T git@github.com
```

#### Setup with PAT

> [!NOTE]
> [GitHub PAT Generator](https://github.com/settings/tokens)

Get a token set up so you can pull your repo. Be ready to use the PAT you
generate with the next step.

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

### Initial Home-Manager Run

```bash
nix run home-manager/master -- init --switch
home-manager switch
```

> [!NOTE]
> Don't try to fix the space between _--_ and _init_

### CAC Device setup

#### Initial

You have to enable pcscd. Which home-manager doesn't install, but Bazzite has it installed just not enabled.

```bash
sudo systemctl enable --now pcscd.service
```

#### After Initial Install and Whenever Chrome Forgets

```bash
cac-google-setup
```

## Things to Add in the Future

- [x] First run to pull repository
  - [x] Nix command to run git and pull this repository in one shot
  - [x] Script to make nix.conf in nix config directory
- [x] Start in a fresh install
- [x] Get ghostty running
- [x] Get nixCats-nvim set up
- [ ] Have Zen-browser load all my settings
  - [ ] Bookmarks
  - [ ] Extensions
  - [ ] Spaces
    - [ ] Names
      - [ ] Default
      - [ ] Server
      - [ ] 3D Printing
      - [ ] Messaging
  - [ ] Website pins in each Space.
