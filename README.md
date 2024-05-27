# THYCOTIC CLI 

## Configuration requis
thycotic_username: le nom d'utilisateur thycotic

thycotic_password: le mot de passe  thycotic

thycotic_sub_domaine: le sous domaine de l'entreprise (exemple : freesn)

## Installation

``` 
git clone --branch develop https://github.com/papesambandour/thycotic | cd && chmod +x run.sh && ./run.sh

```

## Utilisation

### Configuration

Pour configurer les access thycotic on peut utiliser la commande thycotic login

#### Syntax
```
thycotic login
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
