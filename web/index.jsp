<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2018/10/15
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>验证码测试页面</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
        function changeVerifyCode(code) {
            // 点击切换验证码
            code.src = "Kaptcha.jpg?time=" + Math.floor(Math.random()*100);
        }

        // 提交
        function doSubmit() {
            var verifyCodeValue = $("#verifyCode").val();
            if(verifyCodeValue.replace(/\s/g,"") == "") {
                alert("请输入验证码");
            }else {
                //提交前先异步检查验证码是否输入正确
                var verifyUrl = "${pageContext.request.contextPath}/servlet/VerifyServlet?verifyCode="+verifyCodeValue;
                $.ajax({
                    type:"GET",
                    url:verifyUrl,
                    success:function(returnData){
                        if(returnData!="Y") {
                            alert("请输入正确的验证码！");
                        }else {
                            //验证码正确，进行提交操作
                            alert("验证码输入正确，提交表单");
                        }
                    },
                    error:function(e){
                        alert(e);
                    }
                });
            }
    </script>
</head>
<body>

<form>
    <table>
        <tr>
            <td>
                请输入验证码：
            </td>
            <td>
                <input type="text" name="verifyCode" id="verifyCode"/>
                <img id="yzmImg" alt="验证码" src="Kaptcha.jpg" onclick="changeVerifyCode(this)" style="cursor: pointer;"/>
            </td>
        </tr>
        <tr>
            <td>
            &nbsp;
            </td>
            <td>
                <input type="button" value="提交" onclick="service()">
            </td>
        </tr>
    </table>
</form>

</body>
</html>