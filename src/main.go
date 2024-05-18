package main

import (
	"net/http"

	"fmt"
	"io"
	"log"
	"os"

	"encoding/json"

	"github.com/gin-gonic/gin"
)

const WeatherApi = "https://api.open-meteo.com/v1/forecast?latitude=40.87&longitude=-73.91&timezone=America%2FNew_York"

type Response struct {
	LATITUDE              float32 `json:"latitude"`
	LONGITUDE             float32 `json:"longitude"`
	GENERATIONTIME_MS     float32 `json:"generationtime_ms"`
	UTC_OFFSET_SECONDS    float32 `json:"utc_offset_seconds"`
	TIMEZONE              string  `json:"timezone"`
	TIMEZONE_ABBREVIATION string  `json:"timezone_abbreviation"`
	ELEVATION             float32 `json:"elevation"`
}

func main() {

	router := gin.Default()
	router.GET("/forecast", getForecast)
	router.Run("0.0.0.0:8080")

}

func getForecast(c *gin.Context) {
	response, err := http.Get(WeatherApi)
	if err != nil {
		fmt.Print(err.Error())
		os.Exit(1)
	}

	responseData, err := io.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(responseData))

	var responseObject Response
	json.Unmarshal(responseData, &responseObject)

	fmt.Printf("%.2f\n", responseObject.LATITUDE)
	fmt.Printf("%.2f\n", responseObject.LONGITUDE)
	c.IndentedJSON(http.StatusOK, responseObject)
}
