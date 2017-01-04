public class AnalyticsAPIConnector{
    public static string runReportSync(string reportId){
        Http http = new Http();
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        httpReq.setMethod('GET');
        httpReq.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        httpReq.setEndpoint(
            URL.getSalesforceBaseUrl().toExternalForm()+
            '/services/data/v29.0/analytics/reports/' + reportId +
            '/describe'
        );
        httpRes = http.send(httpReq);
        system.debug(httpRes.getBody());
        return httpRes.getBody();
    }
}