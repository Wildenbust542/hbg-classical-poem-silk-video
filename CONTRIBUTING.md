# Contributing

1. Fork the repository and create a focused branch.
2. Keep credentials, generated media, local paths, user chats, and browser profiles outside the repository.
3. Run the local checks:

```bash
python3 tools/validate_skill.py
python3 tools/check_secrets.py
for file in skill/classical-poem-silk-video/scripts/*.sh; do bash -n "$file"; done
python3 -m py_compile skill/classical-poem-silk-video/scripts/*.py
```

4. If a change touches motion prompts, include early, middle, late, and settled-frame evidence.
5. If a change touches media assembly, report resolution, duration, codecs, frame rate, audio behavior, transition timestamps, and final encoded-frame QA.
6. Do not weaken the rule that final MP4 inspection is required before delivery.
