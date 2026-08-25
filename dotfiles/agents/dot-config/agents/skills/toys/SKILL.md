---
name: toys
description: This skill allows searching guix channels for packages.
allowed-tools: Bash
---

# toys

Search with a package name or keyword in `$NAME`:

```bash
curl -fsS -G https://search.guix.moe/api/packages \
  --data-urlencode "search=$NAME" \
  --data-urlencode page=1 \
  --data-urlencode limit=20 |
  jq -e '.[] | {name, version, channel, module, file, url, synopsis}'
```

For advanced searches use Xapian query syntax:
https://xapian.org/docs/queryparser.html
