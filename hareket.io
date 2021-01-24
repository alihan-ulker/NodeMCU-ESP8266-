#include <ESP8266WiFi.h>
#define BLYNK_PRINT Serial 
#include <BlynkSimpleEsp8266.h>
char auth[] = "blynk uygulamasindan alinan auth token";

char ssid[] = "Wifi Adi";
char pass[] = "Wifi Sifresi";

#define ledPin D7 
#define pirPin D1 
int pirValue; 

void setup()
{
  Serial.begin(115200);
  delay(100);
  Blynk.begin(auth, ssid, pass);
  pinMode(ledPin, OUTPUT);
  pinMode(pirPin, INPUT);
  digitalWrite(ledPin, LOW);
}

void loop()
{
  getPirValue();
  Blynk.run();
  delay(3000);
}

void getPirValue(void)
{
  pirValue = digitalRead(pirPin);
  if (pirValue) 
  { 
    Serial.println("==> Hareket Algılandı.");
    Blynk.notify("T==> Hareket Algılandı.");  
  }
 // else Serial.println("==> Herhangi bir hareket algılanamadı.");
  
  digitalWrite(ledPin, pirValue);
  if (Serial.println(("==> Hareket Algılandı."))) {
    Blynk.email("vaduva.ionut.mailadresiniz@gmail.com", "Hareket Alarmı", "Hareket Algılandı!");
    Blynk.notify("Hareket Alarmı - Hareket Algılandı!");
  }
}