from sample_project.general.utils.collections import deep_update
from sample_project.general.utils.settings import get_settings_from_environment

deep_update(globals(), get_settings_from_environment(
    ENVVAR_SETTINGS_PREFIX))  # type: ignore # noqa: F821
