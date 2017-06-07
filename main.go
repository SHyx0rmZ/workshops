package main

import (
	"encoding/json"
	"github.com/SHyx0rmZ/workshops/workshops"
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

type ElmHandler struct{}

func NewElmHandler() *ElmHandler {
	return &ElmHandler{}
}

func (h ElmHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	d := &workshops.Flags{
		People: []workshops.Person{
			{
				Name:      "Hans Wurst",
				Keywords:  []string{"cat", "fish"},
				Workshops: []string{"Foo"},
				Id:        0,
				Email:     "hans.wurst@example.com",
			},
			{
				Name:      "Horst Semmel",
				Keywords:  []string{"banana", "fruit"},
				Workshops: []string{},
				Id:        1,
				Email:     "horst.semmel@example.com",
			},
		},
		Workshops: []workshops.Workshop{
			{
				Keywords:    []string{"banana", "apple", "fruit"},
				Title:       "Foo",
				Description: "Lorem ipsum dolor sit amet.",
				Materials:   []string{},
				Prospects:   []int{},
				Schedule:    []workshops.Session{},
				History: []workshops.Session{
					{
						Date: "2017-06-06T00:00:00Z",
						Attendees: []int{
							0,
							1,
						},
						Status: "approved",
					},
				},
				Created: "2017-06-06T00:00:00Z",
				Id:      0,
			},
			{
				Keywords:    []string{"dog", "cat", "animal"},
				Title:       "Bar",
				Description: "Lorem ipsum dolor sit amet.",
				Materials: []string{
					"http://example.com/Bar.pdf",
				},
				Prospects: []int{
					0,
				},
				Schedule: []workshops.Session{
					{
						Date: "2017-06-06T00:00:00Z",
						Attendees: []int{
							0,
						},
						Status: "rejected",
					},
				},
				History: []workshops.Session{},
				Created: "2017-06-06T00:00:00Z",
				Id:      1,
			},
		},
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
