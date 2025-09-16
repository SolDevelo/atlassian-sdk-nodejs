# Atlassian Plugin SDK + Node.js 20 on JDK 21

This Docker image is based on **Eclipse Temurin JDK 21** and includes:

- Atlassian Plugin SDK `8.2.8`
- Node.js `20.8.1`
- Maven `3.9.6`
- Basic system tools (`curl`, `git`, `unzip`, `zip`, `wget`, etc.)

It provides a ready-to-use environment for developing and testing Atlassian plugins (e.g., Jira, Confluence) using Node.js and Java 21.

---

## 📦 Included Components

| Component                | Version   |
|---------------------------|------------|
| JDK (Eclipse Temurin)     | 21         |
| Atlassian Plugin SDK      | 8.2.8       |
| Node.js                   | 20.8.1      |
| Maven                     | 3.9.6       |

---

## ⚙️ Build the Image

Make sure you have the `Dockerfile` and the `atlassian-plugin-sdk-8.2.8.tar.gz` archive in the same directory, then run:

```bash
docker build -t atlassian-sdk-node .
```

## ⚙️ Run the Container

Start an interactive container:

```bash
docker run -it --rm -v "$PWD":/usr/src/app atlassian-sdk-node bash
```
