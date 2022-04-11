require "byebug"

class Array

    def my_each(&prc)
     i = 0

     while i < self.length
        prc.call(self[i])
        i += 1
     end 
     self
    end

    def my_select(&prc)
        new_arr = []
        self.my_each do |el|
            new_arr << el if prc.call(el)
        end
        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        self.my_each do |el|
            new_arr << el if !prc.call(el)
        end
        new_arr
    end

    def my_any?(&prc)
        
        self.my_each do |el|
            if prc.call(el) == true
                return true
            end
        end
        false
    end

    def my_all?(&prc)

        self.my_each do |el|
            if prc.call(el) == false
                return false
            end
        end
        true
    end

    def my_flatten
        flattened = []
        self.my_each do |ele|
            if ele.is_a?(Array)
                flattened += ele.my_flatten
            else 
                flattened << ele
            end
        end
        flattened
    end

    def my_zip(*args)
        new_arr = Array.new(self.length) { Array.new(args.length + 1) }
        args = [self] + args
        #debugger
        (0...args.length).each do |i|
            (0...self.length).each do |j|
                new_arr[j][i] = args[i][j]
            end
        end
        new_arr
    end

    def my_rotate(num = 1)
        arr = self.dup
        num.abs.times do
            if num > 0
                arr = arr[1..-1] + [arr[0]]
            else
                arr = [arr[-1]] + arr[0..-2]
            end
        end
        arr
    end

    def my_join(sep = '')
        str = ''
        self.my_each do |el|
            str += el + sep
        end
        if str[-1] == sep
            str[-1] = ''
        end
        str
    end

    def my_reverse
        new_arr = []
        i = self.length - 1
        while i >= 0
            new_arr << self[i]
            i -= 1
        end
        new_arr
    end

end

#a = [ "a", "b", "c", "d" ]
#p a.my_rotate         #=> ["b", "c", "d", "a"]
#p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
#p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
#p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

#p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
#p [ 1 ].my_reverse               #=> [1]