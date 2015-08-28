#!/usr/bin/env ruby

GENERATION = [9, 10, 21, 20, 7, 11, 4, 15, 7, 7, 14, 5, 20, 6, 29, 8, 11, 19, 18, 22, 29, 14, 27, 17, 6, 22, 12, 18, 18, 30]
OVERHEAD = [21, 16, 19, 26, 26, 7, 1, 8, 17, 14, 15, 25, 20, 3, 24, 5, 28, 9, 2, 14, 9, 25, 15, 13, 15, 9, 6, 20, 27, 22]
BUDGET = 2912
MAX_CARDS = GENERATION.length

def card_time( generation_time, overhead_time, cards_in_final_set )
  generation_time + ((cards_in_final_set - 1) * overhead_time)
end

def card_times_for_final_set_n( cards_in_final_set )
  (0...MAX_CARDS).map { |i|
    card_time( GENERATION[i], OVERHEAD[i], cards_in_final_set )
  }.sort.slice(0,cards_in_final_set).inject(:+)
end

def card_times_for_all_final_set_sizes
  Hash[(1..MAX_CARDS).map { |cards_in_final_set|
    [cards_in_final_set, card_times_for_final_set_n(cards_in_final_set)]
  }]
end

def max_cards_in_final_set_under_budget( budget )
  card_times_for_all_final_set_sizes.reject{ |k,v| v > budget }.max_by{ |k,v| v }.first
end

puts max_cards_in_final_set_under_budget( BUDGET )
