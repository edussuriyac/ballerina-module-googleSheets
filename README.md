# ballerina-module-googleSlides
Connects to Google Slides from Ballerina.

The Google Slides connector allows you to create and access Google Slides through the Google Slides REST API. It also allows you to create slides. It handles OAuth 2.0 authentication.

**Slides Operations**

The `wso2/gslides` module contains operations that create presentations

## Compatibility

|                             |       Version               |
|:---------------------------:|:---------------------------:|
| Ballerina Language          | 0.990.3                     |
| Google Slides      API      | V1                          |

## Sample

First, import the `wso2/gslides` module into the Ballerina project.

```ballerina
import wso2/gslides;
```

Instantiate the connector by giving authentication details in the HTTP client config. The HTTP client config has built-in support for BasicAuth and OAuth 2.0. Google Slides uses OAuth 2.0 to authenticate and authorize requests. The Google Slides connector can be minimally instantiated in the HTTP client config using the access token or the client ID, client secret, and refresh token.

**Obtaining Tokens to Run the Sample**

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard to create a new project.
2. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
3. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**. 
4. Select an application type, enter a name for the application, and specify a redirect URI (enter https://developers.google.com/oauthplayground if you want to use 
[OAuth 2.0 playground](https://developers.google.com/oauthplayground) to receive the authorization code and obtain the 
access token and refresh token). 
5. Click **Create**. Your client ID and client secret appear. 
6. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground), select the required Google Slides scopes, and then click **Authorize APIs**.
7. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token and access token. 

You can now enter the credentials in the HTTP client config:
```ballerina
gslides:SlidesConfiguration slidesConfig = {
    clientConfig: {
        auth: {
            scheme: http:OAUTH2,
            accessToken: testAccessToken,
            clientId: testClientId,
            clientSecret: testClientSecret,
            refreshToken: testRefreshToken
        }
    }
};

gslides:Client slidesClient = new(slidesConfig);
```

