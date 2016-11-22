# baisiqijie
高度仿写百思不得姐项目，实现精华，新帖，发布，关注，我的五大功能模块，运用了很多技术。 使用技术：MVC设计模式，使用纯代码和Xib混合开发，AutoLayout做UI布局，首页精华模块充分使用父子控制器，音频视频的播放，评论详情界面，发布集成pop动画，关注界面充分利用Xib的优势，使用SDWebImage进行图片加载，SVProessHUD进行遮盖提示，清除缓存功能，UIWebView进行网页加载等技术
通过点击来切换小模块
![baisi.gif](http://upload-images.jianshu.io/upload_images/2406962-ec0c8eeb24c2ed6a.gif?imageMogr2/auto-orient/strip)
通过手势滑动来切换小模块
![allhahha.gif](http://upload-images.jianshu.io/upload_images/2406962-19c7f473898373a1.gif?imageMogr2/auto-orient/strip)

查看每个不同的cell的评论
![zz.gif](http://upload-images.jianshu.io/upload_images/2406962-645190610c76607f.gif?imageMogr2/auto-orient/strip)
![Snip20161115_1.png](http://upload-images.jianshu.io/upload_images/2406962-cd8eaff24dd5059d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![Snip20161115_2.png](http://upload-images.jianshu.io/upload_images/2406962-983b7fbe63e8af2e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![Snip20161115_3.png](http://upload-images.jianshu.io/upload_images/2406962-c2efd9c8a2d409c0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

其中这里面的所有视频，所有音频都是可以播放的,包括点击进入评论页面，视频音频都是可以播放的，然后那个，有些评论是声音评论也是可以播放的
![videoh.gif](http://upload-images.jianshu.io/upload_images/2406962-5871055e7512384d.gif?imageMogr2/auto-orient/strip)
![voice.gif](http://upload-images.jianshu.io/upload_images/2406962-efb450f6d05a49de.gif?imageMogr2/auto-orient/strip)
###再看一下最新模块
你会发现最新模块和精华模块是不是一样呢，最新的模块的数据是用户最新发表的动态，和精华模块确实是很相似,所有使用了继承
![baisiq.gif](http://upload-images.jianshu.io/upload_images/2406962-d2c85c04b83b40e0.gif?imageMogr2/auto-orient/strip)
######最新模块里面的评论
![baisiqi.gif](http://upload-images.jianshu.io/upload_images/2406962-fa51d8e9e965b84c.gif?imageMogr2/auto-orient/strip)
#####最新模块里面的图片模块
这里会显示加载图片进度，普通图、动态和超大图片都可以查看，也可以保存图片到本地相机。
######加载图片
![baisf.gif](http://upload-images.jianshu.io/upload_images/2406962-a44b47b45353bda7.gif?imageMogr2/auto-orient/strip)

######查看大图，包括普通图片，超长图片，动态图片
![picture.gif](http://upload-images.jianshu.io/upload_images/2406962-101245a02cfe1cd0.gif?imageMogr2/auto-orient/strip)
######保存图片到本地相册，这里因为只能上传5M以内的图，我就分开上传
![save.gif](http://upload-images.jianshu.io/upload_images/2406962-fbfc703e558a3fca.gif?imageMogr2/auto-orient/strip)
![savesz.gif](http://upload-images.jianshu.io/upload_images/2406962-bd829c71428bedcf.gif?imageMogr2/auto-orient/strip)


###发表模块
```
这个主要使用了第三方pop 和 POP+MCAnimate 这两个库，同样自定义了按钮
```
![pop.gif](http://upload-images.jianshu.io/upload_images/2406962-c9eb46593c14c35c.gif?imageMogr2/auto-orient/strip)

###关注模块
这里需要登录，做了个简单的页面，因为拿不到百思不得姐的全套接口，不知道它是如何加密等等情况
```
这里主要用到的技术:给UITextfield封装了一个占位文字颜色的功能，自定义按钮。使用Xib布局UI界面
```
![attentio.gif](http://upload-images.jianshu.io/upload_images/2406962-d8c44787a79390f3.gif?imageMogr2/auto-orient/strip)
###我的模块
######查看软件的缓存，清除缓存
```
这里主要用的技术：这里的UITableView的采用了分组，使得一个cell单独出来。自定义UITableView的footView 然后使用九宫格排布footView的自定义按钮，不是使用UIcollectionView。点击可以跳转到网页，网页页面，做了个工具条，可以前进下一页，回退上一页，以及刷新。自己封装了一个查看文件大小，清除缓存的功能。（因为我们的缓存可能是我们自己产生的，也可能是SDWebImage产生的，所以自己封装了一个把所有缓存都清理）
```
![mineu.gif](http://upload-images.jianshu.io/upload_images/2406962-d455e9e133e7c1a0.gif?imageMogr2/auto-orient/strip)
