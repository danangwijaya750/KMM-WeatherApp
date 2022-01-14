package com.dngwjy.kmmweatherapp.data

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class WeatherResponse(
    @SerialName("current")
    val current:Current,
    var daily: List<DailyData>?,
)

@Serializable
data class Current(
    var clouds: Int?,
    var dew_point: Double?,
    var dt: Int?,
    var feels_like: Double?,
    var humidity: Int?,
    var pressure: Int?,
    var sunrise: Int?,
    var sunset: Int?,
    var temp: Double?,
    var uvi: Int?,
    var visibility: Int?,
    var wind_deg: Int?,
    var wind_gust: Double?,
    var wind_speed: Double?,
    @SerialName("weather")
    var weather:List<Weather>?
)

@Serializable
data class DailyData(
    var clouds: Int?,
    var dew_point: Double?,
    var dt: Int?,
    var feels_like: FeelsLike?,
    var humidity: Int?,
    var moon_phase: Double?,
    var moonrise: Int?,
    var moonset: Int?,
    var pop: Double?,
    var pressure: Int?,
    var rain: Double?,
    var sunrise: Int?,
    var sunset: Int?,
    var temp: Temp?,
    var uvi: Double?,
    var weather: List<Weather>?,
    var wind_deg: Int?,
    var wind_gust: Double?,
    var wind_speed: Double?
)

@Serializable
data class FeelsLike(
    var day: Double?,
    var eve: Double?,
    var morn: Double?,
    var night: Double?,
)

@Serializable
data class Temp(
    var day: Double?,
    var eve: Double?,
    var max: Double?,
    var min: Double?,
    var morn: Double?,
    var night: Double?
)

@Serializable
data class Weather(
    var description: String?,
    var icon: String?,
    var id: Int?,
    var main: String?
)