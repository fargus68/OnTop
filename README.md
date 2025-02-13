OnTop ist ein Framework, das auf RobotFramework aufsetzt (daher der Name).
Ziel ist es, eine noch stärkere Entkopplung der Testdaten von der "Codierseite" zu erreichen.

Sämtliche Testdaten (auch Ablaufdaten) werden daher in Excel-Sheets gespeichert.
Warum Excel? 
- Excel ist insbesondere in Fachabteilungen, die mit datenintensiven betriebswirtschaftlichen Anwendungen zu tun haben weit verbreitet
- Excel bietet eine übersichtliche Darstellung tabellarischer Daten
- Excel bietet eine komfortable Bearbeitungsmöglichkeit tabellarischer Daten
- Excel als defacto-Standard wird von den meisten Automatisierungstools unterstützt
- Excel ist eine mächtige und selbst erweiterbare Software

Was bleibt auf der Code-Seite zu tun?
- Abarbeitungsschicht programmieren
  - es werden nacheinander Excel-Dateien eingelesen, bis irgendwann eine Stelle erreicht
    wird bei der etwas gegen das SUT getan werden muss. Das ist bei einem über die GUI 
    durchgeführten Test meist eine Aktion auf einem bestimmten GUI-Element 
- Ausführungsschicht
  - die Ausführungsschicht prüft ob die SUT an der richtigen Stelle steht
  - die Ausführungsschicht verteilt die Informationen zur Aktionsdurchführung an den generischen Controlcode
  - der generische Controlcode führt die Aktion entsprechend den übergebenen Parametern aus

Die Keywords sind in OnTop nicht mehr die Abläufe selbst, sondern befinden sich in den
Excel-Testdaten auf den unterschiedlichen Ebenen und bewirken die Ausführung von
speziellem Code.

Der führende Ansatz ist eher der datengetriebene Ansatz, allerdings auf mehreren Ebenen.
Dabei werden mehrere Dialoge zu Dialogfolgen, Prozesse genannt. Und mehrere Prozesse 
wiederum bilden Abläufe. Es entsteht ein großes Baukastensystem, dem aber stets die gleiche
Systematik innewohnt.

Durch bestimmte Mechanismen können die Testdaten redundanzarm gehalten werden, für umfangreiche
datenintensive Anwendungen ein Pluspunkt bei der Wartbarkeit. Änderungen in Dialogen,
Prozessen und Abläufen bewirken relativ geringen Pflegeaufwand in den Testdaten.
    

