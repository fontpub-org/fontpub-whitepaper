## 6. Comparison to Existing Systems

To understand Fontpub’s position within the broader ecosystem, it is useful to compare its structure to existing systems for software and content distribution. While Fontpub shares technical DNA with several precedents — such as package managers, web font platforms, and decentralized publishing protocols — its trust model and design philosophy diverge in key ways.

### 6.1 Centralized Font Platforms

Services like **Google Fonts** have transformed how typography is distributed on the web. They provide global accessibility, caching efficiency, and standardization of formats. However, their trust model is *organizational*: authenticity depends on trusting the hosting entity rather than the author.

| Property | Google Fonts | Fontpub |
|-----------|---------------|-----------|
| Hosting | Centralized | Self-hosted |
| Trust Basis | Brand reputation | Cryptographic verification |
| Update Control | Managed by Google | Managed by publishers |
| Provenance | Implicit | Explicit (via signatures) |
| Reproducibility | Limited | Guaranteed |

Google Fonts prioritizes convenience and scalability. Fontpub prioritizes autonomy and verifiability. The two approaches are not mutually exclusive — Fontpub could serve as a *verification layer* even for centrally hosted libraries, enabling users to independently confirm the authenticity of distributed fonts.

### 6.2 Package Managers (npm, PyPI)

Traditional software package registries such as **npm** and **PyPI** offer strong distribution networks, versioning, and dependency management. However, they rely on a *single authoritative index* — a centralized service that determines what packages exist and who can publish them.

Although individual packages may include checksums or signatures, the trust model remains registry-centric. Users ultimately rely on the central service’s reputation and availability.

Fontpub departs from this architecture by removing the registry layer entirely. Each domain becomes its own namespace, and each manifest its own canonical record. Verification happens locally, based on signatures and proofs, not registry trust.

Curations provide usability similar to registries — searchable indexes, tagging, and organization — but they do not possess authority. This decoupling of indexing from verification results in what can be described as a **registryless package manager**: a model that preserves the convenience of discovery while eliminating central control.

### 6.3 Decentralized Publishing Protocols (ActivityPub, Gemini, IPFS)

Fontpub also shares conceptual similarities with decentralized publishing systems.

| Protocol | Primary Purpose | Fontpub’s Relation |
|-----------|------------------|------------------|
| **ActivityPub** | Federated social communication | Fontpub’s curations resemble federated feeds of font publications. |
| **Gemini** | Minimal web protocol for human-readable sites | Shares the simplicity and static nature of Fontpub’s architecture. |
| **IPFS** | Content-addressed peer-to-peer file sharing | Similar immutability through hashes, but Fontpub anchors identity to domains instead of content addresses. |

Unlike IPFS, which ensures immutability through content addressing, Fontpub ensures authenticity through *identity anchoring*. Each release is cryptographically signed by a domain-controlled key, preserving human-readable provenance and long-term verifiability.

### 6.4 What Fontpub Does *Not* Attempt

Fontpub deliberately omits features that would compromise decentralization or introduce governance complexity:

- No global registry or central index.
- No user accounts, authentication, or access control.
- No built-in moderation, rating, or ranking systems.
- No blockchain, timestamp servers, or consensus mechanisms.

These omissions are intentional. Fontpub focuses narrowly on *publication* and *verification*. Social layers (trust networks, reputation systems, economics) can evolve independently around the protocol without being embedded within it.

### 6.5 Summary

| Dimension | Centralized Services | Package Managers | Decentralized Protocols | **Fontpub** |
|------------|----------------------|------------------|-------------------------|--------------|
| Authority | Single organization | Registry operator | Federated peers | Domain owners |
| Verification | Implicit | Optional | Often none | Mandatory, cryptographic |
| Distribution | API-based | Central server | Peer-to-peer | Static HTTP |
| Identity Model | Brand | User accounts | Actor handles | Domain + signature |
| Core Asset | Hosted fonts | Software packages | Posts/media | Font manifests |

Fontpub stands at the intersection of these paradigms: combining the transparency of open-source package management, the autonomy of federated systems, and the accessibility of the web. Rather than replacing existing infrastructures, it adds a *missing cryptographic layer* — the ability to verify authenticity independently, wherever fonts are distributed.

