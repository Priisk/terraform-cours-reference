# Sécurité — registre des décisions

## Preuves de fuite constatées (S5, étape 1)

- Code : `git grep` sur la valeur du secret : ______
- State : `terraform state pull | grep` : ______
- user_data : `aws ec2 describe-instance-attribute … --attribute userData` : ______

## Après migration

- `terraform state pull | grep -c '<valeur>'` renvoie 0.
- Lecture depuis une instance dev de `/novasphere/dev/db_password` : succès.
- Lecture depuis une instance dev de `/novasphere/prod/db_password` : succès dans le Learner Lab (voir limite ci-dessous).

## Limite assumée : Learner Lab

Le lab interdit la création de rôles IAM. Les instances utilisent le profil précréé `LabInstanceProfile` (rôle `LabRole`), qui peut lire tous les paramètres, y compris ceux de prod. Le moindre privilège n'est donc pas démontrable sur le compte du lab. La politique qu'on déploierait en entreprise est écrite dans `envs/dev/iam_compte_classique.tf.exemple` : elle limite `ssm:GetParameter` au chemin `/novasphere/<environnement>/*`, et la lecture de prod depuis dev y renverrait AccessDeniedException.

## Lecture S5

`value_wo_version` est obligatoire avec `value_wo` : Terraform ne mémorisant pas la valeur, il ne peut détecter un changement que par l'incrément de ce compteur.

## Résultats checkov

- Corrigé : IMDSv2 exigé sur le Launch Template.
- Corrigé : IMDSv2 exigé sur les instances du module `ec2-server` (prod), CKV_AWS_79 (`metadata_options { http_tokens = "required" }`).
- Documenté (choix assumé) : logs d'accès ALB désactivés, hors périmètre du module (#checkov:skip sur `aws_lb.web`).

## Identifiants de la CI (Learner Lab)

La CI s'authentifie avec les trois identifiants de session du lab du référent (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_SESSION_TOKEN`), en secrets du dépôt, remis à jour à chaque Start Lab par `scripts/ci-secrets.sh`. Hors lab, on utiliserait la fédération OIDC (`envs/dev/ci_oidc_compte_classique.tf.exemple`), sans aucun secret stocké.

- Une pull request ouverte depuis une branche du dépôt reçoit ces secrets : tout collaborateur avec le droit d'écriture peut les lire en modifiant un workflow dans sa branche. Seuls les membres de l'équipe sont collaborateurs.
- Les workflows déclarent des `permissions:` minimales et n'utilisent pas `pull_request_target`.
- Les identifiants expirent avec la session (4 h) : une fuite reste bornée dans le temps, ce qui ne dispense pas de la prudence.
