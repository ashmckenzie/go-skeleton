package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
	"github.com/urfave/cli"
)

func TestStart(t *testing.T) {
	assert := assert.New(t)
	c := cli.NewContext(nil, nil, nil)
	e := Start(c)
	assert.Nil(e)
}
