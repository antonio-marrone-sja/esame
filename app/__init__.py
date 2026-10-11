# Application Factory Pattern. È un modo per creare l'applicazione
# Flask tramite una funzione, invece di inizializzarla direttamente
# in un file principale.

from flask import Flask
from app.routes import main

def create_app():
    app = Flask(__name__)

    app.register_blueprint(main)

    return app