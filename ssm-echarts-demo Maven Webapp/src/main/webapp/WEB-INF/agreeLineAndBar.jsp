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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/echarts.js"></script>
<body>
	<!-- 显示Echarts图表 -->
	<div style="height:410px;min-height:100px;margin:0 auto;" id="main"></div>
	<script type="text/javascript">
		// 基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('main'));
	
		// 指定图表的配置项和数据
		var option = {
			//标题
			title : { //图表标题
				text : '知乎前10赞同数', //主标题
				subtext : 'SSM实现知乎前10赞同数统计', //副标题
			//borderColor : 'red', //边框颜色
			//borderWidth : 10, //边框宽度
			// Left
			},
			tooltip : {
				trigger : 'axis', //坐标轴触发提示框，多用于柱状、折线图中
	
			},
			//缩放视图
			dataZoom : [
				{
					type : 'slider', //支持鼠标滚轮缩放
					start : 0, //默认数据初始缩放范围为10%到90%
					end : 100
				},
				{
					type : 'inside', //支持单独的滑动条缩放
					start : 0, //默认数据初始缩放范围为10%到90%
					end : 100
				}
			],
			//图例
			legend : { //图表上方的类别显示           	
				show : true,
				data : [ '赞同数', ]
			},
			color : [
				'#FF3333', //曲线颜色
			],
			toolbox : {
				feature : {
					//dataView:数据视图
					dataView : {
						show : true,
						readOnly : false
					},
					//动态类型切换
					magicType : {
						show : true,
						type : [ 'line', 'bar' ]
					},
					//还原
					restore : {
						show : true
					},
					//保存图片选项
					saveAsImage : {
						show : true
					}
				}
			},
			xAxis : { //X轴       	
				type : 'category',
				data : [] //先设置数据值为空，后面用Ajax获取动态数据填入
			},
			yAxis : [
				{
					type : 'value',
					name : '赞同数',
					/* max: 120,
					min: -40, */
					//yAxis.scale:boolean 是否是脱离 0 值比例。设置成 true 后坐标刻度不会强制包含零刻度。在双数值轴的散点图中比较有用。在设置 min 和 max 之后该配置项无效
					scale : false,
					axisLabel : {
						//xAxis.axisLabel.formatter string, Function: 刻度标签的内容格式器，支持字符串模板和回调函数两种形式。
						//formatter : '{value} ℃ ', //控制输出格式，也就是坐标轴显示的格式 [ default: null ]
						margin : 10, //刻度标签与轴线之间的距离。[ default: 8 ]
	
					}
				}
	
			],
			//series[i]:系列列表。每个系列通过 type 决定自己的图表类型
			series : [ //系列（内容）列表                      
				{
					name : '赞同数',
					type : 'line', //折线图表示（生成温度曲线）
					symbol : 'emptycircle', //设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形	                    
					data : [], //数据值通过Ajax动态获取
					//图标上显示出最大值和最小值
					markPoint : {
						data : [ {
							type : 'max',
							name : '最大值'
						}, {
							type : 'min',
							name : '最小值'
						} ],
					},
					//图标上显示平局值
					markLine : {
						data : [ {
							type : 'average',
							name : '平均值'
						} ]
					}
				},
			]
		};
		//数据加载完之前先显示一段简单的loading动画,在数据加载完成后调用 hideLoading 隐藏加载动画。
		//下面ajax请求成功获取数据后，调用了hideLoading 隐藏加载动画
		myChart.showLoading();
	
		var names = []; //姓名
		var nums = []; //赞同数
	
	
		$.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "${pageContext.request.contextPath}/echarts/agreeLineAndBar", //请求发送到TestServlet处
			data : {},
			dataType : "json", //返回数据形式为json
			success : function(result) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (result) {
					for (var i = 0; i < result.length; i++) {
						names.push(result[i].username); //挨个取出类别并填入类别数组
					}
					for (var i = 0; i < result.length; i++) {
						nums.push(result[i].agrees); //挨个取出销量并填入销量数组
					}
					myChart.hideLoading(); //隐藏加载动画
					myChart.setOption({ //加载数据图表
						xAxis : {
							data : names
						},
						series : [ {
							// 根据名字对应到相应的系列
							name : '赞同数量',
							data : nums
						} ]
					});
	
				} else {
					//返回的数据为空时显示提示信息
					alert("图表请求数据为空，可能服务器暂未录入近五天的观测数据，您可以稍后再试！");
					myChart.hideLoading();
				}
	
			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败，可能是服务器开小差了");
				myChart.hideLoading();
			}
		})
	
		myChart.setOption(option); //载入图表
	</script>
</body>
</html>
