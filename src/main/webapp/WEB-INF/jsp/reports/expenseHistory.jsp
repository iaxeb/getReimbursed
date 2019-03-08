<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
        <style>
            .custom-checkbox {
                padding: 0 3rem;
                display: inline-block;
            }
            #submitControlBtn{
                background-color:#fff;
                color:#ff3366;
                border:1px solid #ff3366;
            }
            #submitControlBtn:hover{
                background-color:#ff3366;
                color:#fff;
                font-weight:bold;
            }
            body { background-color:#fafafa;}
        </style>
    </head>
    <body>
        <%@include file="/WEB-INF/jsp/employee/header.jsp"%>
        <div class="container-fluid">
            <c:choose>
                <c:when test="${expenses ne null && not empty expenses}">
                    <div class="row">
                        <div class="input-field col s12 m8 l10">
                            <h5 class="margin medium-small">All ${reportName} Expenses</h5></p>
                        </div>
                        <div class="input-field col s12 m4 l2 right-align">
                            <button class="btn waves-light" id="submitControlBtn" >Submit</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12 m12 l12">
                            <table class="striped responsive-table  z-depth-1"  id="ExpenseListTable">
                                <thead>
                                    <tr style="color:#fff; background-color:00888A;">
                                        <th><input type="checkbox"  value="all" class="selectAllExpense"></th>
                                        <th>ID</th>
                                        <th>Expense Name</th>
                                        <th>Expense Date<br/> <small><i> (yyyy-dd-mm) </i></small> </th>
                                        <th>Amount</th>
                                        <th>Expense Type</th>
                                        <th>Expense<br>Location</th>
                                        <th>Payment Mode</th>
                                        <th>Expense<br>Status</th>
                                        <th>Bills</th>
                                        <th>Action
                                        <c:if test = "${reportName == 'Created'}"></c:if>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${expenses ne null && not empty expenses}">
                                        <c:forEach items="${expenses}" var="exp">
                                            <tr>
                                                <td><input type="checkbox" name="selectedExpense" value="${exp.exp_id}" class="selectExpense"></td>
                                                <td>${exp.exp_id}</td>
                                                <td>${exp.exp_name}</td>
                                                <td><fmt:formatDate pattern = "yyyy-MM-dd" value = "${exp.exp_Date}"/></td>
                                                <td><fmt:formatNumber type="number" maxFractionDigits="2"  minFractionDigits="2" value="${exp.exp_amount}" /></td>
                                                <td>
                                                    <c:forEach items="${expenseTypeList}" var="et">
                                                        <c:if test="${et.expType_Id==exp.expenseType.expType_Id}">${et.expType_Name}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:forEach items="${locationList}" var="ll">
                                                        <c:if test="${ll.location_id==exp.location.location_id}">${ll.location_name}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>
                                                    <c:forEach items="${payModeList}" var="pML">
                                                        <c:if test="${pML.pay_Id == exp.paymentMode.pay_Id}">${pML.pay_type}</c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${exp.expenseStatus.expStatus_Name}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${exp.billable eq true}"> Yes  </c:when>
                                                        <c:otherwise>Not</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <a  href="/viewPerticularExpense/${exp.exp_id}">
                                                        <i class="material-icons" style="color:Blue;">visibility</i>
                                                    </a>
                                                    <c:choose>
                                                        <c:when test = "${exp.expenseStatus.expStatus_Id == 1}">
                                                            <a  href="/editExpenseDetails/${exp.exp_id}">
                                                                <i class="material-icons" style="color:#880e4f;">edit</i>
                                                            </a>
                                                            <a id="deleteExpense" href="">
                                                                <i class="material-icons" style="color:#f50057;">delete</i>
                                                            </a>
                                                        </c:when>
                                                    </c:choose>


                                                <c:if test = "${reportName == 'Created'}">

                                                        <a  href="/submitPerticularExpense/${exp.exp_id}">
                                                            <i class="material-icons" style="color:purple;">trending_up</i>
                                                        </a>

                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <div class="col s10 m8 l6 offset-s1 offset-l3  z-depth-5 card-panel center-align " id="panelBck">
                            <div class="center-align">
                                <img class="responsive-img center-align "  src="http://insidetimeshare.com/wp-content/uploads/2018/03/not_available.jpg">
                            </div>
                            <h6>OOps, You Don't have any ${reportName} expense history.</h5>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Modal Structure -->
        <div id="locationModelWindow" class="modal">
            <div class="modal-content">
                <h4>Modal Header</h4>
                <p>A bunch of text</p>
            </div>
            <div class="modal-footer">
                <a href="#!" class="modal-close waves-effect waves-green btn-flat">Agree</a>
            </div>
        </div>



        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/materialize/0.98.2/js/materialize.min.js"></script>
        <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
        <script src="/assets/js/main.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {

                $(".button-collapse").sideNav();
                $('select').formSelect();
                $('.dropdown-trigger').dropdown();


            });
            $('.dropdown-trigger').dropdown();


            $('#ExpenseListTable').on('click', '.changeStatusExpenseBtn', changeStatusExpense);

            function changeStatusExpense(e) {

                var value = [];
                $.each($('.selectExpense:checked'), function () {
                    value.push($(this).val());
                });
                var url = $(this).data('uri');
                alert(url);
                $.ajax({
                    type: 'get',
                    url: url,
                    data: {expenseIds: value},
                    success: function (response) {
                        if (response.success === "true") {
                            location.reload();
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function (response) {
                        alert("Server error encountered");
                    },
                    complete: function (response) {

                    }
                });
            }
            ;
        </script>
    </body>
</html>