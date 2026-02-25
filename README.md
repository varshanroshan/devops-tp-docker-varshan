# TP DevSecOps – Docker CI/CD sécurisé

![Build and Scan](https://github.com/varshanroshan/devops-tp-docker-varshan/actions/workflows/docker-deploy.yml/badge.svg)
![CodeQL](https://github.com/varshanroshan/devops-tp-docker-varshan/actions/workflows/codeql-analysis.yml/badge.svg)
![Dependabot](https://img.shields.io/badge/dependabot-enabled-brightgreen)
![GHCR](https://img.shields.io/badge/GHCR-enabled-blue)

---

## 🎯 Objectif

Mettre en place un pipeline **DevSecOps complet** pour sécuriser la construction,  
l’analyse et la publication d’images Docker.

---

## 🔐 Pipeline DevSecOps

Code Push  
↓  
Secret Scanning  
↓  
CodeQL (SAST)  
↓  
Hadolint (Dockerfile)  
↓  
Build Docker Image  
↓  
Trivy (Scan vulnérabilités)  
↓  
Security Gates  
↓  
Push vers GHCR  

---

## 🛡️ Sécurité implémentée

- Secret Scanning activé
- CodeQL (analyse statique du code)
- Hadolint (lint du Dockerfile)
- Trivy (scan des vulnérabilités de l’image)
- Dependabot (mise à jour automatique des dépendances)
- Security Gates (blocage HIGH / CRITICAL)
- Image Docker exécutée en non-root
- SBOM généré automatiquement

---

## 🐳 Image Docker

- Image de base : **nginx alpine**
- Exécution **non-root**
- Permissions minimales
- Healthcheck actif
- Headers HTTP de sécurité
- Image publiée sur **GitHub Container Registry (GHCR)**

---

## 🚀 Lancer l’application

```bash
docker pull ghcr.io/varshanroshan/devops-tp-docker-varshan:latest
docker run -p 8080:80 ghcr.io/varshanroshan/devops-tp-docker-varshan:latest
