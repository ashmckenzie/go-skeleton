package main

import (
	"os"

	// "github.com/davecgh/go-spew/spew"
	"github.com/urfave/cli"
)

var projectName string
var version string

func main() {
	app := cli.NewApp()
	app.Name = projectName
	app.Version = version
	app.Usage = "<usage>"
	app.Action = func(c *cli.Context) error {
		return Start(c)
	}

	app.Run(os.Args)
}

func Start(c *cli.Context) error {
	return nil
}
