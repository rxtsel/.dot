{inputs, ...}: {
  flake.modules.homeManager.ai = {pkgs, ...}: {
    home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
      pi
    ];

    # Custom Pi extensions
    home.file.".pi/agent/extensions/autocommit.ts".text = ''
      import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

      const prompt = `Create semantic commits from all available changes.

      Rules:
      - Do not make one big commit by default.
      - Group files by purpose.
      - Commit each group separately.
      - Use lowercase commit messages so commitlint passes.
      - Do not guess. Understand every available change before committing.

      Steps:
      1. Inspect repository state with \`git status --short\`, \`git diff --cached\`, \`git diff\`, and \`git ls-files --others --exclude-standard\`.
      2. Detect issue key from branch name with \`git branch --show-current\`. Use clear issue key only; do not invent one.
      3. Group changes semantically: one bug fix, one feature, one refactor, one test update, one docs change, one dependency update, or one config/CI change.
      4. Stage only files or hunks for each group. Use \`git add <file>\` or \`git add -p\`. Do not use \`git add -A\` blindly.
      5. Verify staged diff with \`git diff --cached\` before every commit.
      6. Commit with Conventional Commit format: \`<type>(<scope>): <summary>\`. With issue key: \`<issue-key>: <type>(<scope>): <summary>\`.
      7. Repeat until all intentional changes are committed, or unsafe/ambiguous changes remain unstaged for user decision.
      8. Finish with \`git status --short\`.

      Commit types:
      - feat: new feature
      - fix: bug fix
      - docs: documentation only
      - style: formatting only, no logic change
      - refactor: code change without behavior change
      - perf: performance improvement
      - test: tests added or updated
      - build: build system or dependencies
      - ci: CI/CD changes
      - chore: maintenance
      - revert: revert previous commit

      Message rules:
      - Max 72 characters.
      - Imperative mood: add, fix, update, remove.
      - Lowercase type and scope.
      - Lowercase summary unless proper noun requires otherwise.
      - No period at end.
      - Specific purpose, not file name.
      - No vague words: changes, stuff, misc, wip.

      Never commit secrets, .env values, API keys, tokens, credentials, debug logs, local editor files, temporary files, build artifacts unless tracked intentionally, or unrelated experiments.

      Report minimal summary: commits created, files intentionally left uncommitted, anything skipped for safety.`;

      export default function (pi: ExtensionAPI) {
        pi.registerCommand("autocommit", {
          description: "Create semantic commits from all available changes",
          handler: async (_args, ctx) => {
            if (!ctx.isIdle()) {
              pi.sendUserMessage(prompt, { deliverAs: "followUp" });
              ctx.ui.notify("Autocommit queued", "info");
              return;
            }

            pi.sendUserMessage(prompt);
          },
        });
      }
    '';
  };
}
