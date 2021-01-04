# UAS Remote Identification System
Brainstorming a way to have a [Remote ID](https://www.faa.gov/uas/getting_started/remote_id/) system that also gives pilots privacy. 

# Usage
Create assets by running render script:

```
./render.sh
```

# Goals

## Perfect forward secrecy
Even if someone is logging all encrypted location data, if an athority doesn't request that the data be decrypted in a certain period of time, it will not be possible to recover the session key encrypted to an ephemeral key hosted by a trusted party so long as that party rotates their keys regularly. Both Google Cloud and AWS Key Managment solutions allow for key deletion:

https://cloud.google.com/kms/docs/destroy-restore

https://docs.aws.amazon.com/kms/latest/developerguide/deleting-keys.html

This probably won't be an option in restricted airspace like near an airport. In that case you might encrypt your session key two or more times to keys for different authorities. When this is done you would have to trust those parties to destroy keys or to log access requests.

## Decryption Flow
Heres an example of a beacon that has the operator location encrypted but the drone in plaintext:

![droneEncrypted object diagram](https://raw.githubusercontent.com/BlackthornYugen/d2x/media/out/json/droneEncrypted.svg "droneEncrypted json object")

Both in plaintext (no need for encrypted AES session keys):

![dronePlaintext object diagram](https://raw.githubusercontent.com/BlackthornYugen/d2x/media/out/json/dronePlaintext.svg "dronePlaintext json object")

An example of how an authority might request the operator's location:

![A swimlane diagram showing how messages could be decrypted.](https://raw.githubusercontent.com/BlackthornYugen/d2x/media/out/json/droneEncryptedFlow.svg "drone encrypted flow diagram")

## Audit Logs
Log GPS decryption requests to one ore more remote services?

## Application
A mobile app that could be used get GPS data for pilots and their drones.

### Map View

![A series of tables showing drone details](https://raw.githubusercontent.com/BlackthornYugen/d2x/media/out/drone-details.gif "Drone details view") 
![An animaged map showing drone locations](https://raw.githubusercontent.com/BlackthornYugen/d2x/media/out/drone-map.gif "Drone map view")

### Auth
Authenticate to decrypt gps data via an API like the one described in above.

![Auth Screen](https://raw.githubusercontent.com/BlackthornYugen/d2x/media/out/app_ui/AuthTrusted.svg "Drone details view")
