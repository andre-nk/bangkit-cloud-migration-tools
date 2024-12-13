package metrics

import (
	"log"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	ReceivedMessages = prometheus.NewCounter(prometheus.CounterOpts{
		Name: "nats_client_received_messages_total",
		Help: "Total number of messages received by the client.",
	})

	SuccessfulMessages = prometheus.NewCounter(prometheus.CounterOpts{
		Name: "nats_client_successful_messages_total",
		Help: "Total number of successfully processed messages.",
	})

	FailedMessages = prometheus.NewCounter(prometheus.CounterOpts{
		Name: "nats_client_failed_messages_total",
		Help: "Total number of failed messages.",
	})

	MessageProcessingTime = prometheus.NewHistogram(prometheus.HistogramOpts{
		Name:    "nats_client_message_processing_duration_seconds",
		Help:    "Histogram of the time taken to process messages.",
		Buckets: prometheus.DefBuckets,
	})
)

func RegisterMetrics() {
	prometheus.MustRegister(ReceivedMessages)
	prometheus.MustRegister(SuccessfulMessages)
	prometheus.MustRegister(FailedMessages)
	prometheus.MustRegister(MessageProcessingTime)
}

func StartMetricsServer() {
	http.Handle("/metrics", promhttp.Handler())
	go func() {
		log.Println("Starting metrics server at :8080/metrics")
		log.Fatal(http.ListenAndServe(":8080", nil))
	}()
}

func IncrementSuccessfulMessage(startTime time.Time) {
	SuccessfulMessages.Inc()
	duration := time.Since(startTime).Seconds()
	MessageProcessingTime.Observe(duration)
}

func IncrementFailedMessage(startTime time.Time) {
	FailedMessages.Inc()
	duration := time.Since(startTime).Seconds()
	MessageProcessingTime.Observe(duration)
}
