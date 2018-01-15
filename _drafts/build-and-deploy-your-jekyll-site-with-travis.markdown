13:24 $ travis encrypt-file deploy_rsa --add
encrypting deploy_rsa for janosrusiczki/janosrusiczki
storing result as deploy_rsa.enc
storing secure env variables for decryption
not logged in - try running travis login --org

If on the same server / user use the following to add the authorized key
13:31 $ cat deploy_rsa.pub >> ~/.ssh/authorized_keys

✔ ~/janosrusiczki [master|✚ 1…3]
13:47 $ travis encrypt DEPLOY_DIRECTORY=<deploy directory> --add
✔ ~/janosrusiczki [master|✚ 1…3]
13:50 $ travis encrypt DEPLOY_HOST=<deploy host> --add
✔ ~/janosrusiczki [master|✚ 1…3]
13:50 $ travis encrypt DEPLOY_USER=<deploy user> --add

before_deploy:
  - echo -e "Host heroku.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
  - echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
