require 'benchmark'

def insertion_sort(arr)
  arr.each_with_index do |ele, i|
    insert(arr, i-1, ele)
  end
  arr
end

def insert(array, right_index, value)
    # value is the value of array[right_index + 1]
    # right_index is the furthest right sorted element

    # Step through sorted elements right to left.
    # As long as your value is less than the element
    # at array[i] and you still have elements
    i = right_index
    while(i >= 0 && array[i] > value)
        # copy the element
        array[i+1] = array[i]
        i -= 1
    end
    # insert the actual element
    array[i+1] = value;
end


def bubble_sort(arr)
  swap = false
  arr.each_with_index do |ele, i|
    swap = false
    (arr.length-1-i).times do |j|
      if arr[j] > arr[j+1]
        #arr[j], arr[j+1] = arr[j+1], arr[j]
        tmp = arr[j]
        arr[j] = arr[j+1]
        arr[j+1] = tmp
        swap = true
      end
      print [i, j]
    end
    break unless swap
  end
  arr
end

def merge_sort(arr)
  if arr.length == 1 #|| arr.empty?
    return arr
  else
    arr1 = merge_sort(arr[0..(arr.length/2 - 1)])
    arr2 = merge_sort(arr[(arr.length/2)..-1])
  end
  merge(arr1,arr2)
end

def merge(arr1, arr2)
  result = []
  until arr1.empty? || arr2.empty?
    if arr1[0] > arr2[0]
      result  << arr2.shift
    else
      result << arr1.shift
    end
  end
  result.concat(arr1).concat(arr2)
end


def benchmark(arr=(0..100).to_a)

  iterations = 1000

  Benchmark.bm(7) do |x|
    puts "Random"
    x.report("insertion_sort:")   { suppress_output { iterations.times { insertion_sort(arr.shuffle) } } }
    x.report("bubble_sort:")   { suppress_output { iterations.times { bubble_sort(arr.shuffle) } } }
    x.report("merge_sort:")   { suppress_output { iterations.times { merge_sort(arr.shuffle) } } }

    puts "Worse case"
    x.report("insertion_sort:")   { suppress_output { iterations.times { insertion_sort(arr.reverse) } } }
    x.report("bubble_sort:")   { suppress_output { iterations.times { bubble_sort(arr.reverse) } } }
    x.report("merge_sort:")   { suppress_output { iterations.times { merge_sort(arr.reverse) } } }
  end

end


def suppress_output
  begin
    original_stderr = $stderr.clone
    original_stdout = $stdout.clone
    $stderr.reopen(File.new('/dev/null', 'w'))
    $stdout.reopen(File.new('/dev/null', 'w'))
    retval = yield
  rescue Exception => e
    $stdout.reopen(original_stdout)
    $stderr.reopen(original_stderr)
    raise e
  ensure
    $stdout.reopen(original_stdout)
    $stderr.reopen(original_stderr)
  end
  retval
end

def quick_sort(arr, pivot_index = 0)
  if arr.length < 2
    return arr
  else
    pivot_index = partition_array_2(arr)
    #quick_sort(arr[0..pivot_index-1], pivot_index)
    quick_sort(arr[pivot_index+1..-1], pivot_index)
  end
end

def partition_array(arr, pivot_index = 0)
  wall = 0  #we either change the wall and move it forward, or we start from a smaller array
  pivot = arr[-1]
  puts pivot  #= 53
  (0..(arr.length-1)).each do |i|
    if arr[i] < pivot    #4<53
      #arr[wall], arr[i] = arr[i], arr[wall]
      wall += 1
      p [arr[wall], arr[i]]
    else
      hold = arr[i]
      arr[i] = arr[wall]
      arr[wall] = hold
    end
  end
    #p arr
    #arr[wall+1], arr[-1] = arr[-1], arr[wall+1]
    #puts arr[wall]
    pivot_index = wall
end


def partition_array_2(arr)
  wall = 0
  pivot = arr[-1]
  arr.each_with_index do |current_element, i|
    if current_element < pivot
      current_element, arr[wall] = arr[wall], current_element
      wall +=1
      p wall
      p arr
      p current_element
    elsif current_element == pivot
      current_element, arr[wall] = arr[wall], current_element
      # move the wall down
      wall +=1
      p wall
      p current_element
    end
  end
    #p arr
    #arr[wall+1], arr[-1] = arr[-1], arr[wall+1]
    #puts arr[wall]
  wall
end

# 1. Pick pivot (last element)
# 2. Partition: move pivot to approx. the middle and get index and move smaller values to left of pivot
# 3. Recursively call quick_sort on the first portion (all values smaller index than pivot)
# 4. Recursively call quick_sort on the second portion and move values to the left of pivot








