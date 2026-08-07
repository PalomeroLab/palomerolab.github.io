#!/usr/bin/env python3
"""Write data/publications.json from PubMed.

The site renders the publication list at build time. This script refreshes the
data file. A scheduled workflow runs it, see .github/workflows/publications.yml.
Run it by hand to preview a change:

    python3 scripts/fetch-publications.py

The script keeps the file unchanged if PubMed returns no records. A build never
calls PubMed, so a PubMed outage cannot break a deploy.
"""

import json
import pathlib
import sys
import urllib.parse
import urllib.request

TERM = "Palomero T[Author]"
RETMAX = 20
EUTILS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils"
# NCBI asks every caller to identify itself. See
# https://www.ncbi.nlm.nih.gov/books/NBK25497/
CONTACT = {"tool": "palomerolab-site", "email": "rnajac@gmail.com"}
OUT = pathlib.Path(__file__).resolve().parent.parent / "data" / "publications.json"


def get(endpoint, **params):
    query = urllib.parse.urlencode({**CONTACT, **params, "retmode": "json"})
    with urllib.request.urlopen(f"{EUTILS}/{endpoint}.fcgi?{query}", timeout=30) as r:
        return json.load(r)


def doi(record):
    for entry in record.get("articleids", []):
        if entry["idtype"] == "doi":
            return entry["value"]
    return ""


def main():
    uids = get("esearch", db="pubmed", term=TERM, retmax=RETMAX, sort="pub_date")
    uids = uids["esearchresult"]["idlist"]
    if not uids:
        print("no records, keeping the current file", file=sys.stderr)
        return 1

    result = get("esummary", db="pubmed", id=",".join(uids))["result"]
    publications = []
    for uid in result["uids"]:
        record = result[uid]
        publications.append(
            {
                "pmid": uid,
                "title": record["title"].rstrip("."),
                "authors": ", ".join(a["name"] for a in record.get("authors", [])),
                "journal": record.get("fulljournalname", "") or record.get("source", ""),
                "pubdate": record.get("pubdate", ""),
                "year": record.get("sortpubdate", "")[:4],
                "volume": record.get("volume", ""),
                "issue": record.get("issue", ""),
                "pages": record.get("pages", "") or record.get("elocationid", ""),
                "doi": doi(record),
                "url": f"https://pubmed.ncbi.nlm.nih.gov/{uid}/",
            }
        )

    OUT.write_text(json.dumps(publications, indent=2, ensure_ascii=False) + "\n")
    print(f"wrote {len(publications)} records to {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
