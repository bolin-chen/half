
# Images.on 'stored', (fileObj, storeName)!->
#   console.log "Images stored"
#   a = @find fileObj._id .fetch .0
#   console.log @
#   # console.log fileObj.url!

#   # console.log image#ote.title
#   console.log '------------------'
#   console.log storeName
#   console.log '------------------'


# Meteor.users.allow {
#   update: (userId, doc, fields, modifier)->
#     unless doc.owner is userId then return false

#     for key in fields # 将 Meteor.User 中的 emails 和 profile 字段设为在客户端可修改
#       if key isnt 'emails' and key isnt 'profile'
#         return false

#     true
# }

# Accounts.onCreateUser (options, user)-> # 设置 user 中  profile 的默认值
#   user.profile = {
#   nickname: string (可以重复)
#   gender: M or F (即male or female)
#   age: int
#   occupation: string (从已定义的职业中选择)
#   avatar: string (引用自Image中的url,代表头像)
#   }

#   user

#---------------------------------------------------------

# Meteor.publish 'Images', -> Images.find!
# Meteor.publish 'Votes', -> Votes.find!

#---------------------------------------------------------

# Images.allow {
#   insert: (userId, doc)-> true
#   update: (userId, doc, fields, modifier)-> true
#   remove: (userId, doc)-> true
# }


# Votes.allow {
#   insert: (userId, doc)-> true
#   update: (userId, doc, fields, modifier)-> true
#   remove: (userId, doc)-> true
# }
