## 前端合并代码的建议
  * 下载最新的分支并解压
  * 将你负责的文件夹复制进最新的分支文件夹
  * 尽量避免未经允许修改其他队员负责的部分并pull上来，以免带来麻烦

## 设计方案投票网站 ##

具备功能：
  * 注册登录，查看用户信息，修改用户信息，拉用户进黑名单，用户关注
  * 发起投票，查看投票详情，投票数据统计，投票功能，发表评论，投票项目排序
  * 举报，修改，关闭，删除，分类查看投票项目


投票功能暂时只能在detail页面进行，以后才改进，而当投票项目关闭时，用户无法对该项目进行投票

用户关注功能：关注某一用户后，可在“/followingvote”页面(路径/->/profile->/followingvote)查看
所关注用户新发起的投票项目，该页面最多只显示30条投票项目，且投票项目被删除后则不会在此页面显示

网站暂时不设权限控制，以方便开发调试

## 开发规范 ##
同一页面代码放在同一文件夹内
（如detil页面的jade文件，sass文件和ls文件都放在detail文件夹内，而不允许在其他文件夹修改detail页面）

## 将要进行的工作 ##
前端：界面美化，添加验证规则

后端：匹配前端进行界面处理

