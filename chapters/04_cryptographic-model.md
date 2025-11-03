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

