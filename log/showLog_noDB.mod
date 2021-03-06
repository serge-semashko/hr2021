showLog_noDB.mod

[comments]
descr=S: Показать лог-файл
input=
output=
parents=
childs=
test_URL=?c=sys/showLog_noDB
author=Куняев
[end]

[parameters]
request_name=S:Показать лог-файл
title=LOG SED
LOG=OFF
[end]


[report]
$INCLUDE [report_]  
        ??USER_ID&AR_SYS_ADMIN=1|VU
[end]
|USER_ID=10794

[report_]
    <HTML><HEAD><TITLE>LOG SED</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=utf-8">
    <script type="text/javascript" src="/sed/js/jquery-1.11.0.min.js"></script>     

    <style>
        .pt {cursor:pointer;}
    </style>

    <script type="text/javascript">
        var clearLog=function() {
            document.theForm.ResetLog.value="true";
            document.theForm.submit();
            document.theForm.setLog[0].checked=true; ??
            switchLog(); ??
        }

        var switchLog=function() {
            document.theForm.ResetLog.value="true";
            document.theForm.submit();
        }

        var toggleDiv=function(id){
            var d = document.getElementById(id);
            if(d.style.display == "none")
                d.style.display = "block";
            else
                d.style.display = "none";
        }
    </script>
    </head>
    $JS{
        var date=new Date();
        var day = date.getDate();
        var m = date.getMonth() + 1;
        var h = date.getHours();
        var a = '('+prm('doc_list').trim().replace(/\s/g,",")+")"; ??
        setPrm('lf_postfix', m + "_" + day + "_" +  h + ".html");
    $JS}

    $GET_DATA [get log file name] ??
    $SET_PARAMETERS logPath=#AppRoot#/WEB-INF/; ??!logPath
    $SET_PARAMETERS DataStartPath=#logPath#;
    $GET_DATA [read file]

    $SET_PARAMETERS debug=on; ??setDebug
    $SET_PARAMETERS setLog=on; ??!setLog
    $SET_PARAMETERS_GLOBAL log=true; ??setLog=on
    $SET_PARAMETERS_GLOBAL log=false; ??setLog=off
    $SET_PARAMETERS_GLOBAL LogLevel=#LogLevel#; ??LogLevel


    <body>
    <div style="position: fixed; top:1; right:1; border:solid 1px gray; background-color:##FFFFA0; padding:5px;">
        <form name="theForm" method="POST" enctype="multipart/form-data" style="margin:0;">
            <input type=hidden name="c" value="#c#">
            <input type=hidden name="ResetLog" value="">
            <input type=button value="ОБНОВИТЬ" style="width:120px; margin-right:20px;" onClick="document.theForm.setLog[0].checked=true; document.theForm.submit();">
            <input type=button value="ОЧИСТИТЬ" style="width:120px; margin-right:20px;" onClick="clearLog();">  ??debug_server=true
            <span class="pt" onClick="if(confirm('Очистить?')) clearLog();">clr</span> &nbsp;                 ??!debug_server=true&USER_ID=4241|USER_ID=2309|VU=2309
            $INCLUDE [log level]                 ??debug_server=true|USER_ID=2309|VU=2309
        </form>
    </div>

        <a href="file://///#DataStartPath##lf_name#" target=_blank> ??
        #DataStartPath##logFileName#_#lf_postfix#  &nbsp;
    #lf_name# &nbsp; lf_postfix=#lf_postfix#; ??
        <a href="#ServletPath#?c=sys/request_log">Requests</a>
        <br>
        #contents1# ??!ResetLog
        <hr>
    </body></html>
[end]

[log level]
        LOG:
        <input type=radio name="setLog" value="on"
            checked ??log=true
            onClick="switchLog();">ON 
        <input type=radio name="setLog" value="off"
            checked ??!log=true
            onClick="switchLog();">OFF
        <input type=radio name="LogLevel" value="0"
            checked ??LogLevel=0
            onClick="switchLog();">0
        <input type=radio name="LogLevel" value="1"
            checked ??LogLevel=1
            onClick="switchLog();">1
        <input type=radio name="LogLevel" value="2"
            checked ??LogLevel=2
            onClick="switchLog();">2
        <input type=radio name="LogLevel" value="3"
            checked ??LogLevel=3
            onClick="switchLog();">3
        <input type=radio name="LogLevel" value="5"
            checked ??LogLevel=5
            onClick="switchLog();">5
        <input type=radio name="LogLevel" value="7"
            checked ??LogLevel=7
            onClick="switchLog();">7
        <input type=radio name="LogLevel" value="9"
            checked ??LogLevel=9
            onClick="switchLog();">9
        &nbsp; &nbsp;

        <input type=checkbox name="setDebug" 
            checked ??setDebug
            onClick="document.theForm.submit();">debug
[end]

[read file]
read file: #logFileName#_#lf_postfix# maxLength=500000
read file: #lf_name# maxLength=500000 ??
[end]

[zzz get log file name]
select concat('#logFileName#', DATE_FORMAT(now(),'_%m_%d_%h'), '.html' ) as "lf_name_"
[end]
        return rm.getString("logFileName", false, "log") + "_" + month + "_" + day + "_" + hour + ".html";
