package workshops

type Session struct {
	Date      string `json:"date"`
	Attendees []int  `json:"attendees"`
	Status    string `json:"status"`
}
