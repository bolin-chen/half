Template['editprofile'].helpers {
  profile: -> if Meteor.user! then Meteor.user! .profile
}

Template['editprofile'].events {
  'change input[type=file]': (event)!-> image-preview event.target, $ '.avatar img'


  'submit form.editprofile': (event)!->
    event.preventDefault!

    Meteor.users.update Meteor.userId!, {
      $set:
        'profile.nickname': event.target.nickname.value
        'profile.gender': event.target.gender.value
        'profile.age': event.target.age.value
        'profile.occupation': event.target.occupation.value
    }

    updateAvatar (event.target.avatar.files .0)

    Router.go ('/profile/' + Meteor.user! .username)
}

image-preview = (input, image-selector)!-> if input.files and input.files[0]
  reader = new FileReader!;
  reader.readAsDataURL input.files[0]

  reader.onload = (e)!->
    image-selector .attr 'src', e.target.result

updateAvatar = (avatarFile)!-> if avatarFile
  Images.insert avatarFile, (err, image)!->
    cursor = Images.find image._id
    userId = Meteor.userId!

    liveQuery = cursor.observe {
      changed: (newImage, oldImage)!-> if url = newImage.url!
        oldAvatarId = Meteor.user!.profile.avatarId
        Images.remove oldAvatarId

        Meteor.users.update userId,{
          $set:
            'profile.avatarUrl': url
            'profile.avatarId': newImage._id
        }

        liveQuery.stop!
    }