from locust import  HttpUser, TaskSet, task, between

class WebsiteTasks(TaskSet):
    @task
    def refresh_homePage(self):
        self.client.get("/")

    @task
    def login(self):
        self.client.options("/login")
        self.client.post("https://www.onlyflights.net/login",json={"username":"kaloyanandreev07@gmail.com","password":"Kokokamenov2002@"})

    @task
    def reach_profilePage(self):
        self.client.get("/profile")

class WebsiteUser(HttpUser):
    tasks = [WebsiteTasks]
    wait_time = between(0.100, 1.500)