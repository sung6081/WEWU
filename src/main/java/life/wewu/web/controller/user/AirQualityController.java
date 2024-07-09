package life.wewu.web.controller.user;

import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import life.wewu.web.service.user.AirQualityService;

import java.io.IOException;

@Controller
@RequestMapping("/graph/*")
public class AirQualityController {

    @Autowired
    private AirQualityService airQualityService;

    @GetMapping("/airquality")
    @ResponseBody
    public String getAirQuality() {
        try {
            String data = airQualityService.getAirQualityData();
            return data; // JSON 데이터를 그대로 반환
        } catch (IOException e) {
            e.printStackTrace();
            return "{\"error\": \"Error fetching data: " + e.getMessage() + "\"}";
        }
    }
}