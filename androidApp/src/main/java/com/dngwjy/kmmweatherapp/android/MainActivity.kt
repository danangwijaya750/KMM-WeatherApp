package com.dngwjy.kmmweatherapp.android

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.dngwjy.kmmweatherapp.Greeting
import android.widget.TextView
import android.widget.Toast
import com.dngwjy.kmmweatherapp.data.WeatherResponse
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {

    private val greet=Greeting()
    private val scope=MainScope()


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        val tvCity=findViewById<TextView>(R.id.tv_city)
        tvCity.text="Yogyakarta, ID"
        scope.launch {
            kotlin.runCatching {
                greet.getOneCall("-7.810698","110.450541")
            }.onSuccess {
               bindData(it)
            }.onFailure {
                Toast.makeText(this@MainActivity, it.message, Toast.LENGTH_SHORT).show()
            }
        }
    }
    private fun bindData(data:WeatherResponse){
        val tvFeels=findViewById<TextView>(R.id.tv_temp)
        tvFeels.text= "${data.current.feels_like.toString()}°"
    }


}
