gitlab_kas['enable'] = true
gitlab_rails['initial_root_password'] = 'Redhat123###!'
external_url 'https://gitlab.kendopz.com'
registry_external_url 'https://gitlab.kendopz.com:5005'
letsencrypt['enable'] = true
letsencrypt['contact_emails'] = ['solomon.fwilliams@gmail.com']
letsencrypt['auto_renew'] = true
letsencrypt['auto_renew_hour'] = 12
letsencrypt['auto_renew_minute'] = 30
letsencrypt['auto_renew_day_of_month'] = "*/7"

nginx['enable'] = true
nginx['client_max_body_size'] = '250m'
nginx['redirect_http_to_https'] = true
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.kendopz.com.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.kendopz.com.key"
nginx['ssl_protocols'] = "TLSv1.1 TLSv1.2 TLSv1.3"
nginx['custom_gitlab_server_config'] = "location /api/v4/jobs/request {\n deny all;\n return 503;\n}\n"

gitlab_rails['ldap_enabled'] = true
gitlab_rails['ldap_servers'] = {
  'main' => {
    'label' => 'Active Directory',
    'host' =>  'txaddc01.kendopz.com',
    'port' => 389,
    'uid' => 'sAMAccountName',
    'encryption' => 'plain',
    'base' => 'dc=kendopz,dc=com',
    'bind_dn' => 'cn=VMADMIN,cn=Users,dc=kendopz,dc=com',
    'password' => 'Password1'
  }
}

gitlab_rails['omniauth_providers'] = [
  {
    name: "github",
    label: "GitHub", # optional label for login button, defaults to "GitHub"
    app_id: "715cd79460c614394d0a",
    app_secret: "efdde5aed70bbe89456e8fc518468f6d8144f602",
    url: "https://github.com/",
    verify_ssl: false,
    args: { scope: "user:email" }
  }
]

gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.gmail.com"
gitlab_rails['smtp_port'] = 587
gitlab_rails['smtp_user_name'] = "zlmhkveg375@gmail.com"
gitlab_rails['smtp_password'] = "Hd!diVdhjdvk"
gitlab_rails['smtp_domain'] = "smtp.gmail.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
gitlab_rails['smtp_tls'] = false
...
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'

gitlab_rails['gitlab_email_from'] = 'gitlab@kendopz.com'
gitlab_rails['gitlab_email_reply_to'] = 'noreply@kendopz.com'
environment = ["GIT_SSL_NO_VERIFY=true"]