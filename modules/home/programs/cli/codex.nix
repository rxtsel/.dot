{...}: {
  flake.modules.homeManager.codex = {pkgs, ...}: {
    programs.codex = {
      enable = true;
      enableMcpIntegration = true;

      package = pkgs.callPackage ./_codex/package.nix {
        runtime = "native";
      };

      settings = {
        tui.theme = "solarized-dark";
      };

      custom-instructions = ''
        ## CODE RULES

        * Inside code blocks: all content must be in English (code, comments, variables, functions, classes, docstrings).
        * Outside code blocks: use my language for explanations.
        * Consider code smells, especially unnecessary or redundant comments.
        * Follow SOLID principles (especially Open/Closed Principle) and DRY when appropriate.
        * Prefer composable components above all.

        ---

        ## WORKFLOW

        * Ask clarifying questions before assuming anything when the context is insufficient or ambiguous.
        * DO NOT GENERATE until questions are answered.
        * Prefer using Context7 agent skill or MCP tools (when available) to verify against official documentation before suggesting code.
        * Before giving me a list of commands, wait for the result of the previous command you suggested, and based on that, suggest the next step. We go step by step.
        * Only use git commands when explicitly requested.
        * Always use conventional commits in English.
        * Ask for permission before making a commit or push.
        * Use caveman agent skill always with full intensity.
      '';

      skills = {
        find-skills = ''
          ---
          name: find-skills
          description: Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabilities. This skill should be used when the user is looking for functionality that might exist as an installable skill.
          ---

          # Find Skills

          This skill helps you discover and install skills from the open agent skills ecosystem.

          ## When to Use This Skill

          Use this skill when the user:

          - Asks "how do I do X" where X might be a common task with an existing skill
          - Says "find a skill for X" or "is there a skill for X"
          - Asks "can you do X" where X is a specialized capability
          - Expresses interest in extending agent capabilities
          - Wants to search for tools, templates, or workflows
          - Mentions they wish they had help with a specific domain (design, testing, deployment, etc.)

          ## What is the Skills CLI?

          The Skills CLI (`npx skills`) is the package manager for the open agent skills ecosystem. Skills are modular packages that extend agent capabilities with specialized knowledge, workflows, and tools.

          **Key commands:**

          - `npx skills find [query]` - Search for skills interactively or by keyword
          - `npx skills add <package>` - Install a skill from GitHub or other sources
          - `npx skills check` - Check for skill updates
          - `npx skills update` - Update all installed skills

          **Browse skills at:** https://skills.sh/

          ## How to Help Users Find Skills

          ### Step 1: Understand What They Need

          When a user asks for help with something, identify:

          1. The domain (e.g., React, testing, design, deployment)
          2. The specific task (e.g., writing tests, creating animations, reviewing PRs)
          3. Whether this is a common enough task that a skill likely exists

          ### Step 2: Check the Leaderboard First

          Before running a CLI search, check the [skills.sh leaderboard](https://skills.sh/) to see if a well-known skill already exists for the domain. The leaderboard ranks skills by total installs, surfacing the most popular and battle-tested options.

          For example, top skills for web development include:
          - `vercel-labs/agent-skills` — React, Next.js, web design (100K+ installs each)
          - `anthropics/skills` — Frontend design, document processing (100K+ installs)

          ### Step 3: Search for Skills

          If the leaderboard doesn't cover the user's need, run the find command:

          ```bash
          npx skills find [query]
          ```

          For example:

          - User asks "how do I make my React app faster?" → `npx skills find react performance`
          - User asks "can you help me with PR reviews?" → `npx skills find pr review`
          - User asks "I need to create a changelog" → `npx skills find changelog`

          ### Step 4: Verify Quality Before Recommending

          **Do not recommend a skill based solely on search results.** Always verify:

          1. **Install count** — Prefer skills with 1K+ installs. Be cautious with anything under 100.
          2. **Source reputation** — Official sources (`vercel-labs`, `anthropics`, `microsoft`) are more trustworthy than unknown authors.
          3. **GitHub stars** — Check the source repository. A skill from a repo with <100 stars should be treated with skepticism.

          ### Step 5: Present Options to the User

          When you find relevant skills, present them to the user with:

          1. The skill name and what it does
          2. The install count and source
          3. The install command they can run
          4. A link to learn more at skills.sh

          Example response:

          ```
          I found a skill that might help! The "react-best-practices" skill provides
          React and Next.js performance optimization guidelines from Vercel Engineering.
          (185K installs)

          To install it:
          npx skills add vercel-labs/agent-skills@react-best-practices

          Learn more: https://skills.sh/vercel-labs/agent-skills/react-best-practices
          ```

          ### Step 6: Offer to Install

          If the user wants to proceed, you can install the skill for them:

          ```bash
          npx skills add <owner/repo@skill> -g -y
          ```

          The `-g` flag installs globally (user-level) and `-y` skips confirmation prompts.

          ## Common Skill Categories

          When searching, consider these common categories:

          | Category        | Example Queries                          |
          | --------------- | ---------------------------------------- |
          | Web Development | react, nextjs, typescript, css, tailwind |
          | Testing         | testing, jest, playwright, e2e           |
          | DevOps          | deploy, docker, kubernetes, ci-cd        |
          | Documentation   | docs, readme, changelog, api-docs        |
          | Code Quality    | review, lint, refactor, best-practices   |
          | Design          | ui, ux, design-system, accessibility     |
          | Productivity    | workflow, automation, git                |

          ## Tips for Effective Searches

          1. **Use specific keywords**: "react testing" is better than just "testing"
          2. **Try alternative terms**: If "deploy" doesn't work, try "deployment" or "ci-cd"
          3. **Check popular sources**: Many skills come from `vercel-labs/agent-skills` or `ComposioHQ/awesome-claude-skills`

          ## When No Skills Are Found

          If no relevant skills exist:

          1. Acknowledge that no existing skill was found
          2. Offer to help with the task directly using your general capabilities
          3. Suggest the user could create their own skill with `npx skills init`

          Example:

          ```
          I searched for skills related to "xyz" but didn't find any matches.
          I can still help you with this task directly! Would you like me to proceed?

          If this is something you do often, you could create your own skill:
          npx skills init my-xyz-skill
          ```
        '';
        caveman = ''
          ---
          name: caveman
          description: >
            Ultra-compressed communication mode. Cuts token usage ~75% by speaking like caveman
            while keeping full technical accuracy. Supports intensity levels: lite, full (default), ultra,
            wenyan-lite, wenyan-full, wenyan-ultra.
            Use when user says "caveman mode", "talk like caveman", "use caveman", "less tokens",
            "be brief", or invokes /caveman. Also auto-triggers when token efficiency is requested.
          ---

          Respond terse like smart caveman. All technical substance stay. Only fluff die.

          ## Persistence

          ACTIVE EVERY RESPONSE. No revert after many turns. No filler drift. Still active if unsure. Off only: "stop caveman" / "normal mode".

          Default: **full**. Switch: `/caveman lite|full|ultra`.

          ## Rules

          Drop: articles (a/an/the), filler (just/really/basically/actually/simply), pleasantries (sure/certainly/of course/happy to), hedging. Fragments OK. Short synonyms (big not extensive, fix not "implement a solution for"). Technical terms exact. Code blocks unchanged. Errors quoted exact.

          Pattern: `[thing] [action] [reason]. [next step].`

          Not: "Sure! I'd be happy to help you with that. The issue you're experiencing is likely caused by..."
          Yes: "Bug in auth middleware. Token expiry check use `<` not `<=`. Fix:"

          ## Intensity

          | Level | What change |
          |-------|------------|
          | **lite** | No filler/hedging. Keep articles + full sentences. Professional but tight |
          | **full** | Drop articles, fragments OK, short synonyms. Classic caveman |
          | **ultra** | Abbreviate (DB/auth/config/req/res/fn/impl), strip conjunctions, arrows for causality (X → Y), one word when one word enough |
          | **wenyan-lite** | Semi-classical. Drop filler/hedging but keep grammar structure, classical register |
          | **wenyan-full** | Maximum classical terseness. Fully 文言文. 80-90% character reduction. Classical sentence patterns, verbs precede objects, subjects often omitted, classical particles (之/乃/為/其) |
          | **wenyan-ultra** | Extreme abbreviation while keeping classical Chinese feel. Maximum compression, ultra terse |

          Example — "Why React component re-render?"
          - lite: "Your component re-renders because you create a new object reference each render. Wrap it in `useMemo`."
          - full: "New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`."
          - ultra: "Inline obj prop → new ref → re-render. `useMemo`."
          - wenyan-lite: "組件頻重繪，以每繪新生對象參照故。以 useMemo 包之。"
          - wenyan-full: "物出新參照，致重繪。useMemo .Wrap之。"
          - wenyan-ultra: "新參照→重繪。useMemo Wrap。"

          Example — "Explain database connection pooling."
          - lite: "Connection pooling reuses open connections instead of creating new ones per request. Avoids repeated handshake overhead."
          - full: "Pool reuse open DB connections. No new connection per request. Skip handshake overhead."
          - ultra: "Pool = reuse DB conn. Skip handshake → fast under load."
          - wenyan-full: "池reuse open connection。不每req新開。skip handshake overhead。"
          - wenyan-ultra: "池reuse conn。skip handshake → fast。"

          ## Auto-Clarity

          Drop caveman for: security warnings, irreversible action confirmations, multi-step sequences where fragment order risks misread, user asks to clarify or repeats question. Resume caveman after clear part done.

          Example — destructive op:
          > **Warning:** This will permanently delete all rows in the `users` table and cannot be undone.
          > ```sql
          > DROP TABLE users;
          > ```
          > Caveman resume. Verify backup exist first.

          ## Boundaries

          Code/commits/PRs: write normal. "stop caveman" or "normal mode": revert. Level persist until changed or session end.
        '';
        context7 = ''
          ---
          name: context7
          description: Retrieve up-to-date documentation for software libraries, frameworks, and components via the Context7 API. This skill should be used when looking up documentation for any programming library or framework, finding code examples for specific APIs or features, verifying correct usage of library functions, or obtaining current information about library APIs that may have changed since training.
          ---

          # Context7

          ## Overview

          This skill enables retrieval of current documentation for software libraries and components by querying the Context7 API via curl. Use it instead of relying on potentially outdated training data.

          ## Workflow

          ### Step 1: Search for the Library

          To find the Context7 library ID, query the search endpoint:

          ```bash
          curl -s "https://context7.com/api/v2/libs/search?libraryName=LIBRARY_NAME&query=TOPIC" | jq '.results[0]'
          ```

          **Parameters:**
          - `libraryName` (required): The library name to search for (e.g., "react", "nextjs", "fastapi", "axios")
          - `query` (required): A description of the topic for relevance ranking

          **Response fields:**
          - `id`: Library identifier for the context endpoint (e.g., `/websites/react_dev_reference`)
          - `title`: Human-readable library name
          - `description`: Brief description of the library
          - `totalSnippets`: Number of documentation snippets available

          ### Step 2: Fetch Documentation

          To retrieve documentation, use the library ID from step 1:

          ```bash
          curl -s "https://context7.com/api/v2/context?libraryId=LIBRARY_ID&query=TOPIC&type=txt"
          ```

          **Parameters:**
          - `libraryId` (required): The library ID from search results
          - `query` (required): The specific topic to retrieve documentation for
          - `type` (optional): Response format - `json` (default) or `txt` (plain text, more readable)

          ## Examples

          ### React hooks documentation

          ```bash
          # Find React library ID
          curl -s "https://context7.com/api/v2/libs/search?libraryName=react&query=hooks" | jq '.results[0].id'
          # Returns: "/websites/react_dev_reference"

          # Fetch useState documentation
          curl -s "https://context7.com/api/v2/context?libraryId=/websites/react_dev_reference&query=useState&type=txt"
          ```

          ### Next.js routing documentation

          ```bash
          # Find Next.js library ID
          curl -s "https://context7.com/api/v2/libs/search?libraryName=nextjs&query=routing" | jq '.results[0].id'

          # Fetch app router documentation
          curl -s "https://context7.com/api/v2/context?libraryId=/vercel/next.js&query=app+router&type=txt"
          ```

          ### FastAPI dependency injection

          ```bash
          # Find FastAPI library ID
          curl -s "https://context7.com/api/v2/libs/search?libraryName=fastapi&query=dependencies" | jq '.results[0].id'

          # Fetch dependency injection documentation
          curl -s "https://context7.com/api/v2/context?libraryId=/fastapi/fastapi&query=dependency+injection&type=txt"
          ```

          ## Tips

          - Use `type=txt` for more readable output
          - Use `jq` to filter and format JSON responses
          - Be specific with the `query` parameter to improve relevance ranking
          - If the first search result is not correct, check additional results in the array
          - URL-encode query parameters containing spaces (use `+` or `%20`)
          - No API key is required for basic usage (rate-limited)
        '';
      };
    };
  };
}
