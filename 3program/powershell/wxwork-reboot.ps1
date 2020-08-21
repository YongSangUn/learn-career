$json = {
    "msgtype"= "markdown",
    "markdown": {
        "content": "实时新增用户反馈<font color=\"warning\">132例</font>，请相关同事注意。\n
         >类型:<font color=\"comment\">用户反馈</font>
         >普通用户反馈:<font color=\"comment\">117例</font>
         >VIP用户反馈:<font color=\"comment\">15例</font>"
    }
}

$key = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=03ce50c6-a2d9-4d20-83e5-2d2f00761788"
Invoke-WebRequest -Uri $Key -Body $json -Method 'POST' -Headers @{'Content-Type' = 'application/json' }