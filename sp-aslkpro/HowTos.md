# Sphinx -- HowTo


## Die erforderlichen Schritte zur lokalen Kompilation der Dokumentation

(in Windows mit Anaconda Prompt als Administrator)

```
cd ...\ASLK_PRO\docs
make html
make latex
```

## Benutzung von Bbtext

**installieren**

pip install sphinxcontrib-bibtex

**im Text benutzen**

```
:cite:`Bibtextkey`
```

**Zitate mit Seitenangabe**

Wird nicht direkt unterstützt wie in Latex; der Workaround ist:

```
(:cite:`Bibtextkey`, Seite.999)
```

[Quelle1](https://build-me-the-docs-please.readthedocs.io/en/latest/Using_Sphinx/UsingBibTeXCitationsInSphinx.html#id4)
[Quelle2](https://readthedocs.org/projects/sphinxcontrib-bibtex/downloads/pdf/latest/)


## geschütze Leerzeichen anwenden

z.B. um 12 V darzustellen

```
12 |nbsp| V
```

## Kreuz-Referenzierung

Das über die Überschrift machen, die ihr referenzieren wollt.

```
.. _my-reference-label-1:

```  

Und das dann einfach in den Text, wo die Referenz stehen soll.

```
:ref:`my-reference-label-1`
```

## Überschriften Ebenen

```
######################
Komplette Teilbereiche
######################

*******
Kapitel
*******

Sektionen
=========

Unter-Sektionen
---------------

Unter-Unter-Sektionen
^^^^^^^^^^^^^^^^^^^^^

Paragraphen
"""""""""""
```
