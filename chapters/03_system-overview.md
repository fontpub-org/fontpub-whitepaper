## 3. System Overview

Fontpub defines a decentralized architecture for publishing, discovering, and verifying fonts on the web. It specifies how four small, interoperable files — `fontpub.json`, `fontpub-keys.json`, `fontpub-proof.txt`, and `fontpub-curation.json` — interact to form a verifiable network of font publications.

At its core, Fontpub introduces three primary actors:

- **Publisher** — a font author or foundry that releases fonts under its own domain.
- **Client** — a software tool that installs and verifies fonts according to the Fontpub protocol.
- **Curator** — an independent entity that aggregates or recommends fonts, improving discoverability.

Each font publication is defined by a signed *manifest* (`fontpub.json`) hosted by the publisher. The client fetches this manifest, validates its signature using the publisher’s public key (`fontpub-keys.json`), and confirms that the key truly belongs to the domain through a lightweight ownership proof (`fontpub-proof.txt`). This verification process requires no central authority — all information necessary for validation is available directly from the publisher’s domain.

### 3.1 The Core Files

#### `fontpub.json` — The Manifest
The manifest serves as the canonical record of a font release. It includes metadata such as the font name, version, license, download URLs, and a digital signature. This file provides a verifiable snapshot of a release state.

#### `fontpub-keys.json` — The Publisher Key Metadata
This file lists the publisher’s public key(s), algorithm, and creation date. Multiple keys may be listed for key rotation or collaborative publishing. It forms the verification base for all signed manifests.

#### `fontpub-proof.txt` — Domain Ownership Proof
A plaintext file hosted under the publisher’s domain (e.g., `https://example.com/fontpub-proof.txt`) that contains the fingerprint of the public key in `fontpub-keys.json`. This demonstrates that the entity controlling the domain also controls the signing key.

#### `fontpub-curation.json` — Distributed Discovery
A table mapping `packageId` values to manifest URLs, optionally including metadata such as tags or descriptions. This enables distributed discovery while maintaining verifiability.

### 3.2 System Flow

When a client installs a font using `fontpub install <packageId>`, the process unfolds as follows:

1. Resolve the package ID to a manifest URL, using a curation file or direct input.
2. Fetch the manifest (`fontpub.json`) from the publisher’s domain.
3. Fetch and validate the publisher key file (`fontpub-keys.json`).
4. Fetch and verify the ownership proof (`fontpub-proof.txt`) to confirm domain-key binding.
5. Verify the manifest’s signature using the key from `fontpub-keys.json`.
6. Download the font files and record results in `fontpub.lock` for reproducibility.

At completion, the client has an authenticated, reproducible font installation verified end-to-end without relying on any intermediary.

### 3.3 Architectural Summary

Fontpub’s design is intentionally minimal: **no servers, no APIs, and no central registry**, yet it provides strong authenticity guarantees. Each domain acts as its own registry, and every font release is its own source of truth.

By relying on simple, static files and standard web formats and modern cryptographic primitives (HTTP, JSON, and Ed25519), Fontpub ensures long-term interoperability, transparency, and resilience. It transforms the web itself into the distribution medium, using open standards as the substrate for verifiable publication.

