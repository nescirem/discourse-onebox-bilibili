# name: discourse-onebox-bilibili
# about: 为 Discourse Onebox 增加了 bilibili 视频支持
# version: 0.0.2
# authors: MuZhou233
# url: https://github.com/MuZhou233/discourse-onebox-bilibili

# modified by nescirem
# url: https://github.com/nescirem/discourse-onebox-bilibili 

Onebox = Onebox


module Onebox
   module Engine
     class BilibiliOnebox
       include Engine
       include HTML
       
       REGEX = /^https?:\/\/(?:www\.)?bilibili\.com\/video\/([a-zA-Z0-9]+)\/?$/
       matches_regexp REGEX

       def video_id
         match = @url.match(/\/video\/av(\d+)\?.*/)
         return "aid=#{match[1]}" if match && match[1]
         match = @url.match(/\/video\/BV([a-zA-Z0-9]+)\?.*/)
         return "bvid=#{match[1]}" if match && match[1]

         nil
       # rescue
       #   return nil
       end

       def to_html
         <<-HTML
           <iframe 
             src='https://player.bilibili.com/player.html?#{video_id}&page=1' 
             scrolling="no" 
             border="0" 
             frameborder="no" 
             framespacing="0" 
             width='640' 
             height='430' 
             allowfullscreen='true'></iframe>
         HTML
       end
     end
   end
end
