def names(*names)
  array = *names

  if array.length % 2 != 0
    random_pairs = array.shuffle.each_slice(2).to_a
    random_pairs[0] << random_pairs.last[0]
    random_pairs.pop
  else
    random_pairs = array.shuffle.each_slice(2).to_a
  end

  return random_pairs
end
