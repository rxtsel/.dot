## SSH (GitHub)

### Generate a dedicated SSH key for GitHub

```bash
ssh-keygen -t ed25519 -f ~/.ssh/github_ed25519 -C "github"
```

### Add the key to the SSH agent

```bash
ssh-add ~/.ssh/github_ed25519
```

### Test SSH authentication with GitHub

```bash
ssh -T git@github.com
```

---

### Enable “Verified” commits on GitHub (SSH signing)

Upload the **same public key** twice in GitHub:

```bash
cat ~/.ssh/github_ed25519.pub
```

Go to:

**GitHub → Settings → SSH and GPG keys → New SSH key**

1. Add it as an **Authentication key** (for `git push` / `git pull`)
2. Add it again as a **Signing key** (for commit verification)
