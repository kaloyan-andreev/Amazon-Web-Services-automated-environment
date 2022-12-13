import website
import unittest


class TestSum(unittest.TestCase):

    # Setup Flask Application
    def setUp(self):
        website.app.testing = True
        self.app = website.app.test_client()

    # Check Status Code
    def test_login_response(self):
        result = self.app.get("/login")
        assert result.status_code != (400 - 499 and 500 - 599)

    # Check Status Code
    def test_signup_response(self):
        result = self.app.get("/signup")
        assert result.status_code != (400 - 499 and 500 - 599)

    # Check Status Code
    def test_profile_response(self):
        result = self.app.get("/profile")
        assert result.status_code != (400 - 499 and 500 - 599)

    # Check Status Code
    def test_home_page(self):
        result = self.app.get("/")
        assert result.status_code != (400 - 499 and 500 - 599)


if __name__ == '__main__':
    unittest.main()
