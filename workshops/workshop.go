package workshops

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
