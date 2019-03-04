import ballerina/config;
import ballerina/io;
import ballerina/test;
import ballerina/log;
import ballerina/http;

SlidesConfiguration slidesConfig = {
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: config:getAsString("ACCESS_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET"),
            refreshToken: config:getAsString("REFRESH_TOKEN")
        }
    }
};
Client slidesClient = new(slidesConfig);

Slides testSlides = new;
Slide testslide = {};
string testSlidesName = "testBalFile";
string testSlideName = "testSheet";
int testSlideId = 0;

@test:Config
function testCreateSlides() {
    io:println("-----------------Test case for createslides method------------------");
    var slidesRes = slidesClient->createSlides(testSlidesName);
    if (slidesRes is Slides) {
        testSlides = slidesRes;
        test:assertNotEquals(slidesRes.presentationId, null, msg = "Failed to create slides");
    } else {
        test:assertFail(msg = <string>slidesRes.detail().message);
    }
}
