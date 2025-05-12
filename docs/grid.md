<!-- markdownlint-disable MD013 -->
# Environment × Norm Grid — Sprint S-1

| Environment \ Norm | baseline | security | optimised |
|--------------------|----------|----------|-----------|
| **local-docker**   | 🟥 | — | — |
| **sandbox-aws**    | 🟩 (target) | — | — |
| **prod-aws**       | — | — | — |

- 🟩 **target** = in scope for this sprint  
- 🟥 **out of scope** = covered earlier (Phase B smoke)  

---

## Impact × Effort Grid

| Impact \ Effort | Low (≤ 1 h) | Medium (≤ 4 h) | High (> 4 h) |
|-----------------|------------|----------------|--------------|
| **High**        | **T1** Terraform S3 + Glue, **T2** `quick-start.sh` & CI | **T3** Infracost + Budgets | — |
| **Medium**      | **T4** Demo CSV / Athena queries | — | — |
| **Low**         | Docs synchronisation | — | — |
