import logging
from flask import Flask, jsonify
from elasticapm.contrib.flask import ElasticAPM

logging.basicConfig(format='%(asctime)s %(levelname)-8s %(name)-15s %(message)s', level=logging.INFO)

app = Flask(__name__)
apm = ElasticAPM(app)


@app.route('/')
def index():
    return jsonify(ok=True), 200


if __name__ == '__main__':
    app.run()