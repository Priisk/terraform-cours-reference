# Ce que la séance S7 ajoute au dépôt (par rapport à fin-S6)

```
 .github/workflows/terraform-apply.yml        | 128 +++++++++++++++++++++++++++
 .github/workflows/terraform-pr.yml           |  73 +++++++++++++++
 README.md                                    |  78 +++++++++-------
 SECURITE.md                                  |   8 ++
 envs/dev/ci_oidc_compte_classique.tf.exemple |  43 +++++++++
 envs/prod/main.tf                            |  10 ++-
 envs/prod/terraform.tfvars.example           |   1 +
 envs/prod/variables.tf                       |  12 +++
 scripts/ci-secrets.sh                        |   8 ++
 9 files changed, 328 insertions(+), 33 deletions(-)
```

Fichiers écrits ou modifiés par les étudiants pendant le TP :

- ajouté : .github/workflows/terraform-apply.yml
- ajouté : .github/workflows/terraform-pr.yml
- modifié : README.md
- modifié : SECURITE.md
- ajouté : envs/dev/ci_oidc_compte_classique.tf.exemple
- modifié : envs/prod/main.tf
- modifié : envs/prod/terraform.tfvars.example
- modifié : envs/prod/variables.tf
- ajouté : scripts/ci-secrets.sh
