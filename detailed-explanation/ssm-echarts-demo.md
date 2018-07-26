![知乎赞同数Top10](https://user-gold-cdn.xitu.io/2018/7/24/164cb3b1675fb2c6)
## 一 前言

### 1.1  60w知乎网名的数据从何而来？
去年在接触Java爬虫的时候，接触到了一个关于知乎的爬虫。个人觉得写的非常好，当时抓取的效率和成功率还是特别特别高，现在可能知乎反扒做的更好，这个开源知乎爬虫没之前抓取的那么顺利了。我记得当时在我的i7+8g的机器上爬了将近两天，大概爬取了**60多w**的数据。当然，实际抓取的用户数据数量肯定比这个多，只是持久化过程不同步而已，也就是抓取的好几个用户可能只有一个存入数据库中。

最后，本文提供的知乎网名数据是2017年12月份左右抓取的数据。

**60w知乎网名数据：**

链接：[https://pan.baidu.com/s/1pEcHAbRyKP7KGcgTuZfPVA](https://pan.baidu.com/s/1pEcHAbRyKP7KGcgTuZfPVA) 密码：l3so

**项目源码地址(如果觉得 有帮助的话，欢迎给个Star.)：** 

[https://github.com/Snailclimb/J2ee-Advanced](https://github.com/Snailclimb/J2ee-Advanced) （Java Web进阶学习的一些源码加详细讲解）

### 1.2 通过本篇文章你能学到什么？

1. SSM环境的搭建；
2. 如何在SSM项目中使用Echarts


### 1.3 效果图展示
细心的同学会发现，我其实只从数据库抓取了9条数据出来。因为我的SQL语句写错了（逃....），大家可以自己修改Mapper文件。

![效果图](https://user-gold-cdn.xitu.io/2018/7/24/164c9eae98b91b29?w=1370&h=649&f=gif&s=809749)

## 二 SSM环境搭建
声明一下，笔主使用的是MyEclipse2016(主要是为了暑假做的项目的编码环境的统一，所以我选择了MyEclipse2016)。

### 2.1 项目结构

![项目结构](https://user-gold-cdn.xitu.io/2018/7/24/164c9fd64fbc9389?w=266&h=480&f=png&s=22080)

### 2.2  配置文件

#### 2.3.1 pom.xml
需要的jar包，都在这里配置好。另外我配置了一个Tomcat插件，这样就可以通过Maven Build的方式来运行项目了。具体运行方式如下：

**右键项目->run as -> Maven build**
![Maven build的方式运行项目](https://user-gold-cdn.xitu.io/2018/7/24/164ca5f92458cd54?w=888&h=384&f=png&s=46946)

**然后输入tomcat7:run后点击run即可**
![运行](https://user-gold-cdn.xitu.io/2018/7/24/164ca60dff46deeb?w=800&h=640&f=png&s=41248)

**这里提一点：@ResponseBody注解要把对象转换成json格式，所以需要添加相关转换依赖的jar包（jackson）**

**pom.xml**

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>spring</groupId>
	<artifactId>ssm-echarts-demo</artifactId>
	<packaging>war</packaging>
	<version>0.0.1-SNAPSHOT</version>
	<name>ssm-echarts-demo Maven Webapp</name>
	<url>http://maven.apache.org</url>
	<properties>
		<webVersion>3.0</webVersion>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<!-- spring版本号 -->
		<spring.version>4.0.0.RELEASE</spring.version>
		<!-- log4j日志文件管理包版本 -->
		<!-- <slf4j.version>1.6.6</slf4j.version> <log4j.version>1.2.12</log4j.version> -->
		<!-- mybatis版本号 -->
		<mybatis.version>3.1.1</mybatis.version>
		<!-- aspectJ版本号 -->
		<aspectJ.version>1.7.4</aspectJ.version>
		<!-- 数据库连接池版本号 -->
		<commons-dbcp.version>1.4</commons-dbcp.version>
		<commons-pool.version>1.6</commons-pool.version>
		<!-- jackson的版本号 json和xml解析 -->
		<jackson.version>2.8.9</jackson.version>
		<!-- mybatis/spring包的版本号 -->
		<mybatis-spring.version>1.1.1</mybatis-spring.version>
		<!-- mysql的版本号 -->
		<mysql.version>5.1.29</mysql.version>
		<!-- jstl的版本号 -->
		<jstl.version>1.2.1</jstl.version>
		<!-- 文件上传用的包 的版本号 -->
		<commons-fileupload.version>1.3.1</commons-fileupload.version>
		<commons-io.version>2.4</commons-io.version>
		<!-- 数据校验使用的包的版本号 -->
		<validation-api.version>2.0.0.Final</validation-api.version>
		<hibernate-validator.version>5.4.1.Final</hibernate-validator.version>
	</properties>
	<dependencies>
		<!-- 单元测试 -->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.12</version>
			<scope>test</scope>
		</dependency>
		<!-- -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>4.0.0.RELEASE</version>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>commons-logging</groupId>
			<artifactId>commons-logging</artifactId>
			<version>1.1.3</version>
		</dependency>
		<dependency>
			<groupId>commons-collections</groupId>
			<artifactId>commons-collections</artifactId>
			<version>3.2.1</version>
		</dependency>
		<!-- jstl -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>

		<!-- mybatis -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>${mybatis.version}</version>
		</dependency>
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>${mybatis-spring.version}</version>
		</dependency>
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>${mysql.version}</version>
		</dependency>
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>druid</artifactId>
			<version>0.2.23</version>
		</dependency>
		<!-- spring -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-core</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjrt</artifactId>
			<version>${aspectJ.version}</version>
		</dependency>
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjweaver</artifactId>
			<version>${aspectJ.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-aop</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-tx</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-web</artifactId>
			<version>${spring.version}</version>
		</dependency>

		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context-support</artifactId>
			<version>${spring.version}</version>
		</dependency>
		<!-- Jackson -->
		<dependency>
			<groupId>com.google.code.gson</groupId>
			<artifactId>gson</artifactId>
			<version>2.8.5</version>
		</dependency>
		<dependency>
			<groupId>org.codehaus.jackson</groupId>
			<artifactId>jackson-mapper-asl</artifactId>
			<version>1.9.13</version>
		</dependency>
		<dependency>
			<groupId>com.alibaba</groupId>
			<artifactId>fastjson</artifactId>
			<version>1.2.3</version>
		</dependency>
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-annotations</artifactId>
			<version>${jackson.version}</version>
		</dependency>
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-core</artifactId>
			<version>${jackson.version}</version>
		</dependency>
		<dependency>
			<groupId>com.fasterxml.jackson.core</groupId>
			<artifactId>jackson-databind</artifactId>
			<version>${jackson.version}</version>
		</dependency>
		<!-- 解决.jsp出错 -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>javax.servlet-api</artifactId>
			<version>3.1.0</version>
			<scope>provided</scope>
		</dependency>
		<!-- 连接池 -->
		<dependency>
			<groupId>commons-dbcp</groupId>
			<artifactId>commons-dbcp</artifactId>
			<version>${commons-dbcp.version}</version>
		</dependency>
		<dependency>
			<groupId>commons-pool</groupId>
			<artifactId>commons-pool</artifactId>
			<version>${commons-pool.version}</version>
		</dependency>
		<!-- 文件上传用的包 -->
		<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>${commons-fileupload.version}</version>
		</dependency>
		<dependency>
			<groupId>commons-io</groupId>
			<artifactId>commons-io</artifactId>
			<version>${commons-io.version}</version>
		</dependency>
		<!-- 数据校验 -->
		<dependency>
			<groupId>javax.validation</groupId>
			<artifactId>validation-api</artifactId>
			<version>${validation-api.version}</version>
		</dependency>
		<dependency>
			<groupId>org.hibernate</groupId>
			<artifactId>hibernate-validator</artifactId>
			<version>${hibernate-validator.version}</version>
		</dependency>

	</dependencies>
	<build>
		<finalName>ssm-echarts-demo</finalName>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>2.3.2</version>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.tomcat.maven</groupId>
				<artifactId>tomcat7-maven-plugin</artifactId>
				<configuration>
					<path>/</path>
					<port>8082</port>
				</configuration>
			</plugin>
			<plugin>
				<artifactId>maven-war-plugin</artifactId>
				<version>2.6</version>
				<configuration>
					<failOnMissingWebXml>false</failOnMissingWebXml>
				</configuration>
			</plugin>
		</plugins>
		<!--资源文件打包 -->
		<resources>
			<resource>
				<directory>src/main/resources</directory>
				<includes>
					<include>**/*.properties</include>
					<include>**/*.xml</include>
					<include>**/*.tld</include>
				</includes>
				<filtering>false</filtering>
			</resource>
			<resource>
				<directory>src/main/java</directory>
				<includes>
					<include>**/*.properties</include>
					<include>**/*.xml</include>
					<include>**/*.tld</include>
				</includes>
				<filtering>false</filtering>
			</resource>
		</resources>
	</build>
</project>

```

#### 2.3.2 Spring相关配置文件：

由于Spring配置较多所以我这里分了4层，分别是dao、service、transaction、web。

**applicationContext-dao.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-4.0.xsd
        http://www.springframework.org/schema/tx 
        http://www.springframework.org/schema/tx/spring-tx-4.2.xsd
        http://www.springframework.org/schema/aop    
        http://www.springframework.org/schema/aop/spring-aop-4.0.xsd">
	<!-- 加载数据库属性文件，为配置数据源做准备 -->
	<context:property-placeholder location="classpath:db.properties" />
	<!-- bean采用注解式注入 -->
	<context:annotation-config></context:annotation-config>
	<!-- 配置数据源 使用dbcp -->
	<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource"
		destroy-method="close">
		<property name="driverClassName" value="${jdbc.driverClassName}" />
		<property name="url" value="${jdbc.url}" />
		<property name="username" value="${jdbc.username}" />
		<property name="password" value="${jdbc.password}" />
		<property name="maxActive" value="10" />
		<property name="maxIdle" value="5" />
	</bean>
	<!-- =================================MyBatis的整合====================================== -->
	<!-- 配置mybatis的SqlSessionFactoryBean -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
		<!-- 指定mybatis 全局配置文件的位置 -->
		<property name="configLocation" value="classpath:mybatis/spring-mybatis.xml"></property>
		<property name="dataSource" ref="dataSource"></property>
	</bean>

	<!-- mapper配置: mapper批量处理，从mapper包中扫描mapper接口，自动创建代理对象并且在spring容器中注册 遵循规范：将mapper.java和mapper.xml映射文件名称保持一致，且在一个目录中自动扫描 
		出来的mapper的bean的id为mapper类名（首字母小写） -->
	<bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
		<property name="basePackage" value="com.snailclimb.dao"></property>
		<property name="sqlSessionFactoryBeanName" value="sqlSessionFactory"></property>
	</bean>


</beans>
```

**applicationContext-service.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
	xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context-4.0.xsd
        http://www.springframework.org/schema/tx 
        http://www.springframework.org/schema/tx/spring-tx-4.2.xsd
        http://www.springframework.org/schema/aop    
        http://www.springframework.org/schema/aop/spring-aop-4.0.xsd">
	<!-- 用户管理service -->
	<context:component-scan base-package="com.snailclimb.service.impl"></context:component-scan>
</beans>
```

**applicationContext-trans.xml:**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:context="http://www.springframework.org/schema/context" xmlns:p="http://www.springframework.org/schema/p"
	xmlns:aop="http://www.springframework.org/schema/aop" xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
	http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.0.xsd
	http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-4.0.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-4.0.xsd
	http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-4.0.xsd">

	<!--事务管理器 -->
	<bean id="transactionManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	<!--通知 -->
	<tx:advice id="txAdvice" transaction-manager="transactionManager">

		<tx:attributes>
			<tx:method name="save*" propagation="REQUIRED" />
			<tx:method name="insert*" propagation="REQUIRED" />
			<tx:method name="add*" propagation="REQUIRED" />
			<tx:method name="create*" propagation="REQUIRED" />
			<tx:method name="delete*" propagation="REQUIRED" />
			<tx:method name="update*" propagation="REQUIRED" />
			<tx:method name="find*" propagation="SUPPORTS" read-only="true" />
			<tx:method name="select*" propagation="SUPPORTS" read-only="true" />
			<tx:method name="get*" propagation="SUPPORTS" read-only="true" />
		</tx:attributes>
	</tx:advice>
	<aop:config>
		<aop:advisor advice-ref="txAdvice"
			pointcut="execution(* com.snailclimb.service.*.*(..))" />
	</aop:config>

</beans>
```

**springmvc.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd
        http://www.springframework.org/schema/context 
        http://www.springframework.org/schema/context/spring-context-4.0.xsd
		http://www.springframework.org/schema/beans
		http://www.springframework.org/schema/beans/spring-beans-4.0.xsd">
	<!-- 配置扫描器：@Controller是@Component的一个子类。@service -->
	<context:component-scan base-package="com.snailclimb.controller"></context:component-scan>

	<!-- 配置注解器： -->
	<mvc:annotation-driven></mvc:annotation-driven>



	<!-- 配置springMVC的视图解析器 -->
	<bean
		class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="viewClass"
			value="org.springframework.web.servlet.view.JstlView" />
		<property name="prefix" value="/WEB-INF/" />
		<property name="suffix" value=".jsp" />
	</bean>
	<!-- 开启shiro注解功能 -->
	<!-- <bean class="org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator" 
		depends-on="lifecycleBeanPostProcessor"> <property name="proxyTargetClass" 
		value="true" /> </bean> <bean class="org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor"> 
		<property name="securityManager" ref="securityManager" /> </bean> -->
	<!-- 全局异常配置 -->
	<!-- <bean class="com.chen.PLoveLibrary.exception.HandleException"></bean> -->
	<!-- 文件上传 -->
	<bean id="multipartResolver"
		class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<!-- 上传文件大小上限，单位为字节（10MB） -->
		<property name="maxUploadSize">
			<value>10485760</value>
		</property>
		<!-- 请求的编码格式，必须和jSP的pageEncoding属性一致，以便正确读取表单的内容，默认为ISO-8859-1 -->
		<property name="defaultEncoding">
			<value>UTF-8</value>
		</property>
	</bean>
	<!-- 配置校验器 ，使用的是hibernate框架的validate，但与hibernate无关 -->
	<bean id="validator"
		class="org.springframework.validation.beanvalidation.LocalValidatorFactoryBean">
		<!-- 校验器，使用hibernate校验器 -->
		<property name="providerClass" value="org.hibernate.validator.HibernateValidator" />
		<!-- 指定校验使用的资源文件，在文件中配置校验错误信息，如果不指定则默认使用classpath下面的ValidationMessages.properties文件 -->
		<property name="validationMessageSource" ref="messageSource" />
	</bean>
	<!-- 校验错误信息配置文件 -->
	<bean id="messageSource"
		class="org.springframework.context.support.ReloadableResourceBundleMessageSource">
		<!-- 资源文件名 -->
		<property name="basenames">
			<list>
				<value>classpath:validateMessage</value>
			</list>
		</property>
		<!-- 资源文件编码格式 -->
		<property name="fileEncodings" value="utf-8" />
		<!-- 对资源文件内容缓存时间，单位秒 -->
		<property name="cacheSeconds" value="120" />
	</bean>

</beans>
```
#### 2.3.3 数据库连接以及log4j配置文件：

Log4J的配置文件(Configuration File)就是用来设置记录器的级别、存放器和布局的，它可接key=value格式的设置或xml格式的设置信息。通过配置，可以创建出Log4J的运行环境。

**log4j.properties**

```
log4j.rootLogger=DEBUG, stdout
log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout
log4j.appender.stdout.layout.ConversionPattern=%d [%-5p] %c - %m%n
```

**db.properties**

```
jdbc.driverClassName=com.mysql.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/spider_zhihu_crawler
jdbc.username=root
jdbc.password=xxxxxx
```
#### 2.3.4 Mybatis配置文件：
**spring-mybatis.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>    
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN"    
"http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<!-- 开启mybatis的缓存机制,开启二级缓存 -->
	<settings>
		<setting name="cacheEnabled" value="true" />
	</settings>

	<!-- mybatis中的别名命名 -->
	<typeAliases>
		<package name="com.snailclimb.bean" />

	</typeAliases>

</configuration>
```
#### 2.3.5 web.xml：
![web.xml配置文件](https://user-gold-cdn.xitu.io/2018/7/24/164ca7060eec99a3?w=289&h=290&f=png&s=11519)

**web.xml**

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns="http://java.sun.com/xml/ns/javaee"
	xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
	id="WebApp_ID" version="3.0">
	<display-name>ssm-echarts-demo</display-name>
	<welcome-file-list>
		<welcome-file>index.html</welcome-file>
		<welcome-file>index.htm</welcome-file>
		<welcome-file>index.jsp</welcome-file>
		<welcome-file>default.html</welcome-file>
		<welcome-file>default.htm</welcome-file>
		<welcome-file>default.jsp</welcome-file>
	</welcome-file-list>

	<!-- springMVC 静态资源显示问题。使用服务器来处理静态资源。 原因：客户端发送request，springMVC有DispatcherServlet转发，而DiapatchServlet的url-pattern是“/”，代表着所有的请求都要由DispatcherServlet 
		转发，因此处理静态资源，第一种就采用服务器端处理，请求先过DefaultServlet,静态资源过滤则剩下的请求就交给dispatcherServlet处理。 -->
	<servlet>
		<servlet-name>default</servlet-name>
		<servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
		<init-param>
			<param-name>debug</param-name>
			<param-value>0</param-value>
		</init-param>
		<init-param>
			<param-name>listings</param-name>
			<param-value>false</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>

	<!-- 加载spring容器 ，如果没有配置这个话会出现service无法注入到controller层的情况 -->
	<context-param>
		<param-name>contextConfigLocation</param-name>
		<param-value>classpath:spring/applicationContext-*.xml</param-value>
	</context-param>
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
	</listener>
	<!-- js静态资源 -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.js</url-pattern>

	</servlet-mapping>
	<!-- css静态资源 -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.css</url-pattern>

	</servlet-mapping>
	<!-- gif 静态资源 -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.gif</url-pattern>

	</servlet-mapping>
	<!-- jpg静态资源 -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.jpg</url-pattern>

	</servlet-mapping>
	<!-- ico -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.ico</url-pattern>

	</servlet-mapping>
	<!-- png -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.png</url-pattern>

	</servlet-mapping>
	<!-- htm -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.htm</url-pattern>

	</servlet-mapping>

	<!-- eot -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.eot</url-pattern>

	</servlet-mapping>
	<!-- svg -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.svg</url-pattern>

	</servlet-mapping>
	<!-- ttf -->
	<servlet-mapping>

		<servlet-name>default</servlet-name>

		<url-pattern>*.ttf</url-pattern>

	</servlet-mapping>
	<!-- woff -->
	<servlet-mapping>
		<servlet-name>default</servlet-name>
		<url-pattern>*.woff</url-pattern>
	</servlet-mapping>
	<servlet-mapping>
		<servlet-name>default</servlet-name>
		<url-pattern>*.json</url-pattern>
	</servlet-mapping>



	<!-- 配置springMVC的DispathServlet -->
	<servlet>
		<servlet-name>spring</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:spring/springmvc.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>

	</servlet>
	<servlet-mapping>
		<servlet-name>spring</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>
	<!-- 配置过滤器:CharacterEncodingFilter -->
	<filter>
		<filter-name>Encoding</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>Encoding</filter-name>
		<url-pattern>*</url-pattern>
	</filter-mapping>

</web-app>
```

### 三 核心代码

#### 3.1 bean
**User.java**

```java
package com.snailclimb.bean;

/**
 * 用户实体类
 * 
 * @author Snailclimb
 *
 */
public class User {
	private Integer id;

	private String userToken;

	private String location;

	private String business;

	private String sex;

	private String employment;

	private String education;

	private String username;

	private String url;

	private Integer agrees;

	private Integer thanks;

	private Integer asks;

	private Integer answers;

	private Integer posts;

	private Integer followees;

	private Integer followers;

	private String hashid;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserToken() {
		return userToken;
	}

	public void setUserToken(String userToken) {
		this.userToken = userToken == null ? null : userToken.trim();
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location == null ? null : location.trim();
	}

	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business == null ? null : business.trim();
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex == null ? null : sex.trim();
	}

	public String getEmployment() {
		return employment;
	}

	public void setEmployment(String employment) {
		this.employment = employment == null ? null : employment.trim();
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education == null ? null : education.trim();
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username == null ? null : username.trim();
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url == null ? null : url.trim();
	}

	public Integer getAgrees() {
		return agrees;
	}

	public void setAgrees(Integer agrees) {
		this.agrees = agrees;
	}

	public Integer getThanks() {
		return thanks;
	}

	public void setThanks(Integer thanks) {
		this.thanks = thanks;
	}

	public Integer getAsks() {
		return asks;
	}

	public void setAsks(Integer asks) {
		this.asks = asks;
	}

	public Integer getAnswers() {
		return answers;
	}

	public void setAnswers(Integer answers) {
		this.answers = answers;
	}

	public Integer getPosts() {
		return posts;
	}

	public void setPosts(Integer posts) {
		this.posts = posts;
	}

	public Integer getFollowees() {
		return followees;
	}

	public void setFollowees(Integer followees) {
		this.followees = followees;
	}

	public Integer getFollowers() {
		return followers;
	}

	public void setFollowers(Integer followers) {
		this.followers = followers;
	}

	public String getHashid() {
		return hashid;
	}

	public void setHashid(String hashid) {
		this.hashid = hashid == null ? null : hashid.trim();
	}
}
```
**ScoreResult.java**

```java
package com.snailclimb.bean;

/**
 * 圆饼图展示的时候需要使用到的对象
 * 
 * @author Snailclimb
 *
 */
public class ScoreResult {
	public int value; // 点赞数
	public String name;// 人名

	public float getValue() {
		return value;
	}

	public void setValue(int value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ScoreResult(int value, String name) {
		super();
		this.value = value;
		this.name = name;
	}

	@Override
	public String toString() {
		return "ScoreResult [value=" + value + ", name=" + name + "]";
	}

}

```
#### 3.2 dao层
**UserMapper.java**
```java
package com.snailclimb.dao;

import java.util.List;

import com.snailclimb.bean.User;

public interface UserMapper {
	public List<User> selecAgreesTop10();
}

```
**UserMapper.xml**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.snailclimb.dao.UserMapper">
	<select id="selecAgreesTop10" parameterType="User" resultType="User">
		SELECT
		`agrees`, `username`
		FROM
		`spider_zhihu_crawler`.`user`
		GROUP BY
		`agrees`
		ORDER BY `agrees` DESC LIMIT 0,9;
	</select>
</mapper>
```
#### 3.3 service层
**UserService.java**
```java
package com.snailclimb.service;

import java.util.List;

import com.snailclimb.bean.User;

public interface UserService {
	public List<User> selecAgreesTop10();
}

```
#### 3.4 service实现层
**UserServiceImpl.java**

```
package com.snailclimb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.snailclimb.bean.User;
import com.snailclimb.dao.UserMapper;
import com.snailclimb.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public List<User> selecAgreesTop10() {
		return userMapper.selecAgreesTop10();
	}

}

```

#### 3.5 controller层

```java
package com.snailclimb.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.snailclimb.bean.ScoreResult;
import com.snailclimb.bean.User;
import com.snailclimb.service.UserService;

@Controller
@RequestMapping(value = "/echarts")
public class UserController {

	@Autowired
	private UserService userService;

	/**
	 * 折线图和直方图
	 * 
	 * @return
	 */
	@RequestMapping(value = "/agreeLineAndBar")
	@ResponseBody
	public List<User> getAgreesTop10() {
		return userService.selecAgreesTop10();

	}

	/**
	 * 圆饼图
	 * 
	 * @return
	 */

	@RequestMapping(value = "/agreePie")
	@ResponseBody
	public List<ScoreResult> getAgreesTop10T() {
		List<User> list = userService.selecAgreesTop10();
		List<ScoreResult> results = new ArrayList<ScoreResult>();
		for (User user : list) {
			ScoreResult scoreResult = new ScoreResult(user.getAgrees(), user.getUsername());
			results.add(scoreResult);
		}
		return results;
	}

	// 跳转到圆饼图展示
	@RequestMapping(value = "/intoagreePie")
	public String intoagreePie() {
		return "agreePie";

	}

	// 跳转到折线图和直方图
	@RequestMapping(value = "/intoagreeLineAndBar")
	public String Index() {
		return "agreeLineAndBar";

	}
}
```
#### JSP页面
由于JSP页面代码过多，大家可以直接去我上传在Github的源码上拷贝。下面我只贴一下Ajax请求的代码。

下面以圆饼图为例，看看如何通过Ajax请求获取数据动态填充
```html
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
			  //如果请求的结果不为空，则填充数据，否则范围错误消息
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
```


**对应的Controller层代码：**

```java
	/**
	 * 圆饼图
	 */

	@RequestMapping(value = "/agreePie")
	@ResponseBody
	public List<ScoreResult> getAgreesTop10T() {
     	//查询数据
		List<User> list = userService.selecAgreesTop10();  
		List<ScoreResult> results = new ArrayList<ScoreResult>();
		//将数据添加到results中
		for (User user : list) {
			ScoreResult scoreResult = new ScoreResult(user.getAgrees(), user.getUsername());
			results.add(scoreResult);
		}
		//返回results
		return results;
	}

```

后台返回都是JSON格式的数据，如下图所示：

![后台返回都是JSON格式的数据](https://user-gold-cdn.xitu.io/2018/7/24/164ca09c60cf1a44?w=778&h=202&f=png&s=14463)


## 四 总结

这里只是以知乎赞同数TOP10为例子，带着大家学习了SSM环境的搭建以及代码的编写，代码中有很详细的注释。

通过本例子，大家完全可以自己做一个知乎粉丝数TOP、知乎感谢数TOP10等等例子出来。

另外本例子知识演示了圆饼图、折线图、柱状图的使用，大家可以自己去[Echarts官网](http://echarts.baidu.com/index.html)深入学习。

最后，本项目只是一个演示，还有很多需要优化的地方。比如可以使用redis来做缓存提高查询速度、可以创建索引提高查询速度或者直接将查询到的数据缓存下来等等方法来提高查询速度。

## 五 补充

### 使用索引优化查询速度：
效果图如下，可以看到明显查询速度快了很多。
![](https://user-gold-cdn.xitu.io/2018/7/24/164cc232fe4daec7?w=1370&h=649&f=gif&s=431697)


我使用的是SQLyoy创建的索引，具体方法如下图所示：

![SQLyoy创建索引](https://user-gold-cdn.xitu.io/2018/7/24/164cc256d65b6266?w=1115&h=456&f=png&s=56412)


### 简单改进使直方图以及立方图可以显示最大值、最小值以及平局值：
效果图如下
![](http://my-blog-to-use.oss-cn-beijing.aliyuncs.com/18-7-26/40933861.jpg)
改进方法（修改series代码如下）：

```js
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
```



> 如果想要获取更多我的原创文章，欢迎关注我的微信公众号:"**Java面试通关手册**" 。无套路，希望能与您共同进步，互相学习。

![](https://user-gold-cdn.xitu.io/2018/7/5/1646a3d308a8db1c?w=258&h=258&f=jpeg&s=27034)
