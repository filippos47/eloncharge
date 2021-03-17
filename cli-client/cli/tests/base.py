from unittest import TestCase

class TestBase(TestCase):
    class Arguments:
        def __init__(self, *args, **kwargs):
            for k, v in kwargs.items():
                setattr(self, k, v)

    class Response:
        def __init__(self, text, status_code=200):
            self.text = text
            self.status_code = status_code

        def json(self):
            return self.text

    def _get_header(self, token=None):
        if not token:
            return {}
        return {"X-AUTH-OBSERVATORY": token}
