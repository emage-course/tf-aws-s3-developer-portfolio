Homepage URL:
http://jenkins.kendopx.com:8080/

Authorization callback URL: 
http://jenkins.kendopx.com:8080/securityRealm/finishLogin

The recommended minimum GitHub OAuth scopes are read:org,user:email.
Logged-in users can do anything

Automatically configure security realm via script console

```sh
import hudson.security.SecurityRealm
import org.jenkinsci.plugins.GithubSecurityRealm
String githubWebUri = 'https://github.com'
String githubApiUri = 'https://api.github.com'
String clientID = 'someid'
String clientSecret = 'somesecret'
String oauthScopes = 'read:org'
SecurityRealm github_realm = new GithubSecurityRealm(githubWebUri, githubApiUri, clientID, clientSecret, oauthScopes)
//check for equality, no need to modify the runtime if no settings changed
if(!github_realm.equals(Jenkins.instance.getSecurityRealm())) {
    Jenkins.instance.setSecurityRealm(github_realm)
    Jenkins.instance.save()
}
```