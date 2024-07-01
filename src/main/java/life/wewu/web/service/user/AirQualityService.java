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
import org.springframework.stereotype.Service;

@Service
public class AirQualityService {

    @Value("${env.key}")
    private String eskey;

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
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        return filterEveryThreeHours(sb.toString());
    }

    private String filterEveryThreeHours(String jsonData) {
        JSONObject jsonResponse = new JSONObject(jsonData);
        JSONObject response = jsonResponse.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONArray items = body.getJSONArray("items");
        JSONArray filteredItems = new JSONArray();

        for (int i = 0; i < items.length(); i += 3) { // 3시간 간격으로 데이터 선택
            filteredItems.put(items.getJSONObject(i));
        }

        body.put("items", filteredItems);
        return jsonResponse.toString();
    }
}
