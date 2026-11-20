# Ce que la séance S3 ajoute au dépôt (par rapport à fin-S2)

```
 CONTRIBUTING.md                                    |  2 +-
 README.md                                          | 19 ++++---
 ansible/ansible.cfg                                |  3 +-
 envs/dev/backend.tf                                |  9 +++
 {terraform => envs/dev}/main.tf                    | 39 +++++--------
 {terraform => envs/dev}/outputs.tf                 |  0
 {terraform => envs/dev}/terraform.tfvars.example   |  2 +-
 {terraform => envs/dev}/variables.tf               | 10 ++++
 {terraform => envs/dev}/versions.tf                | 14 ++---
 envs/prod/backend.tf                               |  9 +++
 envs/prod/main.tf                                  | 65 ++++++++++++++++++++++
 envs/prod/outputs.tf                               | 15 +++++
 envs/prod/terraform.tfvars.example                 |  5 ++
 envs/prod/variables.tf                             | 37 ++++++++++++
 envs/prod/versions.tf                              | 32 +++++++++++
 .../modules => modules}/ec2-server/.gitignore      |  0
 modules/ec2-server/main.tf                         | 57 +++++++++++++++++++
 .../modules => modules}/ec2-server/outputs.tf      |  0
 .../modules => modules}/ec2-server/variables.tf    |  6 ++
 .../modules => modules}/ec2-server/versions.tf     |  0
 scripts/start-morning.sh                           |  4 +-
 scripts/stop-evening.sh                            |  4 +-
 {terraform => templates}/inventory.tftpl           |  0
 terraform/modules/ec2-server/main.tf               | 48 ----------------
 24 files changed, 285 insertions(+), 95 deletions(-)
```

Fichiers écrits ou modifiés par les étudiants pendant le TP :

- modifié : CONTRIBUTING.md
- modifié : README.md
- modifié : ansible/ansible.cfg
- ajouté : envs/dev/backend.tf
- renommé : terraform/main.tf → envs/dev/main.tf
- renommé : terraform/outputs.tf → envs/dev/outputs.tf
- renommé : terraform/terraform.tfvars.example → envs/dev/terraform.tfvars.example
- renommé : terraform/variables.tf → envs/dev/variables.tf
- renommé : terraform/versions.tf → envs/dev/versions.tf
- ajouté : envs/prod/backend.tf
- ajouté : envs/prod/main.tf
- ajouté : envs/prod/outputs.tf
- ajouté : envs/prod/terraform.tfvars.example
- ajouté : envs/prod/variables.tf
- ajouté : envs/prod/versions.tf
- renommé : terraform/modules/ec2-server/.gitignore → modules/ec2-server/.gitignore
- ajouté : modules/ec2-server/main.tf
- renommé : terraform/modules/ec2-server/outputs.tf → modules/ec2-server/outputs.tf
- renommé : terraform/modules/ec2-server/variables.tf → modules/ec2-server/variables.tf
- renommé : terraform/modules/ec2-server/versions.tf → modules/ec2-server/versions.tf
- modifié : scripts/start-morning.sh
- modifié : scripts/stop-evening.sh
- renommé : terraform/inventory.tftpl → templates/inventory.tftpl
- supprimé : terraform/modules/ec2-server/main.tf
