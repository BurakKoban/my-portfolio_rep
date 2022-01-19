from flask import Flask

#3 mandatory parts 1- from flask import Flask , 2- app = Flask(__name__), 3- __name__ = __main__

app = Flask(__name__)

@app.route("/")
def head():
    return "<h1>Hello World! from Burak</h1>"

@app.route("/second")
def second():
    return " This is my second page "

@app.route("/third/burak")
def third():
    return " This is a sub path"

#dynamic url 

@app.route("/fourth/<string:id>")
def fourth(id):
    return f'Id of this page is {id}'


if __name__ == "__main__":
    app.run(debug=True)