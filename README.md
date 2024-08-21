# Thycotic CLI

La Thycotic CLI permet une utilisation plus fluide et simplifiée du terminal via le Jump Server.

## Installation

Pour installer la CLI Thycotic, exécutez la commande suivante :

```bash
git clone --branch develop https://github.com/papesambandour/thycotic thycotic && cd thycotic && chmod +x run.sh && ./run.sh
```

## Utilisation

### Configuration des accès Thycotic

Pour configurer les accès Thycotic, utilisez la commande `thycotic login`.

Cette commande vous demandera les identifiants Thycotic que vous utilisez sur l'interface web.

#### Syntaxe
```bash
thycotic login
```

#### Exemple de saisie
```
thycotic_username: pape.ndour
thycotic_password: *******
thycotic_sub_domaine: freesn (pour les utilisateurs de Free Sénégal)
```

### Ajouter un serveur

Pour ajouter un serveur, vous devez disposer de deux éléments :
- L'ID secret Thycotic
- L'IP du serveur

Cette configuration permet de lier une IP à un secret.

Si la liaison est déjà effectuée, le secret sera automatiquement mis à jour.

Si vous essayez de vous connecter à une IP non ajoutée, le système vous demandera automatiquement de configurer la liaison et d'ajouter le secret de l'IP entrée.

#### Syntaxe
```bash
thycotic add-host
```

#### Exemple de saisie
```
secret: 994
ip: 10.0.96.2
```

### Connexion SSH à un serveur

Pour vous connecter à un serveur via SSH, utilisez la commande suivante :

#### Syntaxe
```bash
thycotic IP_SERVER connect
```

#### Exemple
```bash
thycotic 10.0.96.3 connect
```

### Affichage des informations de connexion SSH

Pour afficher les informations de connexion SSH d'un serveur spécifique, utilisez la commande `show` :

#### Syntaxe
```bash
thycotic IP_SERVER show
```

#### Exemple
```bash
thycotic 10.0.96.3 show
```

### Copier un fichier local vers le serveur distant

Pour copier un fichier ou un répertoire local vers un serveur distant, utilisez la commande `l_copy` :

#### Syntaxe
```bash
thycotic IP_SERVER l_copy LOCAL_FILE_OR_DIRECTORY REMOTE_FILE_OR_DIRECTORY
```

#### Exemple
```bash
thycotic 10.0.96.3 l_copy /local_path/file.txt /remote_path/file.txt

thycotic 10.0.96.3 l_copy /local_path/directory /remote_path/directory
```

### Copier un fichier distant vers la machine locale

Pour copier un fichier ou un répertoire distant vers votre machine locale, utilisez la commande `r_copy` :

#### Syntaxe
```bash
thycotic IP_SERVER r_copy REMOTE_FILE_OR_DIRECTORY LOCAL_FILE_OR_DIRECTORY
```

#### Exemple
```bash
thycotic 10.0.96.3 r_copy /remote_path/file.txt /local_path/file.txt

thycotic 10.0.96.3 r_copy /remote_path/directory /local_path/directory
```


