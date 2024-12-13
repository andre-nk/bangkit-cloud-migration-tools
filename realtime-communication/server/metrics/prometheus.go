package metrics

import (
	"github.com/prometheus/client_golang/prometheus"
)

var (
	MsgsSentToClient = prometheus.NewCounter(prometheus.CounterOpts{
		Name: "nats_msgs_sent_to_client",
		Help: "Total number of messages sent by the NATS server to the client",
	})

	ResponsesReceivedFromClient = prometheus.NewCounter(prometheus.CounterOpts{
		Name: "nats_responses_received",
		Help: "Total number of responses received by the NATS server from the client",
	})

	ResponseLatency = prometheus.NewHistogram(prometheus.HistogramOpts{
		Name:    "nats_response_latency_seconds",
		Help:    "Latency of the responses received by the NATS server from the client",
		Buckets: prometheus.DefBuckets,
	})

	ResponseErrors = prometheus.NewCounter(prometheus.CounterOpts{
		Name: "nats_response_errors",
		Help: "Total number of errors occurred while receiving responses from the client",
	})

	HttpRequestsTotal = prometheus.NewCounterVec(prometheus.CounterOpts{
		Name: "http_requests_total",
		Help: "Total number of HTTP requests",
	}, []string{"status"})
)

func RegisterMetrics() {
	prometheus.MustRegister(MsgsSentToClient)
	prometheus.MustRegister(ResponsesReceivedFromClient)
	prometheus.MustRegister(ResponseLatency)
	prometheus.MustRegister(ResponseErrors)
	prometheus.MustRegister(HttpRequestsTotal)
}
