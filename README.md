# THYCOTIC CLI 

Thycotic CLI permet d'avoir une utilisation beaucoup plus fluide de l'utilisation du terminal à travers le Jump Server

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
