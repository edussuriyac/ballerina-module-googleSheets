import ballerina/http;
import ballerina/io;
# Description
#
# + slidesClient - client of the slides
public type Client client object{
  public http:Client slidesClient;

  public function __init(SlidesConfiguration slidesConfig){
      self.init(slidesConfig);
      self.slidesClient= new(BASE_URL, config = slidesConfig.clientConfig);
  }

  public function init(SlidesConfiguration slidesConfig);


  public remote function createSlides(string slidesName) returns Slides|error;

  public remote function openSlidesById(string presentationId) returns Slides|error;

};
# Description
#
# + slidesConfig - configuration of the slides
public function Client.init(SlidesConfiguration slidesConfig) {
    http:AuthConfig? authConfig = slidesConfig.clientConfig.auth;
    if (authConfig is http:AuthConfig) {
        authConfig.refreshUrl = REFRESH_URL;
        authConfig.scheme = http:OAUTH2;
    }
}
# Description
#
# + clientConfig - configuration of the slide object
public type SlidesConfiguration record{
    http:ClientEndpointConfig clientConfig;
};

# Description
#
# + slidesName - Name of the slides 
# + return - Return slides object
public remote function Client.createSlides(string slidesName) returns Slides|error {
    string requestPath = SLIDES_PATH;
    http:Request request = new;
    var httpResponse = self.slidesClient->post(SLIDES_PATH, request);
    if (httpResponse is http:Response) {
        int statusCode = httpResponse.statusCode;
        io:println(statusCode);
        var jsonResponse = httpResponse.getJsonPayload();
        if (jsonResponse is json) {
            if (statusCode == http:OK_200) {
                Slides slides = convertToPresentation(jsonResponse);
                return slides;
            } else {
                error eror = error(SLIDES_ERROR_CODE,
                { message: "Error" });
            return eror;
            }
        } else {
            error err = error(SLIDES_ERROR_CODE,
                { message: "Error occurred while accessing the JSON payload of the response" });
            return err;
        }
    } else {
        error err = error(SLIDES_ERROR_CODE, { message: "Error occurred while invoking the REST API" });
        return err;
    }
}

public remote function Client.openSlidesById(string presentationId) returns Slides|error {
    string getSlidesPath = SLIDES_PATH + "/" + presentationId;
    var httpResponse = self.slidesClient->get(getSlidesPath);
    if (httpResponse is http:Response) {
        int statusCode = httpResponse.statusCode;
        var jsonResponse = httpResponse.getJsonPayload();
        if (jsonResponse is json) {
            if (statusCode == http:OK_200) {
                Slides slides = convertToPresentation(jsonResponse);
                return slides;
            } else {
                return setResponseError(jsonResponse);
            }
        } else {
            error err = error(SLIDES_ERROR_CODE,
                { message: "Error occurred while accessing the JSON payload of the response" });
            return err;
        }
    } else {
        error err = error(SLIDES_ERROR_CODE, { message: "Error occurred while invoking the REST API" });
        return err;
    }
}