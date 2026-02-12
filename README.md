# File Type Association Tool (Windows)

Outil graphique Windows permettant de **modifier les associations de types de fichiers** sous Windows 10 / 11, même lorsque les protections modernes de Windows empêchent ces changements.

L’application combine une interface Win32 native avec :
- **SetUserFTA**
- des scripts **PowerShell**
- **ViveTool**

afin de reprendre le contrôle des associations de fichiers.

---

## ✨ Fonctionnalités

- Association de types de fichiers avec :
  - Firefox
  - Chrome
  - Microsoft Edge
  - Adobe Acrobat Reader
  - VLC Media Player
  - OnlyOffice
- Sélection graphique du **type de fichier**
- Sélection de l’**application**
- Vérification automatique de la compatibilité extension ↔ application
- Application de l’association en un clic
- Désactivation des protections Windows :
  - **UCPD (User Choice Protection Driver)**
  - **AppDefaultHashRotation**
  - **AppDefaultHashRotationUpdateHashes**
- Téléchargement automatique de **ViveTool** si nécessaire

---

## 🖥️ Interface

L’interface se compose de 5 boutons principaux :

- **Type**  
  Permet de sélectionner l’extension à associer (`.pdf`, `.mp4`, `.html`, etc.)

- **App**  
  Permet de choisir l’application cible (Firefox, VLC, OnlyOffice, etc.)

- **Associate**  
  Applique l’association du type sélectionné vers l’application choisie

- **Disable UCPD**  
  Désactive le service et la tâche planifiée responsables de la protection des associations

- **Disable HashRotation**  
  Désactive les mécanismes internes empêchant la persistance des associations

---

## 🚀 Utilisation

### 1. Lancer l’application

⚠️ **L’application doit être lancée en tant qu’administrateur**

Sans les droits administrateur :
- les scripts PowerShell échoueront
- les associations risquent de ne pas persister

---

### 2. Choisir un type de fichier

1. Cliquer sur **Type**
2. Sélectionner l’extension souhaitée dans la liste
3. La sélection est automatiquement validée

⚠️ Si une application est déjà sélectionnée, l’outil vérifie que l’extension est compatible.

---

### 3. Choisir une application

1. Cliquer sur **App**
2. Sélectionner l’application cible
3. Si l’extension n’est pas supportée :
   - un message d’erreur s’affiche
   - la sélection est annulée

---

### 4. Associer le type de fichier

1. Cliquer sur **Associate**
2. L’outil utilise `SetUserFTA.exe` pour appliquer l’association

✅ L’association est appliquée pour l’utilisateur courant.

---

### 5. Désactiver les protections Windows (optionnel mais recommandé)

#### Disable UCPD
- Désactive le service **UCPD**
- Désactive la tâche planifiée associée

#### Disable HashRotation
- Télécharge automatiquement **ViveTool** si absent
- Désactive :
  - `AppDefaultHashRotation`
  - `AppDefaultHashRotationUpdateHashes`

⚠️ Ces actions peuvent être annulées par Windows Update.

---

## ⚠️ Prérequis

- Windows 10 ou Windows 11
- Droits administrateur
- Présence des fichiers suivants :
  - `SetUserFTA.exe`
  - Dossier `UCPD_HashRotation/` contenant :
    - `UCPD.ps1`
    - `HashRotation.ps1`

---

## 📂 Structure du projet

.
├── main.exe
├── SetUserFTA.exe
├── UCPD_HashRotation/
│ ├── UCPD.ps1
│ └── HashRotation.ps1
| └── Verif Protection.ps1
└── README.md


---

## 🔐 Sécurité & avertissements

⚠️ Ce projet **contourne volontairement des mécanismes de protection Windows**.

- Peut cesser de fonctionner après une mise à jour système
- Peut être bloqué par certaines stratégies de sécurité
- À réserver à un usage avancé ou maîtrisé

L’utilisation se fait **à vos propres risques**.

---

## 🧠 Détails techniques

- Application Win32 native (C)
- Gestion Unicode (UTF-8)
- Associations basées sur les **ProgID**
- Vérifications automatiques de compatibilité
- Scripts PowerShell exécutés via `system()`

---

## 📜 Licence

Projet fourni **tel quel**, sans garantie.

Utilisation libre à des fins personnelles ou éducatives.

---

## 🧨 Disclaimer

Ce logiciel modifie le comportement interne de Windows.

L’auteur ne pourra être tenu responsable :
- d’une instabilité système
- d’une perte de configuration
- d’un dysfonctionnement après mise à jour Windows