<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.net.*,java.nio.charset.StandardCharsets,java.util.*,com.alibaba.fastjson2.JSON" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userText = request.getParameter("userText");

    String systemPrompt = "你是采购单解析助手，严格遵守规则：\n"
            + "1. 仅提取5个字段：dept(申请部门)、item(物资名称)、spec(规格)、num(采购数量，纯整数数字)、usage(采购用途)\n"
            + "2. 用户输入里的预算、金额、总价、费用、多少钱全部忽略，绝对不要输出预算相关内容\n"
            + "3. 输出只能是一段纯净JSON，不能加任何解释文字、换行、注释、前言后语\n"
            + "4. 用户没提到的字段填空字符串，num必须是整数，无数量默认填1\n"
            + "标准返回示例：{\"dept\":\"办公室\",\"item\":\"打印纸\",\"spec\":\"A4\",\"num\":10,\"usage\":\"办公室日常打印使用\"}";

    String apiKey = "sk-a4eba673690b4eb89d2e807f9ca0bf56";
    String apiUrl = "https://api.deepseek.com/v1/chat/completions";

    Map<String,Object> msgSys = new HashMap<>();
    msgSys.put("role","system");
    msgSys.put("content",systemPrompt);

    Map<String,Object> msgUser = new HashMap<>();
    msgUser.put("role","user");
    msgUser.put("content",userText);

    List<Object> msgList = new ArrayList<>();
    msgList.add(msgSys);
    msgList.add(msgUser);

    Map<String,Object> reqMap = new HashMap<>();
    reqMap.put("model","deepseek-chat");
    reqMap.put("messages",msgList);
    reqMap.put("temperature",0.1);

    String reqJson = JSON.toJSONString(reqMap);
    String aiResult = "";

    try{
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setDoOutput(true);
        // 超时防止卡死
        conn.setConnectTimeout(8000);
        conn.setReadTimeout(8000);

        OutputStream os = conn.getOutputStream();
        os.write(reqJson.getBytes(StandardCharsets.UTF_8));
        os.flush();
        os.close();

        int code = conn.getResponseCode();
        StringBuilder sb = new StringBuilder();
        if (code == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            br.close();
        } else {
            BufferedReader errBr = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
            String line;
            while ((line = errBr.readLine()) != null) {
                sb.append(line);
            }
            errBr.close();
        }
        conn.disconnect();

        String respStr = sb.toString();
        Map<String, Object> resMap = JSON.parseObject(respStr);

        // 关键修复：判断choices是否存在且不为空
        List<Object> choices = (List<Object>) resMap.get("choices");
        if(choices == null || choices.size() == 0){
            Map<String,Object> errMap = new HashMap<>();
            errMap.put("code",500);
            errMap.put("msg","AI接口返回无数据，密钥错误或接口限流");
            out.print(JSON.toJSONString(errMap));
            return;
        }

        Map<String, Object> choice = (Map<String, Object>) choices.get(0);
        Map<String, String> msg = (Map<String, String>) choice.get("message");
        aiResult = msg.get("content").trim();

    }catch(Exception e){
        e.printStackTrace();
        Map<String,Object> errMap = new HashMap<>();
        errMap.put("code",500);
        errMap.put("msg","AI接口调用失败："+e.getMessage());
        out.print(JSON.toJSONString(errMap));
        return;
    }

    out.print(aiResult);
%>