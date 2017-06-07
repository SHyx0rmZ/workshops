package workshops

type Flags struct {
	People    []Person   `json:"people"`
	Workshops []Workshop `json:"workshops"`
}
