# Fontpub: A Decentralized Protocol for Verifiable Font Distribution

## Abstract

Fontpub is a decentralized protocol for verifiable font distribution on the web. It defines a minimal standard by which type designers and foundries can self-host their releases, sign them cryptographically, and prove domain ownership — without relying on any centralized registry or authority.

At its core, Fontpub defines the *Manifest* — a signed, self-hosted document that binds a font to its publisher and domain through an open proof of domain ownership. *Curations* build on this layer, referencing and organizing verified manifests across the web to enable decentralized discovery. Clients can verify authenticity directly from these sources — with no reliance on any central service or platform.

Fontpub replaces organizational trust with cryptographic trust. It enables fonts to circulate freely across the web while preserving authenticity, integrity, and reproducibility over time. Rather than a service, Fontpub is a shared language — a foundational layer for an open, verifiable ecosystem of digital typography.
## 1. Introduction

Digital typefaces are a fundamental part of visual communication on the web. Yet, despite their ubiquity, the infrastructure by which fonts are distributed and trusted has remained largely centralized. Most users today obtain web fonts through large hosting platforms such as Google Fonts — systems that are efficient and reliable, but whose trust model is organizational rather than cryptographic.

In such a model, authenticity and provenance are guaranteed by the reputation of a central authority. If a font is hosted by Google, users implicitly trust that it is legitimate. However, this approach makes the ecosystem dependent on a small number of intermediaries and obscures the actual origin of a font. Individual designers or foundries cannot independently prove authorship or ownership of their distributions, and users cannot verify whether a downloaded font truly originated from its publisher.

Fontpub introduces an alternative approach: a decentralized, verifiable protocol for font distribution. It defines an open standard by which publishers can self-host their releases, sign them cryptographically, and prove domain ownership — without relying on a centralized registry. Clients can then install and verify these fonts directly, ensuring both authenticity and reproducibility over time.

Unlike traditional web font services, Fontpub separates the concept of *trust* from that of *brand*. Trust is derived from cryptographic signatures and verifiable proofs, not from the authority of a hosting organization. Each font, through its manifest and signed metadata, becomes a self-contained, verifiable publication.

By decentralizing both publication and verification, Fontpub aims to restore the independence of digital typography — allowing type designers to publish autonomously, and users to verify independently, within a shared and open protocol for the web.

## 2. Philosophy

The philosophy behind Fontpub is rooted in the culture of *Libre Fonts*: the belief that typography, as both software and cultural expression, should be accessible, modifiable, and distributable by anyone — not merely for convenience, but to preserve creative freedom.

However, freedom alone is not sufficient. In the digital age, where fonts circulate as downloadable assets, authenticity, integrity, and verifiability are equally essential. A truly open ecosystem must not only allow sharing but also enable participants to prove authorship and trace provenance.

Existing systems typically achieve trust through reputation or centralization. Google Fonts, for example, has been instrumental in democratizing access to type, but its trust model is organizational. Users trust Google as an institution, rather than the individual publishers. This approach scales distribution but weakens the direct link between creator and user. It simplifies consumption while diluting accountability.

Fontpub takes a complementary stance. It does not oppose centralized services like Google Fonts but defines the minimal protocol required for fonts to remain autonomous. Each publisher can declare metadata, sign manifests cryptographically, and prove domain ownership — all without appealing to a central registry. The system operates with the same logic as open web infrastructure: simple, inspectable, and verifiable by anyone.

This shift moves the foundation of trust from institutions to proofs. Instead of believing in a brand, users verify a signature. Instead of a single repository, there can be many *curations* — each offering its own perspective while remaining interoperable under a shared open standard.

Fontpub thus envisions the web of typography as a *network of verifiable publications* — where type designers, foundries, curators, and users participate as equal peers in a decentralized ecosystem. It is not a service but an infrastructure, a shared language that allows independent publication to thrive with the same openness and integrity that define the web itself.

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

## 4. Cryptographic Model

Fontpub’s trust model is cryptographic rather than institutional. Authenticity is not guaranteed by a company or organization, but by verifiable proofs built on public-key signatures and ownership validation. Every published font becomes a cryptographically verifiable statement: “This release was created and signed by the owner of this domain.”

### 4.1 Keys and Identities

