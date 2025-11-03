## 5. Distribution Mechanism

Fontpub defines not only how fonts are signed and verified, but also how they are *discovered* and *distributed* without central registries or APIs. The protocol relies entirely on static, signed JSON documents hosted across independent domains, forming a decentralized discovery network.

### 5.1 Principles of Distribution

The Fontpub distribution layer is guided by three core principles:

1. **Self-hosting** — Publishers serve their own manifests and proofs directly from their domains.
2. **Verifiable Discovery** — Every discovered package must be cryptographically verifiable to its source.
3. **Distributed Indexing** — Discovery is aided by curators, not centralized directories.

This approach ensures that the control of distribution remains entirely with the publisher, while discoverability and usability can improve through collaboration between independent curators.

### 5.2 The Role of Curation

A *curation* is a public index of recommended or verified font packages. It is defined by a simple machine-readable JSON file, `fontpub-curation.json`, which maps `packageId` values to their corresponding `manifestUrl`s. Optionally, it may include metadata such as tags, descriptions, or version preferences.

Curations do not override verification; they simply improve discoverability. Every manifest referenced by a curation must still pass cryptographic verification. This ensures that curations act as distributed directories — not authorities.

In this model, anyone can run a curation service. Some may specialize in libre fonts, others in corporate typefaces, others in academic or experimental work. The ecosystem can thus grow organically, without requiring consensus or centralized governance.

### 5.3 Distributed Discovery

When a user installs a font via `fontpub install <packageId>`, the client resolves the ID through one of several possible sources:

1. A known curation file that lists the package ID.
2. A local cache or lockfile that tracks previously installed fonts.
3. A direct URL provided by the user.

Once resolved, the client downloads the manifest from the publisher’s domain and verifies it according to the cryptographic model (Chapter 4). Each curation effectively functions as a *federated registry* — distributed, trustless, and transparent.

Multiple curations can coexist, overlap, or even reference one another, forming a **federated discovery network**. A curator may include entries from another curator, creating a recursive, mesh-like graph of recommendations. Through this mechanism, Fontpub achieves decentralized discoverability similar to federated social networks, but for fonts.

### 5.4 Updates and Reproducibility

Each manifest (`fontpub.json`) contains a `version` field and can declare the date and hash of its release. Clients can compare these versions to detect updates. When a new version is found, the client re-verifies the manifest, checks for key consistency, and updates its `fontpub.lock` file.

This design guarantees reproducibility: a user can always reproduce a previous installation state by referring to the lockfile, which lists exact manifest URLs, hashes, and signatures.

Curations can also provide metadata to guide updates — for example, marking a version as deprecated or unstable. This makes it possible for the community to coordinate evolution without enforcing centralized policies.

### 5.5 Design Rationale

Fontpub intentionally avoids APIs, dynamic databases, and mutable state. Instead, it embraces the web’s native infrastructure — static files served over HTTP, verified through signatures, and linked through URLs. This design offers several practical advantages:

- **Persistence** — Data can be easily archived, mirrored, and cached.
- **Transparency** — Every component (manifest, keys, proof, curation) is human-readable and inspectable.
- **Interoperability** — Any client or server can participate without registration or permission.
- **Resilience** — The ecosystem continues to function even if some curators or publishers go offline.

In essence, Fontpub treats the web itself as the distribution medium. HTTP becomes the protocol, JSON the format, and cryptographic signatures the mechanism of trust. Through this minimalist architecture, Fontpub achieves decentralized discovery, verifiable delivery, and reproducible publication — all without a single point of failure or control.

