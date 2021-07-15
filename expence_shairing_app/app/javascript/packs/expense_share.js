function SetExpenseChart(data)
{
    Highcharts.chart('pie_chart_container', {
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                type: 'pie'
            },
            title: {
                text: 'Expense Chart'
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
            },
            accessibility: {
                point: {
                    valueSuffix: '%'
                }
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                    }
                }
            },
            series: [{
                name: 'Share',
                colorByPoint: true,
                data: data
            }]
   });
}
function SetPichartCall()
{
  start_date = $('#start_date').val();
  end_date = $('#end_date').val();
  $.ajax({
    type:"GET",
    url: '/dashboard_chart/plot?start_date=' + start_date + '&end_date=' + end_date,
    dataType:"json",
    data: {},
    success:function(result){
      data = result["data"]
      SetExpenseChart(data)
    },
    async: false
  });

}


document.addEventListener('turbolinks:load', () => {  
  const clickButton1 = document.getElementById("sample_editable_1_new");  
  if (clickButton1!=null)
    clickButton1.addEventListener("click", SetPichartCall);

  // const clickButton2 = document.getElementById("sample_editable_2_new");  
  // if (clickButton2!=null)
  //   clickButton2.addEventListener("click", SetTableCall);  
});