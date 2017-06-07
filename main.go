package main

import (
	"encoding/json"
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

type Data struct {
	People    []Person   `json:"people"`
	Workshops []Workshop `json:"workshops"`
}

type Person struct {
	Name      string   `json:"name"`
	Keywords  []string `json:"keywords"`
	Workshops []string `json:"workshops"`
	Id        int      `json:"id"`
	Email     string   `json:"email"`
}

type Session struct {
	Date      string `json:"date"`
	Attendees []int  `json:"attendees"`
	Status    string `json:"status"`
}

type Workshop struct {
	Keywords    []string  `json:"keywords"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
	Materials   []string  `json:"materials"`
	Prospects   []int     `json:"prospects"`
	Schedule    []Session `json:"schedule"`
	History     []Session `json:"history"`
	Created     string    `json:"created"`
	Id          int       `json:"id"`
}

type ElmHandler struct{}

func NewElmHandler() *ElmHandler {
	return &ElmHandler{}
}

func (h ElmHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	d := &Data{
		People: []Person{
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
		Workshops: []Workshop{
			{
				Keywords:    []string{"banana", "apple", "fruit"},
				Title:       "Foo",
				Description: "Lorem ipsum dolor sit amet.",
				Materials:   []string{},
				Prospects:   []int{},
				Schedule:    []Session{},
				History: []Session{
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
				Schedule: []Session{
					{
						Date: "2017-06-06T00:00:00Z",
						Attendees: []int{
							0,
						},
						Status: "rejected",
					},
				},
				History: []Session{},
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
