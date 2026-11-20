# Ce que la séance S2 ajoute au dépôt (par rapport à fin-S1)

```
 terraform/inventory.tftpl                 |  3 ++
 terraform/main.tf                         | 66 ++++++++++++++-----------------
 terraform/modules/ec2-server/.gitignore   |  2 +
 terraform/modules/ec2-server/main.tf      | 48 ++++++++++++++++++++++
 terraform/modules/ec2-server/outputs.tf   | 11 ++++++
 terraform/modules/ec2-server/variables.tf | 38 ++++++++++++++++++
 terraform/modules/ec2-server/versions.tf  | 10 +++++
 terraform/outputs.tf                      | 13 +++---
 8 files changed, 149 insertions(+), 42 deletions(-)
```

Fichiers écrits ou modifiés par les étudiants pendant le TP :

- modifié : terraform/inventory.tftpl
- modifié : terraform/main.tf
- ajouté : terraform/modules/ec2-server/.gitignore
- ajouté : terraform/modules/ec2-server/main.tf
- ajouté : terraform/modules/ec2-server/outputs.tf
- ajouté : terraform/modules/ec2-server/variables.tf
- ajouté : terraform/modules/ec2-server/versions.tf
- modifié : terraform/outputs.tf
