{{define "content"}}
  <div class="row">
    <div class="col s12">
      <h3 class="header">Frequently Asked Questions</h3>
      <div class="card-panel">
        <h4>评分</h4>
        <p>用户提交的程序经过Online Judge的即时评测，可能的反馈信息包括：</p>
        <table id="faq-list" class="bordered compact">
          <thead>
            <tr>
              <th class="center-align">结果</th>
              <th class="center-align">说明</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="center-align"><a class="btn btn-status j0">Pending</a></td>
              <td>系统还没有评测到这个提交，请稍候</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status j11">Rejudge Pending</a></td>
              <td>系统还没有重新评测到这个提交，请稍候</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status j1">Running&Judging</a></td>   
              <td>评测系统正在评测，稍候会有结果</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status j2">Compile Error</a></td>
              <td>您提交的代码无法完成编译</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status j3">Accepted</a></td>    
              <td>恭喜！您通过了这道题</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status j9">Presentation Error</a></td>
              <td>您的程序输出的格式不符合要求（比如空格和换行与要求不一致）</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status">Runtime Error</a></td>
              <td>您的程序发生运行错误，可能是数组越界，堆栈溢出（比如，递归调用层数太多）等情况引起</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status">Wrong Answer</a></td>
              <td>您的程序未能对评测系统的数据返回正确的结果，即答案错误</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status">Time Limit Exceeded</a></td>
                <td>您的程序未能在规定时间内运行结束</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status">Memory Limit Exceeded</a></td>
              <td>您的程序使用了超过限制的内存</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status">Output Limit Exceeded</a></td>
              <td>您的程序输出的内容超出限制，可能是输出部分陷入无限循环引起</td>
            </tr>
            <tr>
              <td class="center-align"><a class="btn btn-status j10">System Error</a></td>
              <td>评测系统出现了错误，竞赛中系统将不会记录罚时</td>
            </tr>
          </tbody>
        </table>
        <h4>常见问题</h4>
        <p><b>我应该从哪里读输入，另外应该输出到哪里？</b></p>
        <p>如果没有特别说明，你的程序应该从标准输入（stdin，传统意义上的“键盘”）读入，并输出到标准输出（stdout，传统意义上的“屏幕”），不要使用文件做输入输出。由于系统是在你的程序运行结束后开始检查输出是否是正确的，对于有多组测试数据的输入，可以全部读入之后再输出，也可以处理一组测试数据就输出一组</p>
        <p><b>为什么我的程序交在这里得到编译错误，而我在自己的机器上已经编译通过了？</b></p>
        <p>本系统所使用的编译器和你在自己机器上使用的可能有区别，请留意几个常见的地方：</p>
        <ul>
          <li><p>1. 本系统运行在 32 位 Linux 系统上，使用的编译器版本和编译参数可以参见编译器帮助</li></p>
          <li><p>2. Windows平台专有的函数、数据类型、头文件不应使用。如scanf_s(), _tmain(), _TCHAR, Windows.h等</li></p>
          <li><p>3. C 代码main函数必须采用int作为返回类型，且返回return 0;<p></li>
          <li><p>4. C++ 下 64 位整数的类型是 long long，不要使用 __int64</p></li>
          <li><p>5. C/C++代码不应包含stdafx.h</p></li>
          <li><p>6. Java 代码需使用 Main 作为主类名</p></li>
          <li><p>7. Visual C++ 6.0 和 Turbo C++ 3.0 （及它们的更低版本）有较多违背 C++ 标准（<a href="http://www.iso.org/iso/iso_catalogue/catalogue_ics/catalogue_detail_ics.htm?ics1=35&ics2=60&ics3=&csnumber=50372" target="new">ISO/IEC 14882</a>）的地方，不要使用它们来判断 C++ 程序语法上是否有问题</p></li>
        </ul>
        <p><b>程序的时间和内存占用是如何计算的？</b></p>
        <p>程序的运行时间为程序在所有 CPU 核占用的时间之和，内存占用取程序运行开始到结束占用内存的最大值</p>
        <p><b>为什么同样的程序运行时间和所用内存会不同？</b></p>
        <p>程序运行时间会受到许多因素的影响，尤其是在现代多任务操作系统以及在使用动态库的情况下，多次使用同一输入运行同一程序所需时间和内存有一些不同是正常现象。我们的题目给出的运行限制一般为标准程序的若干倍，也就是说，选用正确的算法和合适的语言，那么运行限制是富余的</p>
        <p><b>不同语言的时间限制和内存限制是相同的吗？</b></p>
        <p>Java代码的时间和内存限制一般是其他编程语言的两倍</p>
        <p><b>我提交的代码可以做什么，有什么限制吗？</b></p>
        <p>没有。这里没有系统调用白名单，也没有针对语言限制可使用的包或库。虽然我们比较宽容大度，但还是请不要做不符合道义的事情。如果你需要使用我们系统没有提供的某个语言的某个库，或者需要更改编译参数，可以联系我们</p>
        <div class="divider"></div>
        <h4>编译器列表</h4>
        <h5>gcc for C</h5>
        <h6>1. 版本</h6>
        <pre>gcc (Ubuntu 4.8.2-19ubuntu1) 4.8.2
Copyright (C) 2013 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.</pre>
        <h6>2. 编译运行选项</h6>
        <pre>gcc Main.c -o Main -Wall -lm --static -std=c99 -DONLINE_JUDGE && ./Main</pre>
        <h5>g++ for C++</h5>
        <h6>1. 版本</h6>
        <pre>g++ (Ubuntu 4.8.2-19ubuntu1) 4.8.2
Copyright (C) 2013 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.</pre>
        <h6>2. 编译运行选项</h6>
        <pre>g++ Main.cc -o Main -Wall -lm --static -std=c++0x -DONLINE_JUDGE && ./Main</pre>
        <h5>OpenJDK for Java</h5>
        <h6>1. 版本</h6>
        <pre>Java version "1.7.0_55"
OpenJDK Runtime Environment (IcedTea 2.4.7) (7u55-2.4.7-1ubuntu1)
OpenJDK Client VM (build 24.51-b03, mixed mode, sharing)</pre>
        <h6>2. 编译运行选项</h6>
        <pre>javac -J-Xms32m -J-Xmx256m Main.java &&/usr/bin/java -Xms128M -Xms512M -DONLINE_JUDGE=true Main</pre>
        <div class="divider"></div>
        <h4>其他</h4>
        <p>在考试或比赛中遇到其他问题请咨询现场工作人员</p>
        <p>如果对于Online Judge有任何需求或者bug report，请在Github发起一个<a href="https://github.com/ZJGSU-Open-Source/GoOnlineJudge/issues/new" target="_blank">issue</a></p>
        <h4>维护人员</h4>
        <p><a href="https://github.com/sakeven" target="_blank">@sakeven</a> <a href="https://github.com/JinweiClarkChao" target="_blank">@JinweiClarkChao</a> <a href="https://github.com/rex-zsd" target="_blank">@rex-zsd</a></p>
      </div>
    </div>
  </div>
{{end}}
