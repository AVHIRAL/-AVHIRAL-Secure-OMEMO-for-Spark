# 🔒 AVHIRAL Secure OMEMO for Spark

Modern **OMEMO End-to-End Encryption** for the Spark XMPP client.

![Version](https://img.shields.io/badge/version-0.14.2-blue.svg)
![Spark](https://img.shields.io/badge/Spark-3.0.2-orange.svg)
![Java](https://img.shields.io/badge/Java-8+-green.svg)
![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)

---

## Overview

AVHIRAL Secure OMEMO is a plugin that adds **native OMEMO encryption** to the Spark XMPP client.

Unlike previous experimental approaches, this plugin integrates directly into Spark's native conversation windows and provides encrypted messaging compatible with modern XMPP clients.

No external chat window is required.

---

## Features

- Native integration inside Spark conversations
- End-to-End OMEMO encryption (XEP-0384)
- Lock icon inside each conversation
- Automatic OMEMO session creation
- Automatic device discovery
- Automatic device publication
- Automatic message encryption
- Automatic message decryption
- Compatible with Spark 3.0.2
- Compatible with Smack 4.4.6

---

## Compatibility

Currently tested with:

| Client | Status |
|---------|--------|
| Spark 3.0.2 | ✅ |
| Monal (iOS) | ✅ |
| Conversations | Planned |
| Gajim | Planned |
| Dino | Planned |
| Kaidan | Planned |

---

# Screenshots

## Native Spark integration

*(Add screenshot here)*

---

## OMEMO activated

*(Add screenshot here)*

---

## Installation

1. Close Spark.

2. Copy

```
avhiral-omemo.jar
```

into

```
C:\Program Files (x86)\Spark\plugins\
```

or

```
%APPDATA%\Spark\plugins\
```

3. Restart Spark.

The plugin loads automatically.

---

## Requirements

- Spark 3.0.2
- Java 8+
- XMPP Server supporting:

- XEP-0384 (OMEMO)
- XEP-0163 (PEP)
- XEP-0060 (PubSub)

---

## Current Features

✔ Native Spark integration

✔ OMEMO lock button

✔ Device publication

✔ Device discovery

✔ Automatic encryption

✔ Automatic decryption

✔ Automatic session establishment

✔ Compatible with Monal

✔ Compatible with Spark 3.0.2

---

## Roadmap

### Version 0.15

- Trusted device manager
- Fingerprint verification
- Device list

### Version 0.16

- Automatic key rotation
- Better multi-device synchronization
- Improved trust management

### Version 1.0

- Stable release
- Full OMEMO support
- Cross-platform compatibility

---

## Project Status

The plugin is currently under active development.

The main goal is to bring a modern, secure and fully integrated OMEMO implementation to Spark.

---

## Binary Distribution

This repository distributes **compiled releases only**.

The source code is proprietary and is not publicly available.

---

## Security

This plugin implements the OMEMO protocol used by many modern XMPP clients.

Although it is already functional, it is currently considered **Beta software**.

Use it in production at your own discretion until version 1.0 is released.

---

## Reporting Issues

If you encounter a problem, please open an Issue describing:

- Spark version
- Java version
- XMPP server
- Operating system
- Error message
- Screenshots (if available)

---

## Changelog

### 0.14.2

- Native Spark conversation integration
- Conversation lock button
- Automatic encryption/decryption
- Native OMEMO rendering
- Improved compatibility with Monal

---

## Developed by

# AVHIRAL

Cybersecurity • Secure Communications • Embedded Security

Website:

https://www.avhiral.com

LinkedIn:

https://www.linkedin.com/company/avhiral

---

## License

Copyright © AVHIRAL.

All rights reserved.

The binary plugin may be freely downloaded and evaluated.

Redistribution of modified versions is prohibited without written authorization.

The source code is proprietary.

---

## Acknowledgements

Special thanks to:

- Ignite Realtime
- Spark Developers
- Smack Developers
- XMPP Standards Foundation (XSF)

for maintaining the Spark ecosystem and the XMPP protocol.

---

## PAYPAL DON : https://www.paypal.com/donate/?hosted_button_id=FSX7RHUT4BDRY


# AVHIRAL Secure OMEMO

**Modern secure messaging for Spark.**
