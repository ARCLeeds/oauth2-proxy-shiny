# OAuth2-proxy App Examples

This is an example repository for adding constrained authentication to using [OAuth2-proxy](https://oauth2-proxy.github.io/oauth2-proxy/) with both [Shiny](./shiny-example/) and [Streamlit](./streamlit-example/).

It uses GitHub as the OAuth2 provider and uses an email whitelist to determine authorised accounts. 
This example borrows heavily from [Hamel Husain's OAuth2-proxy tutorial](https://github.com/hamelsmu/oauth-tutorial).

## To run locally

To run either example locally you will need a [GitHub account](https://github.com/) and [Docker](https://docs.docker.com/get-docker/) installed.

1. Pick whether to try Shiny or Streamlit. To get started you'll need to enter the relevant example directory and do the subsequent steps.

2. [Create an OAuth App](https://github.com/settings/applications/new) with GitHub. From this you will get a client ID and be able to create a client secret that you can add to `client_secret` and `client_id` sections of [`oauth2-proxy.cfg`](./shiny-example/oauth2-proxy.cfg).
![Creating OAuth App with GitHub](./assets/oauth2-proxy.png)

3. Create an email whitelist as [`emails.txt`](./shiny-example/emails.txt), try this with your email account linked to your GitHub account

4. Create a cookie and add it to the `cookie_secret` parameter in the [`oauth2-proxy.cfg`](./shiny-example/oauth2-proxy.cfg) configuration file.

5. Build a local copy of the Shiny app container
    ```bash
    docker build . -t test-shiny:latest
    ```

6. Run `docker-compose up` in the repository to start the services (this will pull down the oauth2-proxy Docker container the first time you run it)

7. Visit http://localhost:4180, the first time you visit you may be asked to grant the app permission to read your GitHub account details, accept this and proceed. 

8. Experiment with changing the [`emails.txt`](./emails.txt) whitelist file whilst running the app to remove/add your account.
