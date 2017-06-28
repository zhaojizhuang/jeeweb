<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/webpage/common/taglibs.jspf"%>
<!DOCTYPE html>
<html>
<head>
    <title>订单主表</title>
    <meta name="decorator" content="form"/>
    <html:css name="bootstrap-fileinput" />
    <html:css name="simditor,jqgrid" />
</head>

<body class="white-bg"  formid="testOrderMainForm" beforeSubmit="beforeSubmit">
    <form:form id="testOrderMainForm" modelAttribute="data" action="${adminPath}/testtest/testordermain/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<table  class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
				<tr>
					<td  class="width-15 active text-right">	
		              <label><font color="red">*</font>订单号:</label>
		            </td>
					<td class="width-35">
						<form:input path="orderno" htmlEscape="false" class="form-control"      />
						<label class="Validform_checktip"></label>
					</td>
					<td  class="width-15 active text-right">	
		              <label><font color="red">*</font>订单金额:</label>
		            </td>
					<td class="width-35">
						<form:input path="money" htmlEscape="false" class="form-control"      />
						<label class="Validform_checktip"></label>
					</td>
				</tr>
				<tr>
					<td  class="width-15 active text-right">	
		              <label><font color="red">*</font>订单日期:</label>
		            </td>
					<td class="width-35">
						http://www.layui.com/laydate/ 时间空间需要优化，看是否有必要封装为控件
						<form:input path="orderdate" htmlEscape="false" class="form-control layer-date"  onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})"       />
						<label class="Validform_checktip"></label>
					</td>
					<td class="width-15 active text-right"></td>
		   			<td class="width-35" ></td>
		  		</tr>
		      
		   </tbody>
		</table>   
	</form:form>
	<div class="row">
        <div class="tabs-container">
            <ul class="nav nav-tabs">
            	<li class="active"><a data-toggle="tab" href="#tab_testOrderTicket" aria-expanded="true">机票信息</a></li>
            	<li ><a data-toggle="tab" href="#tab_testOrderCustomer" aria-expanded="true">客户信息</a></li>
            </ul>
            <div class="tab-content">
                 <div id="tab_testOrderTicket" class="tab-pane active">
                    <div class="panel-body">
                        <grid:grid id="testOrderTicket"  datas="${data.testOrderTicketList}"  gridShowType="form" pageable="false"  editable="true">
							    <grid:column editable="true" label="航班号"  name="fltno" />
							    <grid:column label="航班时间"   name="flytime"  editable="true"  edittype="date"   dateformat="yyyy年MM月dd日"/>
						</grid:grid>
						
					</div>
                </div>
                 <div id="tab_testOrderCustomer" class="tab-pane ">
                    <div class="panel-body">
                        <grid:grid id="testOrderCustomer"  datas="${data.testOrderCustomerList}"  gridShowType="form" pageable="false"  editable="true">
							    <grid:column editable="true" label="客户姓名"  name="name" />
							    <grid:column editable="true" edittype="select" dict="sf" label="性别"  name="sex" />
							    <grid:column editable="true" label="电话"  name="phone" />
							    <grid:column editable="true" label="备注信息"  name="remarks" />
						</grid:grid>
						
					</div>
                </div>
          
            </div>
        </div>
    </div>
<html:js name="bootstrap-fileinput" />
<html:js name="simditor,jqgrid,jqGrid_curdtools,jqGrid_curdtools_inline" />
<script>
	$(document).ready(function () {
	    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
	    	 resizeGrid();
		});
	});
	$(function(){
	   $(window).resize(function(){   
		   resizeGrid();
	   });
	});
	function resizeGrid(){
		 $("#testOrderTicketGrid").setGridWidth($(window).width()-60);
		 $("#testOrderCustomerGrid").setGridWidth($(window).width()-60);
	}

	/**
	*提交回调方法
	*/
	function beforeSubmit(curform){
		 //这里最好还是使用JSON提交，控制器改变提交方法，并使用JSON方式来解析数
		 //通过判断，如果有问题不提交
		 if(!initGridFormData(curform,"testOrderTicket"))return false;
		 if(!initGridFormData(curform,"testOrderCustomer"))return false;
		 return true;
	}
	
	function initGridFormData(curform,gridId){
		 var rowDatas =getRowDatas(gridId+"Grid");
		 var rowJson = JSON.stringify(rowDatas);
		 if(rowJson.indexOf("editable") > 0&&rowJson.indexOf("inline-edit-cell") )
	     {
	    	 return false;
	     }
		 var gridListJson=$('#'+gridId+"ListJson").val();
		 if(gridListJson==undefined||gridListJson==''){
			 var rowInput = $('<input id="'+gridId+'ListJson" type="hidden" name="'+gridId+'ListJson" />');  
			 rowInput.attr('value', rowJson);  
			 // 附加到Form  
			 curform.append(rowInput); 
		 }else{
			 $('#'+gridId+"ListJson").val(rowJson);
		 }
		 return true;
	}
</script>
</body>
</html>