Template['initiate'].helpers {

}

Template['initiate'].events {
  'change input[name=firstImage]': (event)!->
    image-preview event.target, $ '#initiate .firstPreview'

  'change input[name=secondImage]': (event)!->
    image-preview event.target, $ '#initiate .secondPreview'

  'submit form.initiateVote': (event)->
    event.prevent-default!
    new-vote = construct-vote-doc event.target
    Votes.insert new-vote

    Router.go '/'
}

construct-vote-doc = (form)-> #用form里的值构造新插入Vote的document
  first-file = form.firstImage .files .0
  second-file =form.secondImage .files .0

#-------------------------------------------

  #reference: https://github.com/CollectionFS/Meteor-CollectionFS/issues/323#issuecomment-70388949

  first-image = Images.insert first-file, (err, image)!-> # 该回调函数用于实时更新图片
      cursor = Images.find image._id

      liveQuery = cursor.observe {
        changed: (newImage, oldImage)!-> if url = newImage.url!
          vote = Votes.find-one firstImageId: newImage._id
          Votes.update vote._id, $set: firstUrl: url

          liveQuery.stop!
      }

  second-image = Images.insert second-file, (err, image)!->
      cursor = Images.find image._id

      liveQuery = cursor.observe {
        changed: (newImage, oldImage)!-> if url = newImage.url!
          vote = Votes.find-one secondImageId: newImage._id
          Votes.update vote._id, $set: secondUrl: url

          liveQuery.stop!
      }


#------------------------------------------

  new-vote = {
    title: form.title.value
    initiator: Meteor.user!.username
    category: form.category.value
    status: 'open'
    modifyDate: new Date!

    firstUrl: '/uploading.jpg' # first-image .url {brokenIsFine: true}
    secondUrl: '/uploading.jpg' # second-image .url {brokenIsFine: true}
    firstImageId: first-image._id
    secondImageId: second-image._id
    firstDescription: form.firstDescription.value
    secondDescription: form.secondDescription.value

    question: form.question.value

    numOfFirst: 0
    numOfSecond: 0

    reportNum: 0

    statisticsOfFirst: {
      gender: []
      age: []
      occupation: []
    }
    statisticsOfSecond: {
      gender: []
      age: []
      occupation: []
    }

  }

image-preview = (input, image-selector)!-> if input.files and input.files[0]
  reader = new FileReader!;
  reader.readAsDataURL input.files[0]

  reader.onload = (e)!->
    image-selector .attr 'src', e.target.result
