# develop-env

This a project to record how to build some develop environment.

1. add nginx-mod_h264, this script show how to build nginx_mod_h264_streaming module to nginx. add some logs to the module, add pcre to it.

2. add nginx-ffmpeg-rtmp,  empty path, to be edit.

3. add nginx-lua, empty path, to be edit.

4. add nginx-pcre, edit and test ok.

5. add httpd-build, empty path, to be edit.

6. add nginx-zlib empty path, to be edit.

7. add nginx-openssl empty path, to be edit.

8. add gtest-build

# We do not need to add RSA key to github, We just need git config use.name/mail. and modify .git/config
#git config  user.name  qiuzhenguang
#git config  user.email  "qiuzhenguang@163.com"   


.git/config
[remote "origin"]
    fetch = +refs/heads/*:refs/remotes/origin/*
    url = https://qiuzhenguang@github.com/qiuzhenguang/develop-env.git
github.com ---> qiuzhenguang@github.com


test branch foo/bar

How to use git cherry-pick ?
just git checkout master
git cherry-pick 7299940782addfbf01edfddbe7e6e2a88305c8a1
git add ...
git commit ...
git push ...
