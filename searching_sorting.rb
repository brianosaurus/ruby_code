#!/usr/bin/env ruby

def merge_sort(arr)
  return arr if array.length <= 1

  # slice
  mid = arr.length / 2
  left = merge_sort(arr[0...length])
  right = merge_sort(arr[length..-1])

  # sort/merge
  new_arr = []
  offset_l = 0
  offset_r = 0


  while offset_l < left.length && offset_r < right.length
    l = left[offset_l]
    r = right[offset_r]

    if l <= r
      new_arr << l
      offset_l += 1
    else
      new_arr << r
      offset_r += 1
    end
  end

  while offset_l < left.length
    new_arr << left[offset_l]
    offset_l += 1
  end

  while offset_r < right.length
    new_arr << right[offset_r]
    offset_r += 1
  end

  return arr
end


def quick_sort(array, from=0, to=nil)
  if to.nil?
    # sort the entire array (starting point)_
    to = array.length -1
  end

  if from >= to
    # done
    return
  end

  # pivot from the far left
  pivot = array[from]

  # min/max ptrs
  min = from
  max = to

  # current free slot
  free = min

  while min < max
    if free == min
      if array[max] <= pivot # smaller than pivot, move
        array[free] = array[max]
        min += 1
        free = max
      else
        max -= 1
      end
    elsif free == max # evaluate array[min]
      if array[min] >= pivot # must move ... bigger than pivot
        array[free]= array[min]
        max -= 1
        free = min
      else
        min += 1
      end
    else
      raise 'Bad State'
    end
  end

  array[free] = pivot

  quick_sort(array, from, free - 1)
  quick_sort(array, free + 1, to)
end

def merge_sorted_arrays(arr1, arr2)
  index1 = 0
  index2 = 0
  result = []

  while index1 < arr1.length && index2 < arr2.length
    if arr1[index1] <= arr2[index2]
      result << arr1[index1]
      index1 += 1
    elsif arr2[index2] < arr1[index1]
      result << arr2[index2]
      index2 +=1
    end
  end

  while index1 < arr1.length
    result << arr1[index1]
    index1 += 1
  end

  while index2 < arr2.length
    result << arr1[index2]
    index2 += 1
  end

  return result
end


arr1 = [1,3,5,7,9]
arr2 = [2,4,6,8]

puts 'Merge sorted arrays'
puts merge_sorted_arrays(arr1, arr2).join(' ')


