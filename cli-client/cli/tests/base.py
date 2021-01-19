from unittest import TestCase

class TestBase(TestCase):
    class Arguments:
        def __init__(self, *args, **kwargs):
            for k, v in kwargs.items():
                setattr(self, k, v)

    class Response:
        def __init__(self, text):
            self.text = text

        def json(self):
            return self.text

    def _get_header(self, token=None):
        if not token:
            return {}
        return {"X-AUTH-OBSERVATORY": token}
