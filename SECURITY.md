# Security policy

## Never include credentials in issues or pull requests

Do not upload Gemini cookies, API keys, `.env` files, Chrome profiles, Docker volume exports, generated account data, private poems, private chat transcripts, or local media.

The skill only needs to know whether `/data/auth/gemini/cookies.json` exists inside the configured runtime. It must never print or inspect cookie values.

## Reporting a vulnerability

Open a GitHub security advisory for credential exposure, unsafe path handling, command injection, or installer problems. For ordinary bugs without sensitive data, use a normal Issue with a minimal redacted reproduction.
