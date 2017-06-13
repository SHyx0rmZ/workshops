package db

import (
	//"database/sql"
	"github.com/SHyx0rmZ/workshops/workshops"
	"database/sql"
)

type Database interface {
	LoadWorkshops() ([]workshops.Workshop, error)
	SaveWorkshops([]workshops.Workshop) error

	LoadPeople() ([]workshops.Person, error)
	SavePeople([]workshops.Person) error
}

type sqlDatabase struct {
	db *sql.DB
}

func (db *sqlDatabase) LoadWorkshops() ([]workshops.Workshop, error) {
	rows, err := db.db.Query("SELECT FROM workshops")
	if err != nil {
		return nil, err
	}

	for rows.Next() {
		ws := workshops.Workshop{}

		rows.Scan(ws.)
	}
}

func (db *sqlDatabase) SaveWorkshops([]workshops.Workshop) error {
	panic("implement me")
}

func (db *sqlDatabase) LoadPeople() ([]workshops.Person, error) {
	panic("implement me")
}

func (db *sqlDatabase) SavePeople([]workshops.Person) error {
	panic("implement me")
}

type inMemoryDatabase struct {
	workshops.Flags
}

func OpenDatabase() (Database, error) {
	return &inMemoryDatabase{
		Flags: workshops.Flags{
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
		},
	}, nil
}

func (db *inMemoryDatabase) LoadWorkshops() ([]workshops.Workshop, error) {
	return db.Workshops, nil
}

func (db *inMemoryDatabase) SaveWorkshops(w []workshops.Workshop) error {
	db.Workshops = w

	return nil
}

func (db *inMemoryDatabase) LoadPeople() ([]workshops.Person, error) {
	return db.People, nil
}

func (db *inMemoryDatabase) SavePeople(p []workshops.Person) error {
	db.People = p

	return nil
}
