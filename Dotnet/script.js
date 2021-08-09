function Calc(a,b)
{
    DotNet.invokeMethodAsync('TestLib', 'TestFunction',a,b)
      .then(data => {
        console.log('Calc return');
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('Result',[data]);
      });
}
function Ping()
{
    console.log('Ping start');
    DotNet.invokeMethodAsync('TestLib','Ping')
    .then(data => {
        console.log('Ping return');
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('PingResult',[data]);
    })
}
function Test1()
{
    console.log('Test1 function start');
    DotNet.invokeMethodAsync('BlazorDemo.Client', 'test')
      .then(data => {
        console.log('Test Custom DLL');
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('Test1Result',[data]);
      });
}
function GetSFDCToken()
{
    console.log('GetSFDCToken start');
    DotNet.invokeMethodAsync('BlazorDemo.Client', 'GetSFDCToken')
      .then(data => {
        console.log('Test GetSFDCToken function');
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SFDCTokenResult',[data]);
      });
}
