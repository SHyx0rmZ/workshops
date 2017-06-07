package main

import (
	"io/ioutil"
	"net/http"
)

func main() {
	routes := map[string]string{
		"/dashboard":  "index.html",
		"/workshops":  "index.html",
		"/workshops/": "index.html",
	}

	for route, file := range routes {
		handler, err := NewStaticFileHandler(file)
		if err != nil {
			panic(err)
		}

		http.Handle(route, handler)
	}

	http.Handle("/", http.RedirectHandler("/workshops", http.StatusTemporaryRedirect))
	http.ListenAndServe("0.0.0.0:3000", http.DefaultServeMux)
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
