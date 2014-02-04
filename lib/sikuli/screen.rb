# A Screen object defines a special type of Sikuli::Region that represents
# the entire screen.
#
# TODO: Test the Screen object with multiple monitors attached.
#
module Sikuli
  class Screen < Region

    # Public: creates a new Screen object
    #
    # Examples
    #
    #   screen = Sikuli::Screen.new
    #
    # Returns the newly initialized Screen object
    def initialize
      @java_obj = org.sikuli.script::Screen.new()
    end


    def capture(*args)
      @java_obj.capture(*args)
    end

    def captureRawDigest(x,y,w,h)
      img = capture(x,y,w,h)
      #puts v.java_class.declared_instance_methods
      buffer = img.getImage.getRaster.getDataBuffer
      #puts 'number of banks',b.getNumBanks
      data = Array.new
      j=0
      while j < buffer.getNumBanks
        data.push(buffer.getData(j))
        j+=1
      end

      Digest::MD5.hexdigest(data.join)
    end

    def captureDigest(x,y,w,h)
      digest = captureRawDigest(x,y,w,h)

      'DIGEST:{x=%s,y=%s,w=%s,h=%s}[%s]'% [x,y,w,h,digest]
    end
  end

end