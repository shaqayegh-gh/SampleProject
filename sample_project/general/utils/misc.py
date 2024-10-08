import yaml


def yaml_coerce(value):
    """Convert value to proper python"""
    if isinstance(value, str):
        # yaml.load returns a Python object
        # Convert string dict "{'apples': 1, 'bacon':2}" tp Python dict
        # useful because sometimes we need to stringify settings this way like in Dockerfile
        return yaml.load(f'dummy: {value}', Loader=yaml.SafeLoader)['dummy']

    return value


def identity_decorator(callable_):
    return callable_


class NullObject:

    def __getattr__(self, name):
        return None


null_object = NullObject()


def swallow_exception(callable_, *args, **kwargs):
    try:
        callable_(*args, **kwargs)
    except Exception:
        pass


def get_nested_attr(obj, attr):
    """
    Utility function to fetch nested attributes safely.
    """
    for key in attr.split('__'):
        obj = getattr(obj, key, None)
        if obj is None:
            return None
    return obj
