# $a = ConvertTo-Json (@{
#         msgtype = "text"
#         text    = @{
#             content = "爱学习a"
#         }
#     })
# [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# $text = @"
# <font color="warning">132 new pieces of feedback </font> received in real time. Please deal with them as soon as possible.
# > Type:<font color="comment">Feedback from users</font>
# > Feedback from common users:<font color="comment">117 For example</font>
# > VIP users' feedback:<font color="comment">15 For example</font>
# "@

$text = @"
## <font color="warning">132 新的反馈</font> 实时接收，请尽快处理。
> 类型: <font color="comment">用户反馈</font>
> 普通用户的反馈: <font color="comment">117 例子</font>
> VIP用户的反馈: <font color="comment">15 例子</font>
"@


$text
$json = ConvertTo-Json (@{
        msgtype  = "markdown"
        markdown = @{
            content = $text
        }
    })

$key = "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=03ce50c6-a2d9-4d20-83e5-2d2f00761788"
Invoke-WebRequest -Uri $key -Method 'Post' -Body $json -ContentType "application/json;charset=utf-8"
