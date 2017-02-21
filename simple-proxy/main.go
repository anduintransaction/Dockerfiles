package main

import (
	"fmt"
	"os"
	"strings"
	"text/template"
)

type Stream struct {
	SourcePort string
	DestIP     string
	DestPort   string
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "At least one proxy must be configured")
		os.Exit(1)
	}

	streams := []*Stream{}
	for _, arg := range os.Args[1:] {
		pieces := strings.Split(arg, ":")
		stream := &Stream{}
		switch len(pieces) {
		case 2:
			stream.SourcePort = pieces[1]
			stream.DestIP = pieces[0]
			stream.DestPort = pieces[1]
		case 3:
			stream.SourcePort = pieces[0]
			stream.DestIP = pieces[1]
			stream.DestPort = pieces[2]
		default:
			continue
		}
		streams = append(streams, stream)
	}

	w, err := os.Create("/etc/nginx/nginx.conf")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	defer w.Close()
	tmpl, err := template.ParseFiles("nginx.conf.tmpl")
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	err = tmpl.Execute(w, streams)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
}
