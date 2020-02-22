colorConverter={}

----
-- Function to manage color format between love versions
----
colorConverter.setColor = function(r,g,b,a)
   if( config.colorAsFloat) then
        love.graphics.setColor(r/255, g/255, b/255, a/255)
   else
        love.graphics.setColor(r,g,b,a)
   end
end

----
-- Function to manage background color format between love versions
----
colorConverter.setBackgroundColor = function(r,g,b,a)
     if( config.colorAsFloat) then
          love.graphics.setBackgroundColor(r/255, g/255, b/255, a/255)
     else
          love.graphics.setBackgroundColor(r,g,b,a)
     end
end