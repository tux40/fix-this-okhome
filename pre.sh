#!/bin/sh

set -e


go mod init broken_env
built_at=`date -u "+%d-%m-%y@%H"`

cat > main.go <<'EOF'
package main

import (
	"encoding/json"
	"log"
	"net/http"
)

const (
    builtAt string = "echo $built_at"
	address string = ":8228"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Header().Set("Content-Type", "application/json")

		json.NewEncoder(w).Encode(map[string]string{
			"built_at": builtAt,
		})
	})

	log.Println("run at", address)
	http.ListenAndServe(address, nil)
}
EOF