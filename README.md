# inspire|IT Giveaway App

Diese App stellt eine Beispielanwendung zur Nutzung von Bluetooth Beacons unter iOS dar. Mit Hilfe der App kann gezählt werden wie häufig ein Ort besucht wurde. Dazu wird ein Beacon an dem Ort platziert, die App zählt dann wie oft dieser Ort besucht wurde. Ein Beispiel dazu ist die Anzahl der Besuche einer Kaffeemaschiene. Enstanden ist sie im Rahmen der inspire|IT Konferenz als Zusatz zu den dort verteilten Beacons.


## Vorrausetzungen
Diese App setzt ein BLE (Bluetooth Low Energy) fähiges Smartphone mit iOS 10.1 oder höher vorraus. 
Zudem wird für die Nutzung ein Bluetooth Beacon, welches im iBeacon Format sendet, benötigt.


## Installation



## Benutzung

In den Einstellungen der App lassen sich folgende Konfigurationen vornehmen:

* Bezeichnung: Hier kann ein Name für den Zähler festgelegt werden.
* BeaconId: Die MinorId des Beacons.
* Zeit: Zeit in Sekunden, die mindestens vergehen muss bis der Zähler wieder hochzählt.
* Distanz: Wird diese Distanz unterschritten, löst der Zähler aus.
* Scannen im Hintergrund: Es gibt die Möglichkeit den Scanner auch im Hintergrund aktiv zu halten, um Besuche auch dann zu erfassen, wenn die App nicht im Vordergrund ist.


## Lizenz 

Für diese Anwendung gilt die MIT Lizenz.
	
Es werden folgende Open Source Bibliotheken verwendet:

* Popover 1.0.6
