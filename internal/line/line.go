package line

import (
	"context"

	"github.com/utahta/go-linenotify"
)

var token *string

// Init get Token
func Init(tk *string) {
	token = tk
}

// Send message
func Send(msg string) {
	c := linenotify.NewClient()
	c.Notify(context.Background(), *token, msg, "", "", nil)
}
