package com.dngwjy.kmmweatherapp

import com.dngwjy.kmmweatherapp.data.WeatherResponse
import io.ktor.client.HttpClient
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer
import io.ktor.client.request.*
import io.ktor.client.statement.*
import kotlinx.serialization.json.Json

class Greeting {
    private val httpClient = HttpClient{
        install(JsonFeature){
            val json = Json { ignoreUnknownKeys = true }
            serializer = KotlinxSerializer(json)
        }
    }
    suspend fun greeting(): String {
        return getGreetings()
    }

    suspend fun getOneCall(lat: String,lng: String):WeatherResponse{
        return getWeatherByOneCall(lat,lng)
    }

    private suspend fun getGreetings(): String {
        val res = httpClient
            .get<HttpResponse>("https://api.openweathermap.org/data/2.5/weather?q=Yogyakarta&appid=6238342365ad103d49298689d1838d28")
        return res.readText()
    }

    private suspend fun getWeatherByOneCall(lat:String,lng:String): WeatherResponse {
        return httpClient
            .get("https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&appid=6238342365ad103d49298689d1838d28&units=metric")
    }
}