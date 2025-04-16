## Curriculum Vitae LaTeX Class and JSON-to-LaTeX-Converter (Python)

Provides a LaTeX class for a curriculum vitae called `medercv2025`.
[`medercv2025_creator.py`](medercv2025_creator.py) provides a python dataclass and a converter so you can write your curriculum vitae in JSON and convert it to LaTeX later.

See the example in [`example_cv.json`](example_cv.json) that can be converted as follows:
```python
import medercv2025_creator as cv_creator

# Load curriculum vitae from json
curriculum_vitae = cv_creator.load("example_cv.json")
# Convert the curriculum vitae to LaTeX and save it
cv_creator.save(curriculum_vitae, "example_cv.tex")
```
The output looks like this:
![Preview of example currivulum vitaet](example_cv_preview.png)


### Mandatory and optional personal information

Regarding the personal information, some entries are optional and won't show up in the final document if left empty when passing to LaTeX.
Mandatory entries may be empty as well, but the entry will show up in the final document anyway.

| Mandatory | Optional    |
|-----------|-------------|
| name      | birthday    |
| address   | nationality |
| mail      | github      |
| phone     |             |

### Document language

Using the `babel_language` option (see [`example_cv.json`](example_cv.json)) you can choose what language will be passed to LaTeX.
With the exception of your custom titled skills, all title names will be translate into the given language.

Supported languages are *english* and *german* (*ngerman*).

If you want to use a different language, you should add a set of translations in front of the `\begin{document}` in the produced `*.tex` file:

```tex
\DeclareTranslation{ChosenLanguage}{documenttitle}{translation}
\DeclareTranslation{ChosenLanguage}{birthday}{translation}
\DeclareTranslation{ChosenLanguage}{nationality}{translation}
\DeclareTranslation{ChosenLanguage}{address}{translation}
\DeclareTranslation{ChosenLanguage}{phone}{translation}
\DeclareTranslation{ChosenLanguage}{email}{translation}
\DeclareTranslation{ChosenLanguage}{github}{translation}
\DeclareTranslation{ChosenLanguage}{contact}{translation}
\DeclareTranslation{ChosenLanguage}{aboutme}{translation}
\DeclareTranslation{ChosenLanguage}{education}{translation}
\DeclareTranslation{ChosenLanguage}{experience}{translation}
\DeclareTranslation{ChosenLanguage}{grade}{translation}
```