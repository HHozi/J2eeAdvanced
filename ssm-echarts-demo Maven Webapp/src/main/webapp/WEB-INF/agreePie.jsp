<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'showStudentInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!-- 知乎前10赞同数，用圆饼图展示 -->
</head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/echarts.js"></script>
<body>
	<!-- 显示Echarts图表 -->
	<div style="height:410px;min-height:100px;margin:0 auto;" id="main"></div>
	<script>	//初始化echarts var pieCharts =
		//初始化echarts
		var pieCharts = echarts.init(document.getElementById("main"));
		//设置属性
		pieCharts.setOption({
			title : {
				text : '赞同数',
				subtext : '赞同数比',
				x : 'center'
			},
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				x : 'left',
				data : []
			},
			toolbox : {
				show : true,
				feature : {
					mark : {
						show : true
					},
					//数据视图
					dataView : {
						show : true,
						readOnly : false
					},
					restore : {
						show : true
					},
					//是否可以保存为图片
					saveAsImage : {
						show : true
					}
				}
			},
			calculable : true,
			series : [
				{
					name : '赞同数',
					type : 'pie',
					radius : '55%',
					center : [ '50%', '60%' ],
					data : []
				}
			]
		});
	
	
		//显示一段动画
		pieCharts.showLoading();
	
		//异步请求数据
		$.ajax({
			type : "post",
			async : true,
			url : '${pageContext.request.contextPath}/echarts/agreePie',
			data : [],
			dataType : "json",
			success : function(result) {
				if (result) {
					pieCharts.hideLoading(); //隐藏加载动画
					pieCharts.setOption({
						series : [
							{
								data : result
							}
						]
					});
				} else {
					//返回的数据为空时显示提示信息
					alert("图表请求数据为空，可能服务器暂未录入近五天的观测数据，您可以稍后再试！");
					pieCharts.hideLoading();
				}
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败，可能是服务器开小差了");
				pieCharts.hideLoading();
			}
		})
	</script>
</body>
</html>
