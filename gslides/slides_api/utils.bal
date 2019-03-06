
import ballerina/http;

# 
# utilities of the google slides
# 

# URLs
final string BASE_URL = "https://slides.googleapis.com";
final string REFRESH_URL = "https://www.googleapis.com/oauth2/v4/token";
final string SLIDES_PATH = "/v1/presentations";

final string SCHEME = "oauth";

final string SLIDES_ERROR_CODE = "SlidesError";

function setResponseError(json jsonResponse) returns error {
    error err = error(SLIDES_ERROR_CODE, { message: jsonResponse.message.toString() });
    return err;
}