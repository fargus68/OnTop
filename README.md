OnTop ist ein Framework, das auf RobotFramework aufsetzt (daher der Name).
Ziel ist es, eine noch stärkere Entkopplung der Testdaten von der "Codierungsseite" zu erreichen.
Codierung erfolgt in der Regel nicht mehr gegen spezifische Controls, sondern nur noch gegen
Controltypen.

Diese Art von Framework habe ich mit Kollegen zusammen in der Vergangenheit bereits
mit einigen Testautomatisierungswerkzeugen durchgeführt, darunter SilkTest, Ranorex und
TestComplete.

Wann macht der Einsatz eines "OnTop"-Frameworks Sinn?
Aus meiner Sicht amortisiert sich der entstehende Aufwand auf Anwendungsebene umso mehr, 
je mehr Dialoge mit einem bestimmten Controlset existieren. Die Anwendung sollte noch eine
gewisse Lebensdauer vor sich haben und auch eine gewisse Änderungshäufigkeit besitzen, 
damit sich der Wartbarkeitseffekt auch auswirken kann. Weitere Aspekte könnten sein:
absehbare Technologieupdates oder gar Technologiewechsel, Ausdehnung auf Systemtests,
Ausdehnung des Einsatzes derartiger Frameworks auf bestimmte "Anwendungsgruppen" etc. 

OnTop ist zunächst mal nur ein "Rahmen-Framework", dass noch projektspezifisch 
mit Leben gefüllt werden muss. Auch ist der aktuelle Codestand nur ein Beispiel einer
Umsetzung. So ist die Anzahl der Ebenen (mit Abläufen, Prozessen und Dialogen) nur ein
Vorschlag, es ist durchaus möglich, Ebenen wegzulassen oder sogar noch Ebenen
hinzuzufügen.

Sämtliche Testdaten (auch Ablaufdaten und technische Informationen) werden in Excel-Sheets gespeichert.
Warum Excel? 
- Excel ist insbesondere in Fachabteilungen, die mit datenintensiven betriebswirtschaftlichen Anwendungen zu tun haben weit verbreitet
- Excel bietet eine übersichtliche Darstellung tabellarischer Daten
- Excel bietet eine komfortable Bearbeitungsmöglichkeit tabellarischer Daten
- Excel als defacto-Standard wird von den meisten Automatisierungstools unterstützt
- Excel ist eine mächtige und selbst erweiterbare Software
Zu guter Letzt ist es somit sogar denkbar den "Testtreiber" auszutauschen.

Was bleibt auf der Code-Seite zu tun?
- Abarbeitungsschicht programmieren
  - es werden nacheinander Excel-Dateien eingelesen, bis irgendwann eine Stelle erreicht
    wird bei der etwas gegen das SUT getan werden muss. Das ist bei einem über die GUI 
    durchgeführten Test meist eine Aktion auf einem bestimmten GUI-Element. 
- Ausführungsschicht
  - die Ausführungsschicht prüft ob die SUT an der richtigen Stelle steht
  - verteilt die Informationen zur Aktionsdurchführung an den generischen Controlcode
  - der generische Controlcode führt die Aktion entsprechend den übergebenen Parametern aus

Es können aber natürlich auch andere Arten von Aktionen eingebaut werden, zum Beispiel Api-Aufrufe
oder Prüfungen von XML-Ausgabeschnittstellen.

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
    

