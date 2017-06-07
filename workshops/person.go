package workshops

type Person struct {
	Name      string   `json:"name"`
	Keywords  []string `json:"keywords"`
	Workshops []string `json:"workshops"`
	Id        int      `json:"id"`
	Email     string   `json:"email"`
}
