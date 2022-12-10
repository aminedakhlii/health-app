from pydantic import BaseModel
from typing import List 
from statistics import mean

class FitBitData(BaseModel):
    heartRate :List[int]
    temperature :List [int]
    calories :List[int]
    hoursSlept : List[int]
    oxygenSaturation :List[int]
    breathingRate: List[int]
    bloodPressure: List[int]
    labels: List[str]

    def getLabels(self):
        labels = []
        if self.isHighHeartRate():
            labels.append("High Heart Rate")
        if self.isLowHeartRate():
            labels.append("Low Heart Rate")
        if self.isHighTemperature():
            labels.append("High Temperature")
        if self.isLowTemperature():
            labels.append("Low Temperature")
        if self.isHighCalories():
            labels.append("High Calories")
        if self.isLowCalories():
            labels.append("Low Calories")
        if self.isHighHoursSlept():
            labels.append("High Hours Slept")
        if self.isLowHoursSlept():
            labels.append("Low Hours Slept")
        if self.isLowOxygenSaturation():
            labels.append("Low Oxygen Saturation")
        if self.isHighBreathingRate():
            labels.append("High Breathing Rate")
        if self.isHighBloodPressure():
            labels.append("High Blood Pressure")
        if self.isLowBloodPressure():
            labels.append("Low Blood Pressure")
        self.labels=labels
        return labels


    def isHighHeartRate(self):
        return mean(self.heartRate[-3:]) > 100
    
    def isLowHeartRate(self):
        return mean(self.heartRate[-3:]) < 60
    
    def isHighTemperature(self):
        return mean(self.temperature[-3:]) > 37
    
    def isLowTemperature(self):
        return mean(self.temperature[-3:]) < 35
    
    def isHighCalories(self):
        return mean(self.calories[-3:]) > 2000
    
    def isLowCalories(self):
        return mean(self.calories[-3:]) < 1000
    
    def isHighHoursSlept(self):
        return mean(self.hoursSlept[-3:]) > 8
    
    def isLowHoursSlept(self):
        return mean(self.hoursSlept[-3:]) < 4
    
    def isLowOxygenSaturation(self):
        return mean(self.oxygenSaturation[-3:]) < 90
    
    def isHighBreathingRate(self):
        return mean(self.breathingRate[-3:]) > 20
    
    def isHighBloodPressure(self):
        return mean(self.bloodPressure[-3:]) > 120
    
    def isLowBloodPressure(self):
        return mean(self.bloodPressure[-3:]) < 80
    
