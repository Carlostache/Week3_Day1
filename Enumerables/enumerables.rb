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
        debugger
        (0...args.length).each do |i|
            (0...self.length).each do |j|
                new_arr[j][i] = args[i][j]
            end
        end
        new_arr
    end


end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p[1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p[1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]
