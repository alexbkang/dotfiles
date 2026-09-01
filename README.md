# dotfiles

Literal config files stowed into `~` with [GNU Stow].

[GNU Stow]: https://www.gnu.org/software/stow/

## Install / re-apply

```bash
cd ~/dotfiles && stow --target=$HOME .
```

That's the equivalent of `stow .` — it works from inside the repo because the
package is the repo root and the target is your home (the *parent* of the repo,
so there's no stow self-collision).

Don't use `stow -d ~ -t ~ dotfiles` from outside the repo — that hits GNU Stow's
"cannot nest a package inside its own target" constraint, because this repo
lives at `~/dotfiles`, a subdirectory of the target `~`.

## Layout (standard single-FHS layout)

```
.zzshrc
.zprofile
.gitconfig
.tmux.conf
.config/bat/config
.config/eza/theme.yml
.config/ghostty/config
.config/lazygit/config.yml
.config/nvim/...
.config/starship/starship.toml
.agents/code-review/...       pi's skills
.pi/agent/settings.json       pi config (tracked)
.pi/agent/themes/...          pi theme (tracked)
```

## `~/.pi` — pi's live runtime directory

`.pi/` in this repo tracks only pi config you want version-controlled:
`agent/settings.json` and `agent/themes/`. Everything else pi owns at runtime
(auth, sessions, models-store, trust) is excluded via `.stowignore` and is
**never touched** by stow.

pi writes `settings.json` through the symlink with a plain `writeFileSync`, so
changes you make inside pi are automatically reflected back into this repo.

To (re)track your **current** live pi settings after changing them in-app:

```bash
cd ~/dotfiles && cp ~/.pi/agent/settings.json .pi/agent/settings.json && git add .pi/agent/settings.json
```
