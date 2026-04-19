## SSH (GitHub)

### Generate a dedicated SSH key for GitHub

```bash
ssh-keygen -t ed25519 -f ~/.ssh/github_ed25519 -C "github"
```

### Add the key to the SSH agent

```bash
ssh-add ~/.ssh/github_ed25519
```

### Upload the **public key** twice in GitHub:

```bash
cat ~/.ssh/github_ed25519.pub
```

Go to:

**GitHub → Settings → SSH and GPG keys → New SSH key**

1. Add it as an **Authentication key** (for `git push` / `git pull`)
2. Add it again as a **Signing key** (for commit verification)
