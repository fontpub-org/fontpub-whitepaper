## 1. Introduction

Digital typefaces are a fundamental part of visual communication on the web. Yet, despite their ubiquity, the infrastructure by which fonts are distributed and trusted has remained largely centralized. Most users today obtain web fonts through large hosting platforms such as Google Fonts — systems that are efficient and reliable, but whose trust model is organizational rather than cryptographic.

In such a model, authenticity and provenance are guaranteed by the reputation of a central authority. If a font is hosted by Google, users implicitly trust that it is legitimate. However, this approach makes the ecosystem dependent on a small number of intermediaries and obscures the actual origin of a font. Individual designers or foundries cannot independently prove authorship or ownership of their distributions, and users cannot verify whether a downloaded font truly originated from its publisher.

Fontpub introduces an alternative approach: a decentralized, verifiable protocol for font distribution. It defines an open standard by which publishers can self-host their releases, sign them cryptographically, and prove domain ownership — without relying on a centralized registry. Clients can then install and verify these fonts directly, ensuring both authenticity and reproducibility over time.

Unlike traditional web font services, Fontpub separates the concept of *trust* from that of *brand*. Trust is derived from cryptographic signatures and verifiable proofs, not from the authority of a hosting organization. Each font, through its manifest and signed metadata, becomes a self-contained, verifiable publication.

By decentralizing both publication and verification, Fontpub aims to restore the independence of digital typography — allowing type designers to publish autonomously, and users to verify independently, within a shared and open protocol for the web.