Each publisher generates one or more asymmetric key pairs. The private key (`K_sec`) is used to sign manifests, while the public key (`K_pub`) is distributed publicly through `fontpub-keys.json`. These key pairs form the foundation of identity in the Fontpub network.

A single publisher may operate multiple keys for different fonts, or for key rotation and organizational delegation. Clients verify signatures against the current valid keys declared in the publisher’s key metadata.

### 4.2 Signing a Manifest

Each release is defined by its manifest (`fontpub.json`). Before publication, the publisher computes the cryptographic hash of the manifest’s canonical JSON form:

```
H = SHA256(canonical_json(fontpub.json))
```

This hash represents a unique fingerprint of the release metadata. The publisher then signs this hash using its private key:

```
S = SIGN(K_sec, H)
```

The resulting signature `S` is embedded in the manifest. Any client can verify the signature using the corresponding public key from `fontpub-keys.json`:

```
VERIFY(K_pub, H, S) → true
```

If verification passes, the manifest is guaranteed to be unaltered since publication and verifiably signed by the legitimate keyholder.

### 4.3 Domain Ownership Proof

A signature alone cannot prove domain ownership. To ensure the signer legitimately controls the domain that hosts the font, Fontpub uses a simple ownership proof.

The publisher places a plaintext file at a well-known path, typically:

```
https://<domain>/fontpub-proof.txt
```

This file contains the fingerprint (hash) of the public key declared in `fontpub-keys.json`. When verifying, the client retrieves this file and ensures:

1. The file was served from the same domain that the manifest references.
2. The fingerprint matches one of the public keys listed in `fontpub-keys.json`.

This proves that the entity controlling `<domain>` also controls the private key that signed the manifest.

### 4.4 Verification Algorithm

The complete verification sequence can be expressed as:

```go
func Verify(manifest, keys, proof) bool {
    if !VerifySignature(keys.PublicKey, manifest.Hash, manifest.Signature) {
        return false
    }
    if proof.Domain != manifest.Domain {
        return false
    }
    if Hash(keys.PublicKey) != proof.KeyFingerprint {
        return false
    }
    return true
}
```

Verification requires no external registry, timestamp server, or authority. All data is retrieved directly from the publisher’s domain, and the validation process can be cached or re-executed offline.

### 4.5 Properties of the Model

The Fontpub cryptographic model provides five key properties:

- **Authenticity** — Each manifest is signed by a unique key pair, allowing verification of origin.
- **Integrity** — Any modification to the manifest invalidates the signature.
- **Domain Binding** — The publisher’s key is provably tied to a specific web domain.
- **Decentralization** — Verification can be done entirely locally, without contacting a central service.
- **Reproducibility** — Past releases remain independently verifiable, ensuring long-term archival trust.

Together, these properties make Fontpub a *self-verifying publication protocol*. Any participant can publish a font independently, while others can confirm its authenticity without trust in an intermediary.

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

## 8. Conclusion

Fontpub proposes a minimal yet complete protocol for decentralized, verifiable, and reproducible font distribution on the web. It does not seek to replace existing infrastructures but to redefine their foundations. Where current systems rely on institutional trust, Fontpub establishes cryptographic trust; where authority is centralized, Fontpub distributes it to the edges.

By introducing a simple model based on signed manifests and domain proofs, Fontpub enables fonts to exist as **verifiable publications** — self-contained, cryptographically authentic artifacts that can circulate freely while preserving provenance. It restores agency to type designers, allowing them to publish independently from their own domains, and it empowers users to verify authenticity without intermediaries.

This separation of *trust* from *brand* marks a philosophical turning point. Trust no longer depends on who hosts a font, but on the verifiable proofs that attest to its origin. The infrastructure of typography, like that of software, can now become distributed, auditable, and self-sustaining.

Fontpub stands not as a service, but as a **protocol** — a shared language for type distribution rooted in the principles of the open web: independence, transparency, and verification. It extends the ideals of Libre Fonts into the infrastructural layer, ensuring that openness is not just a cultural aspiration but a technical reality.

In the long view, Fontpub’s success will not be measured by how many fonts it hosts, but by how many publishers no longer need hosting. When verification becomes natural and infrastructure becomes invisible, Fontpub’s purpose will have been fulfilled — the web will have gained not just a protocol for fonts, but a foundation for verifiable digital authorship.

