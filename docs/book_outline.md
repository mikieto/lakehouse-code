# Book Outline (compact version)

> **Small headings** = core claim + hands‑on purpose. Anchors let CI links jump here.
> `{#n}` after a heading indicates which Ten‑Principle(s) that point teaches.

---

## Reading Guide  <a id="reading-guide"></a>

* **Why:** Two Macro‑Shifts
* **What:** Five Pillars of Modern Data
* **How:** Ten Principles Cheat‑Sheet (`docs/ten_principles_cheat_sheet.md`)
* **What:** Tool‑Triad Quick‑Start (Terraform / GitHub WF / Iceberg)
* **Loop:** Org Adoption Canvas

### Hands-on objective

* *(introductory section – no hands‑on)*

### Relevant principles

* Introductory context only

### Hook

* Tool‑Triad visual

### Figures

* Fig 0‑1: Macro‑Shift timeline
* Fig 0‑2: Five‑Pillar wheel
* Fig 0‑3: Tool‑Triad diagram

---

## Ch 1 Evolution  <a id="ch-1-evolution"></a>

* **Why:** Data Gravity & Storage‑First {#1}
* **What:** Tool‑Triad Supports Storage‑First {#1,#4}
* **Loop:** Historical Timeline {#1}

### Hands-on objective

* Understand data‑gravity impact

### Relevant principles

* \#1 Storage‑centric — storage is the new centre of gravity
* \#4 Everything‑as‑Code — declarative infra support

### Hook

* When storage became the new ‘gravity well’—and why compute now orbits it.

### Figures

* Fig 1‑1: Storage‑first evolution chart

---

## Ch 2 Paradigms  <a id="ch-2-paradigms"></a>

* **Why:** “Ops-as-Code” mindset {#4}
* **How:** Demo ⇄ Prod Toggle Concept {#3,#4}
* **Loop:** Early Guard Rails {#5,#8}

### Hands-on objective

* Ops-as-Code demo ⇄ prod toggle

### Relevant principles

* \#3 Metadata‑driven — declarative configs
* \#4 Everything‑as‑Code — infra/pipeline as code
* \#5 Shift‑left CI/Ops — test early
* \#8 Security & Gov‑by‑Design — guard‑rails baked in

### Hook

* Demo ⇄ Prod seed

### Figures

* Fig 2‑1: Toggle workflow
* Fig 2‑2: Guard‑Rails matrix

---

## Ch 3 Strategy & Value  <a id="ch-3-strategy"></a>

* **Why:** FinOps First: Money Talks {#9}
* **Loop:** Security ROI {#8}
* **How:** Live Cost Diff with Infracost {#9}

### Hands-on objective

* FinOps & Sec ROI → infracost diff

### Relevant principles

* \#9 Cost‑awareness & FinOps — spend ≤ value
* \#8 Security & Gov‑by‑Design — risk as ROI loop

### Hook

* FinOps-first

### Figures

* Fig 3‑1: FinOps loop
* Fig 3‑2: Infracost diff screenshot

---

## Ch 4 Landing Zone  <a id="ch-4-landing-zone"></a>

* **How:** 15‑Minute Landing Zone {#4,#5}
* **What:** Built‑in Guard Rails {#8,#5}
* **Loop:** Demo vs Prod Flow {#1,#4}

### Hands-on objective

* Landing Zone up in 15 min (Demo = free / Prod = `PRODUCTION=1`)

### Relevant principles

* \#1 Storage‑centric
* \#4 Everything‑as‑Code
* \#5 Shift‑left CI/Ops
* \#8 Security & Gov‑by‑Design

### Hook

* Guard‑Rails debut

### Figures

* Fig 4‑1: Landing‑Zone stack diagram

---

## Ch 5 Pipeline  <a id="ch-5-pipeline"></a>

* **Why:** Iceberg Tables {#2}
* **How:** Bronze→Silver Pipeline Walkthrough {#2,#5}

### Hands-on objective

* Iceberg Bronze→Silver in 20 min

### Relevant principles

* \#2 Open Table Format — ACID & schema‑evolution
* \#5 Shift‑left CI/Ops — test early

### Hook

* Iceberg’s Bronze → Silver leap: schema-safe in three clicks.

### Figures

* Fig 5‑1: Pipeline flowchart

---

## Ch 6 Governance  <a id="ch-6-governance"></a>

* **What:** End‑to‑End Governance {#3,#8}
* **How:** Catalog & Masking Demo + Great Expectations Quality Gate {#3,#8}
* **Loop:** Incident Drill 4‑Step {#7,#5}

### Hands-on objective

* Catalog + Mask + **GE Quality Gate** + Lineage in 20 min

### Relevant principles

* \#3 Metadata‑driven
* \#7 Observability & Lineage
* \#8 Security & Gov‑by‑Design
* \#5 Shift‑left CI/Ops (incident drill)

### Hook

* Incident Drill

### Figures

* Fig 6‑1: Catalog mask example
* Fig 6‑2: Incident drill timeline

---

## Ch 7 MLOps (Advanced)  <a id="ch-7-mlops-adv"></a>

* **Why:** Continuous ML in the Lakehouse {#6}
* **How:** Train→Endpoint Demo {#10,#6}

### Hands-on objective

* SageMaker train→endpoint 15 min

### Relevant principles

* \#6 Loose Coupling & Event‑driven
* \#10 Serverless‑first

### Hook

* When accuracy drifts, retrain and redeploy in under 15 minutes—zero tickets, zero downtime.

### Figures

* Fig 7‑1: MLOps workflow diagram

---

## Ch 8 DevOps (Advanced)  <a id="ch-8-devops-adv"></a>

* **How:** GitHub‑Native Org Workflow {#4,#5}
* **Loop:** ChatOps Automation {#5,#4}
* **What:** Developer Portal Demo {#4,#5}

### Hands-on objective

* Org WF + ChatOps 15 min

### Relevant principles

* \#4 Everything‑as‑Code
* \#5 Shift‑left CI/Ops
* \#9 Cost‑awareness & FinOps

### Hook

* ChatOps slashes 4 manual clicks—Dev ⇄ SRE on one pull-request.

### Figures

* Fig 8-1: DevOps workflow & Portal

---

## Ch 9 CDC (Advanced)  <a id="ch-9-cdc-adv"></a>

* **Why:** CDC for Analytics {#6}
* **How:** One‑Record CDC Demo {#6,#1}

### Hands-on objective

* CDC→Iceberg 1 record 15 min

### Relevant principles

* \#6 Loose Coupling & Event‑driven
* \#1 Storage‑centric

### Hook

* Ingest each change row in 500 ms, turning your lake into a live mirror.

### Figures

* Fig 9‑1: CDC latency chart

---

## Ch 10 Optimize  <a id="ch-10-optimize"></a>

* **What:** Performance‑Cost Trade‑Off {#9,#7}
* **How:** Iceberg OPTIMIZE Demo {#7,#10}
* **Loop:** FinOps Weekly Loop {#9,#7}

### Hands-on objective

* Iceberg OPTIMIZE & Cost‑Guard in 20 min

### Relevant principles

* \#7 Observability & Lineage
* \#9 Cost‑awareness & FinOps
* \#10 Serverless‑first

### Hook

* FinOps feedback loop

### Figures

* Fig 10‑1: Optimize plan vs cost
* Fig 10‑2: Weekly FinOps loop

---

## Appendix A  <a id="appendix-a"></a>

* **What:** 20‑Check Production Checklist {#4,#8}

### Relevant principles

* \#4 Everything‑as‑Code — reusable IaC snippets
* \#8 Security & Gov‑by‑Design — policy as code

### Hook

* One‑page Go‑Live list

### Figures

* Fig A‑1: 20‑item checklist

---

## Appendix B  <a id="appendix-b"></a>

* **What:** Copy‑&‑Paste Policy Pack {#4,#8}

### Hands-on objective

* *N/A* (reference appendix, no hands-on)

### Relevant principles

* \#4 Everything‑as‑Code — reusable IaC snippets
* \#8 Security & Gov‑by‑Design — policy as code

### Hook

* Ready‑to‑use snippets for quick adoption

### Figures

* Fig B‑1: Policy pack overview
