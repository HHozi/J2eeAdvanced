
## 本开源仓库已经开源的JavaWeb进阶项目
### 一 SSM项目中整合Echarts开发

**介绍：** 这里只是以知乎赞同数TOP10为例子，带着大家学习了SSM环境的搭建以及代码的编写，代码中有很详细的注释。通过本例子，大家完全可以自己做一个知乎粉丝数TOP、知乎感谢数TOP10等等例子出来。另外本例子知识演示了圆饼图、折线图、柱状图的使用，大家可以自己去[Echarts官网](https://link.juejin.im/?target=http%3A%2F%2Fecharts.baidu.com%2Findex.html)深入学习。

**源码地址：**[ https://github.com/Snailclimb/J2ee-Advanced/tree/master/ssm-echarts-demo%20Maven%20Webapp](https://github.com/Snailclimb/J2ee-Advanced/tree/master/ssm-echarts-demo%20Maven%20Webapp)

**讲解：** [：https://github.com/Snailclimb/J2ee-Advanced/blob/master/detailed-explanation/ssm-echarts-demo.md](https://github.com/Snailclimb/J2ee-Advanced/blob/master/detailed-explanation/ssm-echarts-demo.md)

**优化：** ①由于赞同数和人名我们需要经常查询，所以考虑使用索引。我使用SQLyog图形化数据库编辑器为数据库的agrees字段和username字段添加索引。索引添加完成之后，速度明显快了很多很多，60w中查出前10的数据仅仅在1s之内就可以完成。

### 二  结合Spring发送邮件的四种正确姿势

**介绍：** 1, 发送text格式的邮件2,发送HTML格式的邮件3,基于FreeMarker模板引擎发送邮件4,基于Velocity模板引擎发送邮件

**源码地址：**[ https://github.com/Snailclimb/J2ee-Advanced/tree/master/ssm-echarts-demo%20Maven%20Webapp](https://github.com/Snailclimb/J2ee-Advanced/tree/master/ssm-echarts-demo%20Maven%20Webapp)

**讲解：** [https://github.com/Snailclimb/J2ee-Advanced/blob/master/detailed-explanation/spring-email.md](https://github.com/Snailclimb/J2ee-Advanced/blob/master/detailed-explanation/spring-email.md)

