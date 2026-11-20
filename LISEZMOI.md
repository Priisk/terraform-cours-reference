# Dépôts NovaSphere par séance

Un dossier par état du dépôt, exporté depuis le dépôt de référence (`novasphere-infra-reference.zip`, un tag par fin de séance). Chaque dossier existe aussi en zip (`novasphere-<tag>.zip`), qui se décompresse dans un dossier `novasphere-<tag>/`.

| Dossier | Contenu |
|---|---|
| `novasphere-depart` | Le starter, état de fin de Bac+4 : point de départ de S1 |
| `novasphere-fin-S1` | S1 terminée : backend S3 verrouillé, `CONTRIBUTING.md` |
| `novasphere-fin-S2` | S2 terminée : module `ec2-server` complet, deux appels, blocs `moved` |
| `novasphere-fin-S3` | S3 terminée : `envs/dev` et `envs/prod`, module v1.1.0 à règles séparées (`name_prefix`, promotion sans doublon de règles) |
| `novasphere-fin-S4` | S4 terminée : VPC deux zones, Launch Template, ALB, ASG |
| `novasphere-fin-S5` | S5 terminée : secret en écriture seule, profil `LabInstanceProfile`, IMDSv2, agent SSM, `SECURITE.md` |
| `novasphere-fin-S6` | S6 terminée : exemples `import`, `moved`, `removed` |
| `novasphere-fin-S7` | S7 terminée : workflows GitHub Actions avec identifiants de session du lab |

Chaque dossier `fin-Sx` contient `CE_QUE_LA_SEANCE_AJOUTE.md` : la liste des fichiers ajoutés ou modifiés par le TP, c'est-à-dire ce que les étudiants devaient produire. L'état `fin-S(x-1)` est le point de départ attendu de la séance x.

Avant tout `apply` : remplacer `<trigramme>` dans les blocs backend, copier `terraform.tfvars.example` en `terraform.tfvars`. Région : `us-east-1`. Pour passer d'un état à un autre, détruire d'abord l'infrastructure de l'état précédent (`terraform destroy`) : un `init -migrate-state` dans un dossier neuf ne récupère pas l'ancien state.

À partir de `fin-S3`, les scripts de fin de journée prennent l'environnement en argument : `scripts/stop-evening.sh prod` et `scripts/start-morning.sh prod`. À partir de `fin-S4`, `envs/dev` (ALB, ASG) ne s'arrête pas : `terraform destroy` dans `envs/dev`.

Version AWS Academy Learner Lab : les états tournent tels quels dans le lab. IAM y étant verrouillé, S5 utilise le profil précréé `LabInstanceProfile` et S7 les identifiants de session du lab stockés en secrets GitHub. La version entreprise (rôle au moindre privilège, fédération OIDC) est conservée dans les fichiers `envs/dev/*_compte_classique.tf.exemple`, à lire et à expliquer.

## À créer dans GitHub pour `fin-S7`

Les workflows ne lisent ni `terraform.tfvars` (ignoré par Git) ni `~/.ssh`. Dans `Settings > Secrets and variables > Actions` du dépôt :

| Type | Nom | Contenu |
|---|---|---|
| Variable | `OWNER` | Trigramme, le même que dans `terraform.tfvars` |
| Variable | `ADMIN_CIDR` | IP publique fixe de l'administrateur en `/32`, pour la règle SSH de prod (sinon elle s'ouvrirait à l'IP du runner) |
| Variable | `SSH_PUBLIC_KEY` | Contenu de `~/.ssh/novasphere.pub`, la même clé qu'en local |
| Secret | `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN` | AWS Details du lab, recopiés à chaque Start Lab par `scripts/ci-secrets.sh` (aws CLI et gh authentifiés) |
| Secret | `DB_PASSWORD` | Mot de passe applicatif de dev (`TF_VAR_db_password`) |

`TF_VAR_environment` et `TF_VAR_generate_inventory = "false"` (prod) sont fixés dans les workflows. Le détail est dans le `README.md` de `fin-S7`, et le risque de ces secrets (lisibles par tout collaborateur via un workflow modifié) dans son `SECURITE.md`.
