# THYCOTIC CLI 

Thycotic CLI permet d'avoir une utilisation beaucoup plus fluide de l'utilisation du terminal à travers le Jump Server

## Installation

``` 
git clone --branch develop https://github.com/papesambandour/thycotic thycotic && cd thycotic && chmod +x run.sh && ./run.sh
```

## Utilisation

### Configuration

Pour configurer les access thycotic on peut utiliser la commande thycotic login.

Il va vous demander vos accès thycotic que vous utiliser au niveau de l'interface web.

#### Syntax
```
thycotic login

Exemple de donnée
thycotic_username: pape.ndour
thycotic_password:*******
thycotic_sub_domaine:freesn(pour les utilisateur de Free Senegal)
```

### Connexion ssh vers un server

#### Syntax
```
thycotic SECERET_ID IP_SERVER connect
```
#### Exemple
```
thycotic 994 10.0.96.3 connect
```

### Affichage information de connexion ssh unique

#### Syntax
```
thycotic SECERET_ID IP_SERVER show
```
#### Exemple
```
thycotic 994 10.0.96.3 show
```

### Copier un fichier local vers le remote serveur

#### Syntax
```
thycotic SECERET_ID IP_SERVER l_copy LOCAL_FILE_OR_DIRECTORY REMOTE_FILE_OR_DIRECTORY
```
#### Exemple
```
thycotic 994 10.0.96.3 l_copy /local_path/file.txt /remote_path/file.txt

thycotic 994 10.0.96.3 l_copy /local_path/directory /remote_path/directory
```


### Copier un fichier distant en local

#### Syntax
```
thycotic SECERET_ID IP_SERVER r_copy REMOTE_FILE_OR_DIRECTORY LOCAL_FILE_OR_DIRECTORY 
```
#### Exemple
```
thycotic 994 10.0.96.3 r_copy /remote_path/file.txt /local_path/file.txt 

thycotic 994 10.0.96.3 r_copy /remote_path/directory /local_path/directory 
```
