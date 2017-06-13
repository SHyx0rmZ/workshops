package main

import (
	"encoding/json"
	"github.com/SHyx0rmZ/workshops/workshops"
	"github.com/SHyx0rmZ/workshops/workshops/db"
	"io/ioutil"
	"net/http"
)

func main() {
	jsHandler, err := NewStaticFileHandler("index.js")
	if err != nil {
		panic(err)
	}

	http.Handle("/dashboard", NewElmHandler())
	http.Handle("/workshops", NewElmHandler())
	http.Handle("/workshops/", NewElmHandler())
	http.Handle("/_index.js", jsHandler)
	http.Handle("/", http.RedirectHandler("/workshops", http.StatusTemporaryRedirect))
	http.ListenAndServe("0.0.0.0:3000", http.DefaultServeMux)
}

type ElmHandler struct {
	database db.Database
}

func NewElmHandler() *ElmHandler {
	database, _ := db.OpenDatabase()

	return &ElmHandler{
		database: database,
	}
}

func (h ElmHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	p, err := h.database.LoadPeople()
	if err != nil {
		return
	}

	ws, err := h.database.LoadWorkshops()
	if err != nil {
		return
	}

	d := &workshops.Flags{
		People:    p,
		Workshops: ws,
	}

	data, err := json.Marshal(d)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte(err.Error()))

		return
	}

	w.Write([]byte(`<!DOCTYPE HTML>
<html><head><meta charset="UTF-8"><title>Workshops.Index</title><style>html,head,body { padding:0; margin:0; }
body { font-family: calibri, helvetica, arial, sans-serif; }</style><script type="text/javascript" src="/_index.js"></script></head><body><script type="text/javascript">Elm.Workshops.Index.fullscreen(`))
	w.Write(data)
	w.Write([]byte(`)</script></body></html>`))
}

type StaticFileHandler struct {
	path    string
	content []byte
}

func NewStaticFileHandler(path string) (*StaticFileHandler, error) {
	content, err := ioutil.ReadFile(path)
	if err != nil {
		return nil, err
	}

	return &StaticFileHandler{path, content}, nil
}

func (h StaticFileHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	w.Write(h.content)
}
