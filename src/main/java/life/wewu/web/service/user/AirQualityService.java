package life.wewu.web.service.user;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

@Service
public class AirQualityService {

    @Value("${env.key}")
    private String eskey;

    @Cacheable("airQualityData")
    public String getAirQualityData() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + eskey); // Service Key
        urlBuilder.append("&" + URLEncoder.encode("returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("itemCode", "UTF-8") + "=" + URLEncoder.encode("PM10", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("dataGubun", "UTF-8") + "=" + URLEncoder.encode("HOUR", "UTF-8"));

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        BufferedReader rd;
        StringBuilder sb = new StringBuilder();
        try {
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            String line;
            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
        } catch (IOException e) {
            // API 호출 실패 시 임의 데이터 반환
            return getDefaultAirQualityData();
        } finally {
            conn.disconnect();
        }

        String rawJsonData = sb.toString();
        System.out.println("Raw JSON Data: " + rawJsonData);

        if (!rawJsonData.trim().startsWith("{")) {
            System.out.println("Invalid JSON format: " + rawJsonData);
            return getDefaultAirQualityData();
        }

        return filterEveryThreeHours(rawJsonData);
    }

    private String filterEveryThreeHours(String jsonData) {
        JSONObject jsonResponse = new JSONObject(jsonData);
        JSONObject response = jsonResponse.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONArray items = body.getJSONArray("items");
        JSONArray filteredItems = new JSONArray();

        for (int i = 0; i < items.length(); i += 3) {
            filteredItems.put(items.getJSONObject(i));
        }

        body.put("items", filteredItems);
        return jsonResponse.toString();
    }

    private String getDefaultAirQualityData() {
        // 임의 데이터 반환
        return "{ \"response\": { \"body\": { \"items\": [" +
                "{ \"dataTime\": \"2024-07-03 10:00\", \"seoul\": 50, \"busan\": 40, \"daegu\": 30, \"incheon\": 20 }," +
                "{ \"dataTime\": \"2024-07-03 13:00\", \"seoul\": 60, \"busan\": 45, \"daegu\": 35, \"incheon\": 25 }," +
                "{ \"dataTime\": \"2024-07-03 16:00\", \"seoul\": 55, \"busan\": 42, \"daegu\": 32, \"incheon\": 22 }," +
                "{ \"dataTime\": \"2024-07-03 19:00\", \"seoul\": 65, \"busan\": 47, \"daegu\": 37, \"incheon\": 27 }," +
                "{ \"dataTime\": \"2024-07-03 22:00\", \"seoul\": 70, \"busan\": 50, \"daegu\": 40, \"incheon\": 30 }," +
                "{ \"dataTime\": \"2024-07-04 01:00\", \"seoul\": 75, \"busan\": 55, \"daegu\": 45, \"incheon\": 35 }," +
                "{ \"dataTime\": \"2024-07-04 04:00\", \"seoul\": 80, \"busan\": 60, \"daegu\": 50, \"incheon\": 40 }," +
                "{ \"dataTime\": \"2024-07-04 07:00\", \"seoul\": 85, \"busan\": 65, \"daegu\": 55, \"incheon\": 45 }," +
                "{ \"dataTime\": \"2024-07-04 10:00\", \"seoul\": 90, \"busan\": 70, \"daegu\": 60, \"incheon\": 50 }," +
                "{ \"dataTime\": \"2024-07-04 13:00\", \"seoul\": 95, \"busan\": 75, \"daegu\": 65, \"incheon\": 55 }" +
                "] } } }";
    }
}
