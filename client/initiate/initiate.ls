Template['initiate'].onRendered !->
  check-form!

Template['initiate'].helpers {

}

Template['initiate'].events {
  'change input[name=firstImage]': (event)!->
    image-preview event.target, $ '#initiate .firstPreview'

  'change input[name=secondImage]': (event)!->
    image-preview event.target, $ '#initiate .secondPreview'

  'submit form.initiate': (event)->
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
# 初始化统计数据

  gender = {
    male: 0
    female: 0
  }

  age = {
    group0: 0  # '0-20'
    group1: 0  # '21-30'
    group2: 0  # '31-40'
    group3: 0  # '40-50'
    group4: 0  # '50+'
  }

  occupation = {
    occup0: 0
    occup1: 0
    occup2: 0
    occup3: 0
    occup4: 0
    occup5: 0
    occup6: 0
    occup7: 0
    occup8: 0
    occup9: 0
  }

#--------------------------------------------
# 返回新构建的vote document

  new-vote = {
    title: form.title.value
    initiator: Meteor.user!.username
    category: form.category.value
    isOpen: true
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
      gender: gender
      age: age
      occupation: occupation
    }
    statisticsOfSecond: {
      gender: gender
      age: age
      occupation: occupation
    }

  }

image-preview = (input, image-selector)!-> if input.files and input.files[0]
  reader = new FileReader!;
  reader.readAsDataURL input.files[0]

  reader.onload = (e)!->
    image-selector .attr 'src', e.target.result

#验证发起投票的表单
check-form =!->
  console.log 'check-form'
  $ '#initiate .ui.form.segment.initiate' .form({
    title: {
      identifier: 'title'
      rules: [{
        type: 'empty'
        prompt: 'empty title'   #可以在这里添加提示（暂时不能显示，将会解决）
      }]
    },
    fDescription: {
      identifier: 'firstDescription'
      rules: [{
        type: 'empty'
      }]
    },
    secondDescription: {
      identifier: 'secondDescription'
      rules: [{
        type: 'empty'
      }]
    },
    question: {
      identifier: 'question'
      rules: [{
        type: 'empty'
      }]
    }})