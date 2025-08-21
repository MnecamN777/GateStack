from flask import Flask
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
from prometheus_client import make_wsgi_app
from werkzeug.middleware.dispatcher import DispatcherMiddleware

app = Flask(__name__)

counter = Counter('app1_requests_total', 'Total requests to App1')

@app.route("/")
def home():
	counter.inc()
	return "Hello from App1 5001"

app.wsgi_app = DispatcherMiddleware(app.wsgi_app, {'/metrics': make_wsgi_app()})

app.run(host="0.0.0.0", port=5001)
