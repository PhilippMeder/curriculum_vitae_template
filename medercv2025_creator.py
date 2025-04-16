import json
from dataclasses import dataclass, asdict, fields
from pathlib import Path


@dataclass(kw_only=True)
class Contact:

    address: str = None
    mail: str = None
    phone: str = None
    github: str = None

    @property
    def latex(self):
        return "\n".join(
            [
                rf"\address{{{self.address.replace(". ", ".~")}}}",
                rf"\mail{{{self.mail}}}",
                rf"\phone{{{self.phone}}}",
                rf"\github{{{self.github}}}",
            ]
        )


@dataclass
class SimpleDate:

    year: int
    year_end: int = None

    def __lt__(self, other):
        return self.year_end < other.year

    @property
    def latex(self):
        if self.year_end:
            return f"{self.year}--{self.year_end}"
        else:
            return self.year


@dataclass
class Degree:

    name: str
    institution: str
    date: SimpleDate
    information: str = None
    grade: float = None

    def __lt__(self, other):
        return self.date < other.date

    def _get_latex_description(self):
        _latex = self.institution
        if self.information:
            _latex += rf"\newline{{\small {self.information}}}"

        return _latex

    @property
    def latex(self):
        if self.grade:
            name = rf"{self.name} \hfill \grade{{{self.grade:3.1f}}}"
        else:
            name = self.name

        return rf"    \event{{{self.date.latex}}}{{{name}}}{{{self._get_latex_description()}}}"


@dataclass
class Experience(Degree):

    name_description: str = None  # Currently unused
    source: str = None

    def _get_latex_description(self):
        _latex = self.institution
        if self.information:
            _latex += rf"\newline{{\small {self.information}}}"
        if self.source:
            _latex += rf"\newline{{\footnotesize {self.source}}}"

        return _latex


@dataclass
class Skill:

    name: str
    rating: float = None
    rating_description: str = None
    information: str = None

    @property
    def latex(self):
        if self.rating:
            if self.rating > 7:
                color = "goodskill"
            elif self.rating > 4:
                color = "mediumskill"
            else:
                color = "basicskill"
            _latex = rf"\skillrated{{{self.name}}}{{{self.rating/20}}}{{{color}}}"
        else:
            _latex = rf"\skilldescribed{{{self.name}}}{{{self.rating_description}}}"

        return _latex


@dataclass
class CurriculumVitae:

    name: str
    babel_language: str
    about_me: str
    contact: Contact
    degrees: list[Degree]
    experience: list[Experience]
    skills: dict[str, Skill]
    birthday: str = None
    nationality: str = None

    @property
    def latex(self):
        _latex_lines = [
            rf"\documentclass[DIV=18]{{medercv2025}}",
            rf"\usepackage[{self.babel_language}]{{babel}}",
            "",
            rf"\author{{{self.name}}}",
            rf"\birthday{{{self.birthday}}}",
            rf"\nationality{{{self.nationality}}}",
            rf"{self.contact.latex}",
            "",
            r"\begin{document}",
            "",
            r"\setmetadata",  # Has to be here!
            "",
            r"\color{normal}",
            "",
            r"\maketitle",
            "",
            r"\begin{paracol}{2}",
            "",
            r"\section*{\thecontactname}",
            r"\contactinfo",
            ""
        ]

        for skilltype, skills in self.skills.items():
            _latex_lines += [
                "",
                rf"\section*{{{skilltype}}}",
                r"\begin{skills}"
            ]
            _latex_lines += [skill.latex for skill in skills]
            _latex_lines.append(r"\end{skills}")

        _latex_lines += [
            "",
            r"\switchcolumn",
            "",
            r"\section*{\theaboutmename}",
            rf"{self.about_me}"
        ]

        all_events = {
            r"\theexperiencename": self.experience,
            r"\theeducationname": self.degrees
        }
        for title, event_list in all_events.items():
            _latex_lines += [
                "",
                rf"\section*{{{title}}}",
                r"\begin{events}"
            ]
            _latex_lines += [event.latex for event in event_list]
            _latex_lines.append(r"\end{events}")

        _latex_lines += [
            "",
            r"\vspace{\paperheight}",  # Needed for correct coloring
            "",
            r"\end{paracol}",
            "",
            r"\end{document}"
        ]

        _latex = "\n".join(_latex_lines)

        return _latex.replace("&", r"\&")


def save(curriculum_vitae: CurriculumVitae, filename: str | Path, overwrite: bool = False, tex_replacements: list = None):
    filepath = Path(filename)
    if filepath.exists() and not overwrite:
        raise FileExistsError(f"File '{filepath}' already exists but 'overwrite' is turned off!")

    with open(filepath, mode="w", encoding="utf-8") as file:
        match filepath.suffix:
            case ".json":
                json.dump(asdict(curriculum_vitae), file, indent=4)
            case ".tex":
                latex = curriculum_vitae.latex
                if tex_replacements:
                    for replacement in tex_replacements:
                        latex = latex.replace(*replacement)
                file.write(latex)


def load_unnested_dataclass_from_dict(cls, data: dict):
    return cls(**{(fieldname:=field.name): data[fieldname] for field in fields(cls)})


def load(filename: str | Path):
    # Load data from a json file
    with open(filename, mode="r", encoding="utf-8") as file:
        data = json.load(file)

    # Setup the easy accesible data elements
    dataclass_kwargs = {
        "name": data["name"],
        "babel_language": data["babel_language"],
        "about_me": data["about_me"],
        "birthday": data["birthday"],
        "nationality": data["nationality"],
        "contact": load_unnested_dataclass_from_dict(Contact, data["contact"])
    }

    # Get 'event' data, e.g. degrees, that have a date
    list_data = {"degrees": Degree, "experience": Experience}
    replace_with_obj = {"date": SimpleDate}
    for fieldname, cls in list_data.items():
        dataclass_kwargs[fieldname] = [load_unnested_dataclass_from_dict(cls, element) for element in data[fieldname]]
        # Replace some fields with a class instance of the data, e.g. the date
        for replace_name, replace_cls in replace_with_obj.items():
            for item in dataclass_kwargs[fieldname]:
                setattr(item, replace_name, replace_cls(**getattr(item, replace_name)))

    # Get named additional stuff, e.g. skills of different categories
    dict_data = {"skills": Skill}
    for fieldname, cls in dict_data.items():
        dataclass_kwargs[fieldname] = {element_name: [load_unnested_dataclass_from_dict(cls, subelement) for subelement in data[fieldname][element_name]] for element_name in data[fieldname]}

    return CurriculumVitae(**dataclass_kwargs)
