## 7. Limitations and Future Work

Fontpub defines a minimal yet complete protocol for decentralized and verifiable font distribution. Its strength lies in simplicity — no servers, accounts, or APIs — but that minimalism also implies certain boundaries. Some are deliberate design choices, while others represent potential areas for future expansion.

### 7.1 Intended Minimalism

Fontpub deliberately restricts its scope to **publication** and **verification**. It does not address the social, economic, or governance layers that often accompany networked systems. This restraint ensures that the protocol remains lightweight, stable, and universally implementable.

Specifically, Fontpub does **not** include:

- A global registry or discovery API.
- User identity or account management.
- Curation-level conflict resolution.
- Built-in moderation or content governance.
- On-chain timestamping or immutable blockchain logs.

These omissions are design decisions, not shortcomings. Fontpub is **infrastructure**, not an application. It defines a minimal substrate upon which diverse systems — archives, registries, educational tools, and design platforms — can be built.

### 7.2 Practical Limitations

While the protocol is theoretically complete, several practical challenges remain:

- **Key management** — Publishers must securely handle cryptographic keys, which may be non-trivial for casual users.
- **Revocation** — There is no standardized mechanism to revoke keys or proofs if compromised.
- **Discovery UX** — Curation remains a technical concept; user-friendly interfaces will need to be developed.
- **Adoption barrier** — Fontpub introduces mental models distinct from centralized workflows, requiring education and tooling.

These issues do not require protocol changes. Instead, they can be addressed through tooling, conventions, and community-driven best practices.

### 7.3 Possible Extensions

Although Fontpub’s minimal core is complete, extensions can enhance its usability, resilience, and transparency without breaking compatibility:

- **Key Revocation Lists (KRLs)** — Standardized JSON formats for publishing revoked keys or proofs.
- **Transparency Logs** — Append-only records of manifests and proofs for independent auditing.
- **Federated Curation Feeds** — Mechanisms for curations to reference and synchronize with one another, forming verifiable discovery graphs.
- **Reproducible Build Metadata** — Inclusion of source commit hashes or build toolchain data within manifests.
- **Font Relationship Graphs** — Optional schema to describe derivations, variants, or dependencies among fonts.

Each extension would strengthen reliability and reproducibility while keeping the trust model intact.

### 7.4 Philosophical Boundary

Fontpub’s ultimate goal is not to control distribution, but to **make control unnecessary**. By embedding verification at the protocol level, it transfers responsibility for authenticity from institutions to individuals. This represents a fundamental shift in how digital authorship is maintained.

Fontpub is less about *what fonts people use* and more about *how they know what they’re using*. Its minimalism is not a limitation, but a stance — that openness and verification, once established in the infrastructure itself, can sustain trust without intermediaries.

### 7.5 Outlook

Fontpub should be regarded as a foundation — a layer enabling higher-level systems rather than competing with them. Potential applications include:

- Decentralized font registries or mirrors.
- Verified archives of historical font releases.
- Educational platforms for type design and licensing literacy.
- Provenance tracing and license validation tools.

As adoption grows, the web of fonts may evolve into a **verifiable ecosystem**, where authenticity and accessibility coexist by design. Fontpub’s next stage is not expansion, but adoption — the gradual replacement of *trust-by-brand* with **trust-by-proof**.

