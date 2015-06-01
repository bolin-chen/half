root = exports ? @

# FS.debug = true

# imageStore = new FS.Store.GridFS 'images'
imageStore = new FS.Store.FileSystem("images", {path: "./../../../../../uploads"})

root.Images = new FS.Collection 'images', { stores: [imageStore] }

# Images 用于存放图片

#-------------------------------------------------

root.Votes = new Mongo.Collection 'votes'

# Votes中的document的格式
# {
#   title: string (代表投票的标题) 验证
#   initiator: string (引用自UserInfo中的username，代表投票的发起者)
#   category: categ0 - cate6 (代表投票的类别,
#               分别为商标设计,图标设计,软件设计,网页设计,服装设计,照片,其他)
#   isOpen: bool (投票是否开放，当投票为开放时才能进行投票，status 可由发起者进行修改)
#   modifyDate: Date (最后一次修改的日期)
#   firstUrl: string (第一张图票的url)
#   secondUrl: string
#   firstImaegId: string
#   secondImageId: string
#   firstDescription: string (第一张图片的描述) 验证
#   secondDescription: string  验证
#   question: string (最小长度为15，代表用户提出的问题)  验证
#   numOfFirst: int (代表选择第一张图的票数)
#   numOfSecond: int (代表选择第二张图的票数)
#
#   reportNum: int (被举报的次数)
#
#   statisticsOfFirst: {
#     gender: {
#       male: int
#       female: int
#     } (分别代表投票的男性数量和女性数量)
#
#     age: {
#       0-20: int
#       21-30: int
#       31-40: int
#       41-50: int
#       50+: int
#
#     } (分别代表投票的不同年龄段的数量）
#
#     occupation: {
#       occup0: int
#       occup1: int
#       occup2: int
#       occup3: int
#       occup4: int
#       occup5: int
#       occup6: int
#       occup7: int
#       occup8: int
#       occup9: int
#
#     } (分别代表投票的10种不同的已定义职业的数量,
# 这10种职业依次为互联网科技，金融，信息传媒，教育，医疗卫生，服务业，地产建筑，国家机关，农林牧鱼，制作加工）
#
#} (对象，代表第一张图片的投票统计数据)
#
#   statisticsOfSecond: {
#     gender: {
#       male: int
#       female: int
#     } (分别代表投票的男性数量和女性数量)
#
#     age: {
#       group0: int   (0-20)
#       group1: int   (21-30)
#       group2: int   (31-40)
#       group3: int   (41-50)
#       group4: int   (50+)
#
#     } (分别代表投票的不同年龄段的数量）
#
#     occupation: {
#       occup0: int
#       occup1: int
#       occup2: int
#       occup3: int
#       occup4: int
#       occup5: int
#       occup6: int
#       occup7: int
#       occup8: int
#       occup9: int
#
#     } (分别代表投票的10种不同的已定义职业的数量,
# 这10种职业依次为互联网科技，金融，信息传媒，教育，医疗卫生，服务业，地产建筑，国家机关，农林牧鱼，制作加工）
#
#} (对象，代表第一张图片的投票统计数据)

#-------------------------------------------------

root.Comments = new Mongo.Collection 'comments'

# Comments中的document的格式
# {
#   voteId: string (投票项目的id)
#   username: string (发表该评论的用户)
#   content: string(评论内容)  验证
# }

#-------------------------------------------------

root.Ballots = new Mongo.Collection 'ballots'

# Ballots中的document的格式
# {
#   voteId: string (投票项目的id)
#   choice: first or second (选择第一张图片还是第二张图片)
#   username: string (发起该投票的用户的用户名)
# }

#-------------------------------------------------

root.Follows = new Mongo.Collection 'follows'

# Follows中的document的格式
# {
#   username: string (被关注的用户的用户名)
#   follower: [] (关注者的用户名)
# }

#-------------------------------------------------

root.Reports = new Mongo.Collection 'reports' # 举报记录

# Reports中的document的格式
# {
#   voteId: string (投票项目的id)
#   username: string (进行举报的用户的用户名)
# }

#-------------------------------------------------

# Users中的document的格式
# {
#   username: string  验证
#   password: string  验证
#   profile = {
#     nickname: string (可以重复)  验证
#     gender: male or female（0代表男，1代表女）
#     age: int  验证
#     occupation: occup0 - occup9 (代表已经定义的10个职业，
  #     分别为互联网科技，金融，信息传媒，教育，医疗卫生，服务业，地产建筑，国家机关，农林牧鱼，制作加工)
#     avatar: string (引用自Image中的url,代表头像)
#     avatarId: string (头像所用图片在Images中的id)
#   }
# }