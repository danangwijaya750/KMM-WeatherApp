import SwiftUI
import shared

struct ContentView: View {
    @State var greet="Loading"
    @State private var isNight: Bool = false
    @State var responseData : WeatherResponse? = nil
    @State var dailyWeather = [Daily]()
    
    func load(){
        Greeting().greeting { result, error in
            if let result = result {
                self.greet = result
            }else if let error = error{
                greet = "Error \(error)"
            }
        }
    }
    func getOneCall(){
        Greeting().getOneCall(lat: "-7.810698", lng: "110.450541") { data, error in
            if let data = data{
                self.responseData=data
                data.daily?.forEach({ item in
                    self.dailyWeather.append(Daily( data: item))
                })
            }else if let error = error{
                greet = "Error \(error)"
            }
        }
    }
    
    func getIcon(weather:Int) -> String {
        print(weather)
        if( weather>=200 && weather<300){
            return "cloud.bolt.rain.fill"
        }else if(weather>=300 && weather<500){
            return "cloud.drizzle.fill"
        }else if(weather>=500 && weather<600){
            return "cloud.heavyrain.fill"
        }else if(weather>=600 && weather<700){
            return "cloud.sleet.fill"
        }else if(weather>=700 && weather<800){
            return "sun.haze.fill"
        }else if(weather>=800){
            return "sun.max.fill"
        }
        return "cloud.fill"
    }

	var body: some View {
        ZStack{
            BackgroundView(isNight: $isNight)
            VStack{
                cityTextView(cityName:"Yogyakarta, ID")
                mainWeatherView(imageName:
                                    getIcon(weather:Int(truncating: responseData?.current.weather?[0].id ?? 200)),
                                temperature: responseData?.current.feels_like ?? 0.0)
                HStack{
                ForEach(dailyWeather) {item in
                    WeatherDayView(dayOfWeek:Int(truncating: item.data?.dt ?? 0) ,
                                   ImageName:  getIcon(weather:Int(truncating: item.data?.weather?[0].id ?? 200)),
                                   temperature: item.data?.feels_like?.day)
                }.padding()
                }
                
            }.onAppear {
                getOneCall()
            }
        }
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct BackgroundView: View{
    @Binding var isNight: Bool
    var body: some View{
        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
    }
}

struct cityTextView:View{
    var cityName: String
    var body: some View{
        Text(cityName)
            .foregroundColor(.white)
            .font(.system(size: 32, weight: .medium, design: .default))
            .padding()
    }
}

struct WeatherDayView: View{
    var dayOfWeek : Int
    var ImageName : String
    var temperature : KotlinDouble?
    
    func getDayName(dt:Int)->String{
        let date = (dt*1000).dateFromMilliseconds(format: "yyy-MM-dd")
        print(date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    
    var body: some View{
        VStack{
            Text(getDayName(dt:dayOfWeek))
                .foregroundColor(.white)
                .font(.system(size: 12))
            Image(systemName: ImageName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text("\(temperature ?? 0.0)°")
                .foregroundColor(.white)
        }
    }
}

struct mainWeatherView: View{
    var imageName: String
    var temperature: KotlinDouble
    var body: some View{
        VStack(spacing: 8){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(temperature)°")
                .foregroundColor(.white)
                .font(.system(size: 70, weight: .medium))
        }.padding(.bottom,40)
    }
}


