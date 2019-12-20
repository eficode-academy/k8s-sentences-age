package main

import (
    "fmt"
    "log"
	"net/http"
    "math/rand"
    "time"
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
    httpReqs = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "age_http_requests_total",
			Help: "How many HTTP requests processed",
		},
		[]string{"code", "method"},
	)
)

func GetAge(min int, max int)(int) {
    rand.Seed(time.Now().UnixNano())
	return rand.Intn(max - min) + min
}

func handler(httpReqs *prometheus.CounterVec) http.HandlerFunc {
    return func(w http.ResponseWriter, r *http.Request) {
        min := 0
        max := 100
        age := GetAge(min, max)

        fmt.Fprintf(w, "%d", age)

        m := httpReqs.WithLabelValues("200", "GET")
        m.Inc()
    }
}

func main() {
    prometheus.MustRegister(httpReqs)

    http.HandleFunc("/", handler(httpReqs))
    http.Handle("/metrics", promhttp.Handler())
    log.Fatal(http.ListenAndServe(":8080", nil))
}
