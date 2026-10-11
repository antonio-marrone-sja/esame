# La separazione delle respondabilità serve per fare in modo che, se qualcosa
# va storto, è più facile individuare il problema. Inoltre questa struttura è
# più riutilizzabile

from app import create_app

# L'instanza di flask viene creata fuori dal main perché, per fare
# dei test, bisogna accedere solo all'app non necessariamente al
# server avviato dal metodo .run()
app = create_app()

if __name__ == "__main__":
    app.run(debug = True)