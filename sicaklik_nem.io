#define BLYNK_PRINT Serial
#include <ESP8266WiFi.h>
#include <BlynkSimpleEsp8266.h>
#include <SimpleTimer.h>
#include <DHT.h>

char auth[] = "blynk uygulamasindan alinan auth token";
char ssid[] = "Wifi Adi";
char pass[] = "Wifi Sifresi";

#define DHTPIN 5
#define DHTTYPE DHT11
int alarmPin = 4;
int led1 = 16;
int led2 = 14;

DHT dht(DHTPIN, DHTTYPE);
SimpleTimer timer;

void sendSensor() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  if (isnan(h) || isnan(t)) {
    Serial.println("Hata! Sıcaklık ve Nem Sensörü Okunamadı.");
    return;
  }

  Serial.println(t);
  Blynk.virtualWrite(V5, h);
  Blynk.virtualWrite(V6, t);

  if (t > 31) {
    Blynk.email("vaduva.ionut.mailadresiniz@gmail.com", "Sıcaklık Alarmı", "Sıcaklık 31C'yi geçti!");
    Blynk.notify("Sıcaklık Alarmı - Sıcaklık 31C'yi geçti!");
  }
}

void setup() {
  Serial.begin(9600);
  Blynk.begin(auth, ssid, pass);
  dht.begin();
  timer.setInterval(2500L, sendSensor);
}

void loop() {
  Blynk.run();
  timer.run();
}