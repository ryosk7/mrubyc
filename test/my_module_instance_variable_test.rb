module MyModuleIvar1
  def self.set(v)
    @iv = v
  end

  def self.get
    @iv
  end
end

module MyModuleIvar2
  def self.m1; 1; end
  def self.m2; 2; end
  def self.m3; 3; end
  def self.m4; 4; end
  def self.m5; 5; end

  def self.set(v)
    @iv = v
  end
end

module MyModuleIvar3
  class << self
    attr_accessor :av
  end

  def self.m1; 1; end
end

class MyModuleInstanceVariableTest < Picotest::Test

  description 'instance variable of a module'
  def test_set_and_get
    assert_equal nil, MyModuleIvar1.get
    MyModuleIvar1.set(123)
    assert_equal 123, MyModuleIvar1.get
    MyModuleIvar1.set("abc")
    assert_equal "abc", MyModuleIvar1.get
  end

  description 'setting one keeps the module methods'
  def test_methods_survive
    MyModuleIvar2.set(456)
    assert_equal [1,2,3,4,5], [MyModuleIvar2.m1, MyModuleIvar2.m2, MyModuleIvar2.m3,
                               MyModuleIvar2.m4, MyModuleIvar2.m5]
  end

  description 'attr_accessor on a module'
  def test_attr_accessor
    assert_equal nil, MyModuleIvar3.av
    MyModuleIvar3.av = 789
    assert_equal 789, MyModuleIvar3.av
    assert_equal 1, MyModuleIvar3.m1
  end
end
