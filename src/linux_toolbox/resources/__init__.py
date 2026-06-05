from importlib import resources


RESOURCE_PACKAGE = __name__


def load_text(rel_path):
    path = resources.files(RESOURCE_PACKAGE).joinpath(rel_path)
    return path.read_text(encoding="utf-8")


def load_template(rel_path, **subs):
    return load_text(rel_path).format(**subs)
