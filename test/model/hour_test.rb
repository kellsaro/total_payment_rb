require "minitest/autorun"
require_relative "hour_min"

class HourMinTest < Minitest::Test
  def test_can_create_hour_min_objects
    hm = HourMin.new("00:00")
    expected = "00:00"
    assert_equal expected, hm.to_s
    assert_equal 0, hm.hour
    assert_equal 0, hm.minute

    hm = HourMin.new("23:46")
    expected = "23:46"
    assert_equal expected, hm.to_s
    assert_equal 23, hm.hour
    assert_equal 46, hm.minute

    hm = HourMin.new("00:61")
    expected = "00:01"
    assert_equal expected, hm.to_s
    assert_equal 0, hm.hour
    assert_equal 1, hm.minute

    hm = HourMin.new("24:61")
    expected = "00:01"
    assert_equal expected, hm.to_s
    assert_equal 0, hm.hour
    assert_equal 1, hm.minute

    hm = HourMin.new("27:61")
    expected = "03:01"
    assert_equal expected, hm.to_s
    assert_equal 3, hm.hour
    assert_equal 1, hm.minute
  end

  def test_returns_the_right_successor
    hm = HourMin.new("23:46")
    hm_succ = hm.succ
    expected = "23:47"
    assert_equal expected, hm_succ.to_s
    assert_equal 23, hm_succ.hour
    assert_equal 47, hm_succ.minute
    assert_equal -1, hm <=> hm_succ
    assert_equal 1, hm_succ <=> hm

    hm = HourMin.new("23:59")
    hm_succ = HourMin.new("23:59").succ
    expected = "00:00"
    assert_equal expected, hm_succ.to_s
    assert_equal 0, hm_succ.hour
    assert_equal 0, hm_succ.minute
    assert_equal 1, hm <=> hm_succ
    assert_equal -1, hm_succ <=> hm

    hm = HourMin.new("23:59")
    hm_succ = hm.succ.succ
    expected = "00:01"
    assert_equal expected, hm_succ.to_s
    assert_equal 0, hm_succ.hour
    assert_equal 1, hm_succ.minute
    assert_equal 1, hm <=> hm_succ
    assert_equal -1, hm_succ <=> hm

    hm = HourMin.new("12:59")
    hm_succ = hm.succ
    expected = "13:00"
    assert_equal expected, hm_succ.to_s
    assert_equal 13, hm_succ.hour
    assert_equal 0, hm_succ.minute
    assert_equal -1, hm <=> hm_succ
    assert_equal 1, hm_succ <=> hm
  end

  def test_equality
    h1 = HourMin.new("23:59")
    h2 = HourMin.new("23:59")
    assert_equal h1, h2

    h1 = HourMin.new("00:00")
    h2 = HourMin.new("00:00")
    assert_equal h1, h2
  end

  def test_comparison
    h0 = HourMin.new("20:00")
    h1 = HourMin.new("23:59")
    h2 = HourMin.new("00:00")
    h3 = HourMin.new("12:00")

    assert h0 < h1
    assert_equal h1.succ, h2
    assert h2 < h1
    assert h2 < h3
    assert h3 < h0
  end

  def test_can_create_ranges_of_hour_min
    h0 = HourMin.new("20:00")
    h1 = HourMin.new("23:59")

    r = (h0..h1)

    assert r

    assert r.include?(HourMin.new("20:00"))
    assert r.include?(HourMin.new("23:59"))
    assert r.include?(HourMin.new("21:00"))
    refute r.include?(HourMin.new("19:59"))
    refute r.include?(HourMin.new("00:00"))

    r = (HourMin.new("23:58")..HourMin.new("00:02"))
    hours = ["23:58", "23:59", "00:00", "00:01", "00:02"]
    hours.each { |h| assert r.include?(HourMin.new(h)) }
  end
end
