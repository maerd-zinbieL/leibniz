# leibniz
 a R5RS Scheme implementation in java

### TODO

1. ###### lexer

   - [ ] 二进制、八进制、十六进制数字
   - [ ] 分数、复数
   - [ ] 空格标识符，即...| ... |...
   - [ ] 多行字符串
   - [ ] 多行注释，即#| ... |#
   - [ ] 负数会被识别为identifier
   
2. ###### parser
   
   - [ ] full test
   - [ ] throw core.exception when parsing `(x ,@y z ... )
   - [ ] 右括号缺失（目前直接报NullPointerException)
   
3. ###### repl
   
   - [ ] 滚动或者清除组件
   - [ ] 括号匹配
   - [ ] 处理副作用
   - [ ] 历史表达式
   
4. ###### eval

   -[ ] 尾递归优化
   -[ ] reduce test
   -[ ] reduce too slow
   